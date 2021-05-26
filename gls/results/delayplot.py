import glob, re
import numpy as np, matplotlib.pyplot as plt, pandas as pd

CLK_PER = 5
HEADER = ['Hinst Name', 'Module Name', 'Inst Count', 'Total Area', 'Buffer', 'Inverter', 'Combinational', 'Flop', 'Latch', 'Clock Gate', 'Macro', 'Physical']
MODULES = ['PE Core', 'CBs', 'SB', 'Other']
DESIGNMAP = {
        'vanilla': 'CMOS',
        'nems_invd1': 'NEMS'
    }

# Read power reports and convert into organized pandas DataFrame
def read_power_to_df(path='*/report_timing_pba.report'):
    # Data
    data = []

    # Search in path
    for powfname in glob.glob(path):
        # Get app name from file name
        typ = powfname.split('/')[0]

        # Read power files
        lines = open(powfname).read()
        critpath = lines.split('Path Type: max\n\n''')[1]
        critpath = critpath.split('\n  data arrival time')[0]
        # print(critpath)

        for i, line in enumerate(critpath.split('\n')[4:]):
            if line[-1] not in 'rf':
                continue
            vals = line.split()
            data.append({
                'Name' : 'input external delay' if i == 0 else vals[0],
                'Cell' : '' if i == 0 else vals[1],
                'Cell Delay' : float(vals[-3]) if i == 0 else float(vals[-4]),
                'Path Delay' : float(vals[-2]),
                'Type' : vals[-1],
                'Design' : typ, 
                'Clk' : 5 if typ[0] == 'n' else 4.3
            })
    
    # Convert to DataFrame
    return pd.DataFrame(data)

if __name__ == '__main__':
    # Get data
    data = read_power_to_df()

    # Use only one set of results
    data = data[data['Design'].isin(DESIGNMAP.keys())]

    # Data replacement
    data.replace(DESIGNMAP, inplace=True)

    # Rename high-level components and filter the rest
    data['Module'] = data['Name']
    data['Module'].replace(re.compile(r'cb_data\d+.*'), 'CB', inplace=True)
    data['Module'].replace(re.compile(r'test_pe.*'), 'PE Core', inplace=True)
    data['Module'].replace(re.compile(r'sb_wide.*'), 'SB', inplace=True)
    data['Module'].replace(re.compile(r'sb_1b.*'), 'SB', inplace=True)
    data['Module'].replace(re.compile(r'cb_cg_en.*'), 'CB', inplace=True)
    data['Module'].replace(re.compile(r'cb_bit.*'), 'CB', inplace=True)
    data['Module'].replace(re.compile(r'in.*'), 'I/O', inplace=True)
    data['Module'].replace(re.compile(r'out.*'), 'I/O', inplace=True)
    # print(data)

    # Plot the slack: comparison
    slackdata = data.groupby('Design')['Path Delay'].max() * (-1000) + data.groupby('Design')['Clk'].max() * 1000
    print(slackdata)
    slackdata.plot.bar(title='Slack on Crit. Path', ylabel='Slack (ps)', figsize=(2.5,3.5), rot=0, legend=None, xlabel='')
    for rect, label in zip(plt.gca().patches, slackdata.values):
        height = rect.get_height()
        plt.gca().text(rect.get_x() + rect.get_width() / 2, height + 5, "%d" % label, ha='center', va='bottom')
    plt.ylim(0, 70)
    plt.tight_layout()
    plt.show()

    # Plot breakdown as pie chart
    slackdata = data.pivot_table(values='Path Delay', index=['Design'], columns='Module', aggfunc=np.sum).transpose()
    print(slackdata)
    ax = slackdata.sample(frac=1, random_state=42).plot.pie(title='PE Tile Delay Breakdown', subplots=True, autopct='%1.1f%%', figsize=(3.5,5), layout=(2,1), startangle=-60, labeldistance=None, pctdistance=1.3)
    plt.tight_layout()
    plt.show()
