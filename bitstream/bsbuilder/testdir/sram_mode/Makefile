test:
	@echo "Testing bsbuilder sram mode AND first-chip compatibility..."
	../../bsbuilder.py --mem_config_hack -cgra_info cgra_info.first_chip < sram.bsb > /tmp/sram.bsa
	diff gold_first_chip.bsa /tmp/sram.bsa
	
