#!/usr/bin/env python3
import json, os, re, subprocess, sys
from pathlib import Path

# Paths
ROOT_DIR = Path(__file__).resolve().parent.parent
INVENTORY_FILE = ROOT_DIR / "inventory/inventory.json"
MAP_FILE = ROOT_DIR / "gen-import-scripts/aws-tf-map-resouces.json"
ID_RULES_FILE = ROOT_DIR / "gen-import-scripts/aws-tf-id-rules.json"
BLOCKS_FILE = ROOT_DIR / "gen-import-scripts/aws-tf-block-templates.json"  # NEW
OUT_DIR = ROOT_DIR / "to-import"
TF_FILE = OUT_DIR / "blocks-to-import.tf"
SH_FILE = OUT_DIR / "cli-import.sh"

OUT_DIR.mkdir(parents=True, exist_ok=True)

# Load files
with open(INVENTORY_FILE, encoding="utf-8") as f:
    resources = json.load(f)
with open(MAP_FILE, encoding="utf-8") as f:
    RESOURCE_MAP = json.load(f)
with open(ID_RULES_FILE, encoding="utf-8") as f:
    ID_RULES = json.load(f)
with open(BLOCKS_FILE, encoding="utf-8") as f:   # NEW
    BLOCK_TEMPLATES = json.load(f)

# Get current terraform state addresses
try:
    root_dir = ROOT_DIR.as_posix()
    print(f"Attempting to read Terraform state from: {root_dir}")
    print(f"Current working directory: {os.getcwd()}")
    print(f"ROOT_DIR exists: {os.path.exists(root_dir)}")
    print(f"Backend.tf exists: {os.path.exists(os.path.join(root_dir, 'backend.tf'))}")
    print(f".terraform dir exists: {os.path.exists(os.path.join(root_dir, '.terraform'))}")

    env = os.environ.copy()
    env['TF_IN_AUTOMATION'] = 'true'
    env['TF_INPUT'] = 'false'

    # Ensure AWS credentials are passed through
    aws_vars = ['AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY', 'AWS_SESSION_TOKEN',
                'AWS_DEFAULT_REGION', 'AWS_REGION', 'AWS_PROFILE']
    for var in aws_vars:
        if var in os.environ:
            env[var] = os.environ[var]
            print(f"✓ AWS env var {var} is available")
        else:
            print(f"⚠ AWS env var {var} is missing")

    try:
        version_out = subprocess.check_output(
            ["terraform", "version"],
            text=True,
            cwd=root_dir,
            stderr=subprocess.PIPE,
            env=env
        )
        print(f"Terraform version: {version_out.strip()}")
    except Exception as ve:
        print(f"Terraform version check failed: {ve}")

    state_out = subprocess.check_output(
        ["terraform", "state", "list"],
        text=True,
        cwd=root_dir,
        stderr=subprocess.PIPE,
        env=env
    )
    state_resources = state_out.strip().splitlines()
    print(f"✓ Found {len(state_resources)} resources in Terraform state (S3 backend)")
except subprocess.CalledProcessError as e:
    print(f"⚠  Could not read Terraform state: {e.stderr if e.stderr else str(e)}")
    print(f"💡 Make sure to run 'terraform init' in the root directory: {root_dir}")
    print("💡 This is expected for first-time runs where no resources have been imported yet.")
    state_resources = []

# Extract IDs and ARNs from terraform state show
def collect_state_ids(state_resources, root_dir):
    state_ids = set()
    env = os.environ.copy()
    env['TF_IN_AUTOMATION'] = 'true'
    env['TF_INPUT'] = 'false'
    aws_vars = ['AWS_ACCESS_KEY_ID', 'AWS_SECRET_ACCESS_KEY', 'AWS_SESSION_TOKEN',
                'AWS_DEFAULT_REGION', 'AWS_REGION', 'AWS_PROFILE']
    for var in aws_vars:
        if var in os.environ:
            env[var] = os.environ[var]

    for addr in state_resources:
        try:
            show_out = subprocess.check_output(
                ["terraform", "state", "show", addr],
                text=True,
                cwd=root_dir,
                env=env
            )
            for line in show_out.splitlines():
                line = line.strip()
                if not line or "=" not in line:
                    continue
                key, val = [x.strip().strip('"') for x in line.split("=", 1)]
                if key in ("id", "arn", "bucket", "name"):
                    state_ids.add(val)
        except subprocess.CalledProcessError:
            continue
    return state_ids

