import glob, re
import numpy as np, matplotlib.pyplot as plt, pandas as pd

# Read power reports and convert into organized pandas DataFrame
def read_power_to_df(path='vanilla/*.power.hier.rpt'):
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
                    'Type': typ,
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

    # Rename high-level components and filter the rest
    data['Module'].replace('test_pe', 'PE Core', inplace=True)
    data['Module'].replace('sb_wide', 'SB', inplace=True)
    data['Module'].replace(re.compile(r'cb_data\d*'), 'CBs', inplace=True)
    data['Module'].replace(re.compile(r'cb_bit\d*'), 'Other', inplace=True)
    data['Module'].replace('cb_cg_en', 'CBs', inplace=True)
    data['Module'].replace('sb_1b', 'Other', inplace=True)
    data = data[~data['Module'].str.contains('_')]
    data = data[data['Module'] != 'cmpr']
    data = data[data['Module'] != 'pe_tile_new_unq1']

    # Pivot table and rename apps
    tot_pow_data = data.pivot_table(values='Total Power (mW)', index=['App'], columns='Module', aggfunc=np.sum)
    tot_pow_data = tot_pow_data.reindex(['PE Core', 'Other', 'CBs', 'SB'], axis=1).reset_index().iloc[::-1]
    tot_pow_data.replace({
        'cascade': 'Cascade',
        'conv_1_2': 'Conv. 1×2',
        'conv_2_1': 'Conv. 2×1',
        'conv_3_1': 'Conv. 3×1',
        'conv_bw': 'Conv. 3×3',
        'harris': 'Harris',
        'pointwise': 'Pointwise'
        }, inplace=True)
    print(tot_pow_data)

    # Plot as stacked bar plot
    ax = tot_pow_data.plot(x='App', kind='barh', title='Average Power by Module (mW)', stacked=True, mark_right=True, figsize=(5,3))
    #ax.legend(loc='center left', bbox_to_anchor=(0.85, 0.7))
    plt.xlabel('Average Power (mW)')
    plt.gca().get_yaxis().label.set_visible(False)
    plt.tight_layout()
    plt.show()
