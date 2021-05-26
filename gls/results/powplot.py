import glob, re
import numpy as np, matplotlib.pyplot as plt, pandas as pd

MODULES = ['PE Core', 'CBs', 'SB', 'Other']
APPMAP = {
    'cascade': 'Cascade',
    'conv_bw': 'Conv 3×3',
    'harris': 'Harris'
}
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
def read_power_to_df(path='*/*.power.hier.rpt'):
    # Data
    data = []

    # Search in path
    for powfname in glob.glob(path):
        # Get app name from file name
        typ = powfname.split('/')[0]
        app = powfname.split('/')[-1].split('.')[0]

        # Read power files
        for line in list(open(powfname).readlines())[15:-1]:
            vals = line.strip().split()
            try:
                data.append({
                    'Design': typ,
                    'App': app,
                    'Filename': powfname,
                    'Indent': re.search('\S', line).start() // 2,
                    'Module': ' '.join(vals[0:-5]),
                    'Internal Power (mW)': float(vals[-5])*1e3 if vals[-5] != 'N/A' else 0.,
                    'Switching Power (mW)': float(vals[-4])*1e3 if vals[-4] != 'N/A' else 0.,
                    'Leakage Power (mW)': float(vals[-3])*1e3 if vals[-3] != 'N/A' else 0.,
                    'Total Power (mW)': float(vals[-2])*1e3 if vals[-2] != 'N/A' else 0.
                    })
            except ValueError as e:
                print(f"ERROR in {app}")
                raise e
    
    # Convert to DataFrame
    return pd.DataFrame(data)

if __name__ == '__main__':
    # Get data
    data = read_power_to_df()

    # Use only one set of results
    data = data[data['App'].isin(APPMAP.keys())]
    data = data[data['Design'].isin(DESIGNMAP.keys())]

    # Rename high-level components and filter the rest
    data['Module'].replace(re.compile(r'pe_tile_new_unq1.*'), 'Total', inplace=True)
    data['Module'].replace(re.compile(r'cb_data\d+.*'), 'CBs', inplace=True)
    data['Module'].replace(re.compile(r'test_pe.*'), 'PE Core', inplace=True)
    data['Module'].replace(re.compile(r'sb_wide.*'), 'SB', inplace=True)
    data['Module'].replace(re.compile(r'sb_1b.*'), 'SB', inplace=True)
    data['Module'].replace(re.compile(r'cb_cg_en.*'), 'CBs', inplace=True)
    data['Module'].replace(re.compile(r'cb_bitd+.*'), 'CBs', inplace=True)
    data.loc[~data['Module'].isin(MODULES + ['Total']), 'Module'] = 'Other'

    # Data replacement
    data.replace(APPMAP, inplace=True)
    data.replace(DESIGNMAP, inplace=True)

    # Plot the power: comparison
    powdata = data.copy()
    powdata.loc[powdata['App'] == 'Conv 3×3', 'Total Power (mW)'] *= 20
    powdata.loc[powdata['App'] == 'Cascade', 'Total Power (mW)'] *= 71
    powdata.loc[powdata['App'] == 'Harris', 'Total Power (mW)'] *= 154
    powdata = powdata[powdata['Indent'] == 0].pivot_table(values='Total Power (mW)', index=['App'], columns='Design')
    print(powdata)
    powdata.plot.bar(title='Total PE Tile Power by App', ylabel='Power (mW)', figsize=(5,3), rot=0, xlabel='')
    plt.ylim(0, 100)
    for rect, label in zip(plt.gca().patches, powdata.values.flatten(order='F')):
        height = rect.get_height()
        plt.gca().text(rect.get_x() + rect.get_width() / 2, height + 5, "%.1f" % label, ha='center', va='bottom')
    plt.tight_layout()
    plt.show()

    # Plot the power breakdown
    powdata = data[data['Indent'] == 1].pivot_table(values='Total Power (mW)', index=['Design'], columns='Module', aggfunc=np.sum)
    powdata = powdata.reindex(MODULES, axis=1).transpose()
    print(powdata)

    # Plot as stacked bar plot
    powdata.plot.pie(title='Average PE Power Breakdown by Module', subplots=True, autopct='%1.1f%%', figsize=(6,3), legend=None, xlabel='')
    plt.tight_layout()
    plt.show()