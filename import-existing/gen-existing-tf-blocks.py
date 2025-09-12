#!/usr/bin/env python3
import json, os, re, subprocess, sys

# Paths
INVENTORY_FILE = "../existing-inventory/inventory.json"
MAP_FILE = "aws-tf-map-resouces.json"
ID_RULES_FILE = "aws-tf-id-rules.json"
OUT_DIR = "../imported"
TF_FILE = os.path.join(OUT_DIR, "imported.tf")
SH_FILE = os.path.join(OUT_DIR, "imports.sh")

os.makedirs(OUT_DIR, exist_ok=True)

# Load files
with open(INVENTORY_FILE) as f:
    resources = json.load(f)
with open(MAP_FILE) as f:
    RESOURCE_MAP = json.load(f)
with open(ID_RULES_FILE) as f:
    ID_RULES = json.load(f)

# Get current terraform state
try:
    state_out = subprocess.check_output(["terraform", "state", "list"], text=True)
    state_resources = set(state_out.strip().splitlines())
except subprocess.CalledProcessError:
    state_resources = set()

def safe_name(name: str) -> str:
    """Make a safe Terraform identifier (letters, digits, underscore)."""
    return re.sub(r"[^A-Za-z0-9_]", "_", name)

def get_tf_type(rtype: str) -> str:
    """Map AWS Resource Explorer type -> Terraform resource type."""
    return RESOURCE_MAP.get(rtype, f"aws_{rtype.replace(':','_')}")

def get_import_id(rtype: str, arn: str) -> str:
    """Apply ID extraction strategy from aws-tf-id-rules.json."""
    rule = ID_RULES.get(rtype, ID_RULES.get("default", {"strategy": "last_token"}))
    strategy = rule.get("strategy", "last_token")

    if strategy == "regex":
        # 🔧 Fix for Python: convert (?<id>) to (?P<id>)
        pattern = rule["pattern"].replace("(?<id>", "(?P<id>")
        match = re.search(pattern, arn)
        if match and "id" in match.groupdict():
            return match.group("id")
        else:
            # fallback to last token if regex doesn't match
            parts = re.split(r"[:/]", arn)
            return parts[-1] if parts else arn
    elif strategy == "arn":
        return arn
    elif strategy == "last_token":
        parts = re.split(r"[:/]", arn)
        return parts[-1] if parts else arn
    else:
        return arn

# Collect resource blocks and imports
tf_blocks = []
import_cmds = ["#!/usr/bin/env bash", "set -euo pipefail", ""]

for res in resources:
    arn = res["Arn"]
    rtype = res["ResourceType"]

    tf_type = get_tf_type(rtype)
    import_id = get_import_id(rtype, arn)
    safe_res_name = safe_name(import_id)
    tf_addr = f"{tf_type}.{safe_res_name}"

    # ✅ Mandatory: skip if already in state
    if tf_addr in state_resources:
        print(f"✅ Skipping (already in state): {tf_addr}")
        continue

    # Terraform block
    block = f'''
resource "{tf_type}" "{safe_res_name}" {{
  # Imported from {arn}

  lifecycle {{
    prevent_destroy = true
    ignore_changes  = all
  }}
}}
'''.strip()
    tf_blocks.append(block)

    # Import command
    import_cmds.append(f'terraform import {tf_addr} "{import_id}"')

# If no new resources found → exit cleanly
if not tf_blocks:
    print("🎉 No new resources to import, state is already in sync.")
    sys.exit(0)

# Write .tf file
with open(TF_FILE, "w") as f:
    f.write("\n\n".join(tf_blocks))

# Write imports.sh
with open(SH_FILE, "w") as f:
    f.write("\n".join(import_cmds))

print(f"✅ Generated {len(tf_blocks)} new resource blocks in {TF_FILE}")
print(f"✅ Generated {len(import_cmds)-3} import commands in {SH_FILE}")
