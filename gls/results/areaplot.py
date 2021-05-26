import glob, re
import numpy as np, matplotlib.pyplot as plt, pandas as pd

HEADER = ['Hinst Name', 'Module Name', 'Inst Count', 'Total Area', 'Buffer', 'Inverter', 'Combinational', 'Flop', 'Latch', 'Clock Gate', 'Macro', 'Physical']
MODULES = ['PE Core', 'CBs', 'SB', 'Other']
DESIGNMAP = {
        'vanilla': 'CMOS',
        'nems_invd1': 'NEMS'
    }
BLOCKAGE_AREA = 4.2336
MUXAREA = {
    2 : 38.7192,
    4 : 71.832,
    10 : 164.6688
}

# Read power reports and convert into organized pandas DataFrame
def read_power_to_df(path='*/signoff.area.rpt'):
    # Data
    data = []

    # Search in path
    for powfname in glob.glob(path):
        # Get app name from file name
        typ = powfname.split('/')[0]

        # Read power files
        for i, line in enumerate(list(open(powfname).readlines())[2:-2]):
            vals = line.strip().split()
            if i == 0:
                vals.insert(1, '')
            vals = vals[0:2] + [int(vals[2])] + [float(v) for v in vals[3:]]
            pt = dict(zip(HEADER, vals))
            pt['Design'] = typ
            pt['Indent'] = re.search('\S', line).start() 
            data.append(pt)
    
    # Convert to DataFrame
    return pd.DataFrame(data)

if __name__ == '__main__':
    # Get data
    data = read_power_to_df()
    # print(data)

    # Use only one set of results
    data = data[data['Design'].isin(DESIGNMAP.keys())]

    # Data replacement
    data.replace(DESIGNMAP, inplace=True)

    # Add in the "other" components of power
    total = data[data['Indent'] == 0].drop(['Hinst Name', 'Module Name'], axis=1).groupby('Design').sum()
    # print(total)
    submods = data[data['Indent'] == 1].groupby('Design').sum()
    # print(submods)
    other = total - submods
    # print(other)
    other = other.reset_index()
    other['Module Name'] = 'Other'
    other['Hinst Name'] = 'Other'
    other['Indent'] = 1
    data = data.append(other)

    # Subtract out areas that shouldn't be counted
    # print(40 * (MUXAREA[2] - BLOCKAGE_AREA) + 40 * (MUXAREA[4] - BLOCKAGE_AREA) + 4 * (MUXAREA[10] - BLOCKAGE_AREA))
    data.loc[(data['Indent'] == 0) & (data['Design'] == 'NEMS'), 'Total Area'] -= 40 * (MUXAREA[2] - BLOCKAGE_AREA) + 40 * (MUXAREA[4] - BLOCKAGE_AREA) + 4 * (MUXAREA[10] - BLOCKAGE_AREA)
    data.loc[(data['Hinst Name'] == 'sb_wide') & (data['Design'] == 'NEMS'), 'Total Area'] -= 40 * (MUXAREA[2] - BLOCKAGE_AREA) + 40 * (MUXAREA[4] - BLOCKAGE_AREA)
    data.loc[(data['Hinst Name'] == 'cb_data0') & (data['Design'] == 'NEMS'), 'Total Area'] -= 2 * (MUXAREA[10] - BLOCKAGE_AREA)
    data.loc[(data['Hinst Name'] == 'cb_data1') & (data['Design'] == 'NEMS'), 'Total Area'] -= 2 * (MUXAREA[10] - BLOCKAGE_AREA)
    # print(data.loc[(data['Indent'] == 0) & (data['Design'] == 'NEMS'), 'Total Area'])
    # print(data.loc[(data['Hinst Name'] == 'sb_wide') & (data['Design'] == 'NEMS'), 'Total Area'])
    # print(data.loc[(data['Hinst Name'] == 'cb_data0') & (data['Design'] == 'NEMS'), 'Total Area'])
    # print(data.loc[(data['Hinst Name'] == 'cb_data1') & (data['Design'] == 'NEMS'), 'Total Area'])

    # Rename high-level components and filter the rest
    data['Hinst Name'].replace(re.compile(r'pe_tile_new_unq1'), 'Total', inplace=True)
    data['Hinst Name'].replace(re.compile(r'cb_data\d+.*'), 'CBs', inplace=True)
    data['Hinst Name'].replace(re.compile(r'test_pe.*'), 'PE Core', inplace=True)
    data['Hinst Name'].replace(re.compile(r'sb_wide.*'), 'SB', inplace=True)
    data['Hinst Name'].replace(re.compile(r'sb_1b.*'), 'SB', inplace=True)
    data['Hinst Name'].replace(re.compile(r'cb_cg_en.*'), 'CBs', inplace=True)
    data['Hinst Name'].replace(re.compile(r'cb_bit.*'), 'CBs', inplace=True)

    # Plot the area: comparison
    powdata = data[data['Indent'] == 0]
    # print(powdata)
    powdata.plot.bar(x='Design', y='Total Area', title='PE Tile CMOS Area', ylabel='Area (um$^2$)', figsize=(2.5,3.5), rot=0, legend=None, xlabel='')
    for rect, label in zip(plt.gca().patches, powdata['Total Area'].values):
        height = rect.get_height()
        plt.gca().text(rect.get_x() + rect.get_width() / 2, height + 5, "%.1f" % label, ha='center', va='bottom')
    plt.ylim(0, 15000)
    plt.tight_layout()
    plt.show()

    # Plot breakdown as pie chart
    powdata = data[data['Indent'] == 1].pivot_table(values='Total Area', index=['Design'], columns='Hinst Name', aggfunc=np.sum).transpose()
    # print(powdata)
    powdata.plot.pie(title='PE Tile Area Breakdown', subplots=True, autopct='%1.1f%%', figsize=(3.5,5), legend=None, layout=(2,1))
    plt.tight_layout()
    plt.show()
