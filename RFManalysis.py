import pandas as pd

rfm = pd.read_csv('rfm_output.csv')

# Recency Group - Correct Order
rfm['Recency_Group'] = pd.Categorical(
    rfm['Recency_Group'],
    categories=[
        '0-30 Days',
        '31-60 Days',
        '61-90 Days',
        '91-180 Days',
        '180+ Days'
    ],
    ordered=True
)

# Frequency Group - Correct Order
rfm['Frequency_Group'] = pd.Categorical(
    rfm['Frequency_Group'],
    categories=[
        '1 Order',
        '2-5 Orders',
        '6-10 Orders',
        '11-20 Orders',
        '20+ Orders'
    ],
    ordered=True
)

# Monetary Group - Correct Order
rfm['Monetary_Group'] = pd.Categorical(
    rfm['Monetary_Group'],
    categories=[
        '0-1K',
        '1K-5K',
        '5K-10K',
        '10K-20K',
        '20K+'
    ],
    ordered=True
)