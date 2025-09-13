# Regions to scan
REGIONS = us-east-1 ca-central-1
# Temporary + final files
RAW_FILE = .inventory.raw.json
FINAL_FILE = inventory.json

.PHONY: explore
explore:
	@echo "Collecting resources from $(REGIONS)"
	bash list_inventory.sh $(RAW_FILE) $(REGIONS)
	@echo "Filtering inventory"
	bash filter_inventory.sh $(RAW_FILE) $(FINAL_FILE)
	@rm -f $(RAW_FILE)
	@echo "✅ Final inventory available at $(FINAL_FILE)"
