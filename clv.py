import pandas as pd
import numpy as np

print("Loading...")
rfm = pd.read_csv('rfm_final.csv')

# CLV Calculate
rfm['CLV'] = (
    rfm['Monetary'] *
    rfm['Frequency'] *
    0.1
).round(2)

# CLV Segments
rfm['CLV_Segment'] = pd.qcut(
    rfm['CLV'],
    q=4,
    labels=[
        'Low Value',
        'Mid Value',
        'High Value',
        'Top Value'
    ]
)
rfm.to_csv('rfm_final.csv', index=False)
print("CLV Done!")
print(f"Avg CLV: {rfm['CLV'].mean():,.2f}")
print(f"Max CLV: {rfm['CLV'].max():,.2f}")
print(f"Total CLV: {rfm['CLV'].sum():,.2f}")