state_ids = collect_state_ids(state_resources, root_dir)
print(f"✓ Collected {len(state_ids)} IDs/ARNs from Terraform state")

# Helpers
def safe_name(name: str) -> str:
    return re.sub(r"[^A-Za-z0-9_]", "_", name)

def get_tf_type(rtype: str) -> str:
    return RESOURCE_MAP.get(rtype, f"aws_{rtype.replace(':','_')}")

def get_import_id(rtype: str, arn: str) -> str:
    rule = ID_RULES.get(rtype, ID_RULES.get("default", {"strategy": "last_token"}))
    strategy = rule.get("strategy", "last_token")

    if strategy == "regex":
        pattern = rule["pattern"].replace("(?<id>", "(?P<id>")
        match = re.search(pattern, arn)
        if match and "id" in match.groupdict():
            result = match.group("id")
            if "transform" in rule:
                result = rule["transform"].replace("$1", result)
            return result
        parts = re.split(r"[:/]", arn)
        return parts[-1] if parts else arn
    elif strategy == "arn":
        return arn
    else:  # last_token
        parts = re.split(r"[:/]", arn)
        return parts[-1] if parts else arn

def get_original_import_id(rtype: str, arn: str) -> str:
    rule = ID_RULES.get(rtype, ID_RULES.get("default", {"strategy": "last_token"}))
    strategy = rule.get("strategy", "last_token")

    if strategy == "regex":
        pattern = rule["pattern"].replace("(?<id>", "(?P<id>")
        match = re.search(pattern, arn)
        if match and "id" in match.groupdict():
            return match.group("id")
        parts = re.split(r"[:/]", arn)
        return parts[-1] if parts else arn
    elif strategy == "arn":
        return arn
    else:  # last_token
        parts = re.split(r"[:/]", arn)
        return parts[-1] if parts else arn

# NEW: Build Terraform block using templates
def build_tf_block(tf_type, safe_res_name, arn, name, rtype):
    tpl = BLOCK_TEMPLATES.get(rtype, BLOCK_TEMPLATES.get("default", {})).get("template")
    if not tpl:
        return ""
    return tpl.format(tf_type=tf_type, safe_res_name=safe_res_name, arn=arn, name=name)

# Collect resource blocks and imports
tf_blocks = []
import_cmds = ["#!/usr/bin/env bash", "set -euo pipefail", ""]
skipped, new_imports = [], []

for res in resources:
    arn = res["Arn"]
    rtype = res["ResourceType"]

    tf_type = get_tf_type(rtype)
    import_id = get_import_id(rtype, arn)
    safe_res_name = safe_name(import_id)
    name = safe_res_name.replace("_", "-")
    tf_addr = f"{tf_type}.{safe_res_name}"

    if import_id in state_ids or arn in state_ids:
        skipped.append(f"{tf_type}:{import_id}")
        continue

    block = build_tf_block(tf_type, safe_res_name, arn, name, rtype)
    if block:
        tf_blocks.append(block)

    original_id = get_original_import_id(rtype, arn)
    rule = ID_RULES.get(rtype, ID_RULES.get("default", {"strategy": "last_token"}))

    if rule.get("import_use_arn", False):
        import_cmds.append(f'terraform import module.imported.{tf_addr} "{arn}"')
    else:
        import_cmds.append(f'terraform import module.imported.{tf_addr} "{original_id}"')

    new_imports.append(f"{tf_type}:{original_id}")

if not tf_blocks:
    print(" No new resources to import, state is already in sync.")
    sys.exit(0)

with open(TF_FILE, "w", encoding="utf-8") as f:
    f.write("\n\n".join(tf_blocks))

with open(SH_FILE, "w", encoding="utf-8") as f:
    f.write("\n".join(import_cmds))

print(f"✓ Generated {len(tf_blocks)} new resource blocks in {TF_FILE}")
print(f"✓ Generated {len(import_cmds)-3} import commands in {SH_FILE}")
print(f"⇾ Skipped {len(skipped)} resources already in state")
