# Script to extract the chipCore area and total power

# Extract Area
summary_report_file = open("reports/signoff.summaryReport.rpt", "r")

summaryReport_lines = summary_report_file.readlines()
core_area_line = summaryReport_lines[14795]
core_area_line_components = core_area_line.split(" ")
print(core_area_line_components[4])


# Extract Power
gls_power_report_file = open("/home/mcoduoza/NEM-Relay-CGRA/gls/results/nems/conv_bw.power.hier.rpt")
gls_lines = gls_power_report_file.readlines()
total_power_line = gls_lines[15]
total_power_line_components = total_power_line.split(" ")
print(total_power_line_components[-2]) 
