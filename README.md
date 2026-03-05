# 🎯 RFM Customer Segmentation Analysis

## 📌 Project Overview
End-to-End RFM (Recency, Frequency, Monetary) Customer Segmentation Analysis using Online Retail Dataset. This project identifies customer behavior patterns and segments customers for targeted marketing strategies.

---

## 🛠️ Tech Stack
| Tool | Purpose |
|------|---------|
| MySQL | Data Extraction & Cleaning |
| Python (Pandas, NumPy) | RFM Calculations & CLV Modeling |
| Power BI | Interactive Dashboard |

---

## 📂 Project Structure
```
RFM-Customer-Analysis/
│
├── sql_cleaning.sql      # Data Cleaning Queries
├── RFMAnalysis.py        # RFM Calculation Script
├── clv.py                # CLV Analysis Script
├── RfmAnalysis.pbix      # Power BI Dashboard
└── README.md             # Project Documentation
```

---

## 📊 Dataset
- **Source:** Online Retail Dataset (UCI Machine Learning Repository)
- **Raw Data:** 5,41,909 transactions
- **Date Range:** December 2010 - December 2011
- **Countries:** 38 countries

---

## 🔄 Project Flow

```
Online Retail CSV (541,909 rows)
        ↓
   SQL Cleaning
   - NULL CustomerID Remove (1,35,080)
   - Negative Quantity Remove
   - Cancelled Orders Remove
        ↓
   Clean Data (4,06,829 rows)
        ↓
   Python RFM Calculations
   - Recency Score
   - Frequency Score
   - Monetary Score
        ↓
   Customer Segments (4,338 customers)
        ↓
   Power BI Dashboard (4 Pages)
```

---

## 🧹 SQL Data Cleaning Steps
1. **NULL CustomerID** → 1,35,080 rows removed
2. **Negative Quantity** → Invalid transactions removed
3. **Negative UnitPrice** → Invalid prices removed
4. **Cancelled Orders** → InvoiceNo starting with 'C' removed

**Result:** 5,41,909 → 4,06,829 clean rows

---

## 📈 RFM Methodology

### Scoring Logic
| Metric | Calculation | Score |
|--------|-------------|-------|
| Recency | Days since last purchase | 5 = Recent, 1 = Old |
| Frequency | Unique orders count | 5 = High, 1 = Low |
| Monetary | Total revenue | 5 = High, 1 = Low |

### RFM Score = R_score + F_score + M_score (Range: 3-15)

---

## 👥 Customer Segments

| Segment | RFM Score | Customers | Percentage |
|---------|-----------|-----------|------------|
| 🏆 Champions | 12-15 | 1,255 | 28.9% |
| 💚 Loyal | 9-11 | 1,022 | 23.6% |
| 🟠 Regular | 6-8 | 1,178 | 27.2% |
| 🔴 At Risk | 3-5 | 883 | 20.4% |
| **Total** | | **4,338** | **100%** |

---

## 💰 Key Metrics

| Metric | Value |
|--------|-------|
| Total Customers | 4,338 |
| Total Revenue | 8.91M |
| Average Orders | 4.27 |
| Average Revenue | 2,055 |

---

## 📊 Power BI Dashboard

### 4 Pages:
1. **RFM Overview** → KPI Cards + Revenue Charts
2. **RFM Deep Analysis** → Recency, Frequency, Monetary Distribution
3. **Segment Analysis** → Customer Segment Breakdown
4. **CLV Analysis** → Customer Lifetime Value

---

## 💡 CLV Analysis
**Formula:** CLV = Monetary × Frequency × 0.1

| CLV Segment | Description |
|-------------|-------------|
| Top Value | Highest CLV customers |
| High Value | High CLV customers |
| Mid Value | Medium CLV customers |
| Low Value | Low CLV customers |

---

## 🚀 How to Run

### Step 1: SQL Cleaning
```sql
-- Run sql_cleaning.sql in MySQL Workbench
-- or VS Code with SQLTools extension
```

### Step 2: Python RFM
```bash
pip install pandas numpy
python RFMAnalysis.py
```

### Step 3: CLV Analysis
```bash
python clv.py
```

### Step 4: Power BI
```
Open RfmAnalysis.pbix in Power BI Desktop
Refresh data source
```

---

## 📌 Business Insights

- **Champions (28.9%)** → Best customers, high revenue contributors
- **Loyal (23.6%)** → Regular buyers, good retention
- **Regular (27.2%)** → Average customers, growth potential
- **At Risk (20.4%)** → Need re-engagement campaigns

---

## 👩‍💻 Author
- **Project Type:** Data Analytics End-to-End Project
- **Tools:** SQL, Python, Power BI
- **Domain:** Customer Analytics / Retail

---

⭐ If you found this helpful, please star this repository!
