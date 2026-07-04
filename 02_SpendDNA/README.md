# Spend DNA
### wallet's year-end story
# SpendDNA 💸
### your wallet's year-end story.

> *"Spotify Wrapped, but for your money."*

Built for **The Unlox Academy — Week 2 Minor Project**
No ML. No matplotlib. No regex. Just Python fundamentals + NumPy + Pandas.

---

## What it does

SpendDNA reads a messy 6-month bank/UPI transaction export (`rahul_transactions.csv`), cleans it, extracts canonical vendor names from noisy descriptions, categorizes every transaction into one of 12 spending categories, detects spending "personality" archetypes, flags anomalous transactions, and prints a formatted analytics report — the kind of thing you'd screenshot and post on LinkedIn.

The dataset is synthetic: 6 months of transactions (Jan–Jun 2024) for a fictional Bengaluru software engineer, **Rahul Sharma**, deliberately built with messy real-world patterns — 4 date formats, 3 amount formats, duplicate rows, and vendor names buried inside UPI/POS prefixes.

**Sample output:**

```
================================================================
 SpendDNA REPORT - RAHUL SHARMA
 6 months - 1,310 transactions - Jan to Jun 2024
================================================================
 EXECUTIVE SUMMARY
 Total credits : Rs. 5,09,774
 Total debits  : Rs. 8,26,679
 Net change    : -Rs. 3,16,905 (overspending)
 Savings rate  : -62.2% (BURNING SAVINGS)

 TOP CATEGORIES (% of debit total)
 Food Delivery   ################## 23.0%  Rs. 1,89,899
 Quick Commerce  ################   19.5%  Rs. 1,61,564
 E-commerce      #############      16.8%  Rs. 1,39,018
 Investments     #############      16.4%  Rs. 1,35,821

 RAHUL'S SPENDING ARCHETYPES
 -> THE FOODIE              (30.1% on food)
 -> THE QUICK COMMERCE      (19.5% on Q-com)
 -> THE SHOPAHOLIC          (16.8% on e-commerce)
 -> THE INVESTOR            (16.4% on SIPs)
 -> THE LATE-NIGHT SNACKER  (62% food after 9 PM)
 -> THE YOLO SPENDER        (savings rate -62%)
================================================================
```

---

## Features

| # | Feature | Description |
|---|---------|-------------|
| 1 | **Transaction Parser** | Handles 4 date formats and 3 amount formats, standardizes Debit/Credit, drops duplicates |
| 2 | **Vendor Extractor** | Maps ~35 canonical vendors from messy description strings (no regex — string methods only) |
| 3 | **Category Tagger** | Classifies every transaction into 1 of 12 categories |
| 4 | **Spending Overview** | Total credits/debits, savings rate, top categories & vendors |
| 5 | **Monthly Trend Analysis** | Category × month spend matrix, month-on-month growth/decline |
| 6 | **Time-of-Day Patterns** | Category × hour heatmap (e.g. late-night food delivery spikes) |
| 7 | **Anomaly Detection** | Z-score based, flags transactions 2+ std dev above their category mean |
| 8 | **Archetype Detection** | Rule-based classification across 8 spending personas |

## Spending Archetypes

| Archetype | Detection Rule |
|---|---|
| The Foodie | Food Delivery + Restaurants + Cafe > 25% of debits |
| The Quick Commerce Junkie | Quick Commerce > 15% of debits |
| The Shopaholic | E-commerce > 15% of debits |
| The Investor | Investments > 15% of debits |
| The Late-Night Snacker | >50% of Food Delivery orders between 21:00–02:00 |
| The Cab Commuter | Transport > 10% of debits |
| The Subscription Lover | 5+ distinct active subscription vendors |
| The YOLO Spender | Savings rate < 10% |
| The Disciplined Saver | Savings rate > 40% |

## Dataset

- **File:** `data/rahul_transactions.csv`
- **Period:** 01 Jan 2024 – 30 Jun 2024
- **Rows:** 1,328 (incl. 18 duplicates)
- **Columns:** `Date, Time, Description, Type, Amount, Balance, Mode, Ref`
- Fully synthetic — no real personal financial data is included in this repo.

## Tech stack

**Used:** Python fundamentals, NumPy, Pandas (`groupby`, `pivot_table`, `transform`, `.dt`, `.str`), `datetime`
**Deliberately avoided:** `pandas-profiling`/`sweetviz`, `matplotlib`/`seaborn`/`plotly`, `scikit-learn`/`scipy.stats`, `re` (regex), any ML/GenAI library — the point of the project is building the analysis logic by hand.

## How to run

1. Clone this repo / open the notebook in Google Colab.
2. Make sure `rahul_transactions.csv` is in the same folder as the notebook (or uploaded to the Colab session).
3. Run all cells top to bottom — no external setup required beyond `pandas` and `numpy`.

```bash
pip install pandas numpy
jupyter notebook spend_dna.ipynb
```

## Files

- `spend_dna.ipynb` — main analysis notebook
- `data/rahul_transactions.csv` — synthetic transaction dataset
- `DS_June_Minor_Project_2_Brief.pdf` — original assignment brief

## Notes

- Analysis is built entirely with Pandas/NumPy — no visualization libraries; all output is printed, formatted text.
- Z-scores for anomaly detection are computed **within each category** (not globally), since a ₹2,000 Swiggy order and a ₹2,000 Amazon order carry very different weight.
- P2P transfers and ATM withdrawals are tagged into their own categories and excluded from category-percentage calculations, since they aren't "consumption" spend.

---

*Part of the Unlox DNA series — see also [GroupDNA](../01_GroupDNA), the WhatsApp chat analytics companion project.*

## Files
- `spend_dna.ipynb` — main analysis notebook
- `data/transactions_june.csv` — sample transaction dataset
- `DS_June_Minor_Project_2_Brief.pdf` — assignment brief
