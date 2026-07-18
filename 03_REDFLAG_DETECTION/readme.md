# 🚩 RedFlag - Fraud Detection Engine (SQL Only)

An **industry-graded minor project** from **The Unlox Academy**.  
The goal: **Build a fraud detection engine using pure SQL** — no ML, no Python, no excuses.

---

## 📌 Project Overview
- **Context:** Fraud analytics at PayFast (fictional Indian payment aggregator).
- **Dataset:** 200,000 transactions over 6 months (Jan–Jun 2024).
- **Table:** `transactions` (single flat table, denormalised for speed).
- **Deliverable:** One `.sql` file with **12 fraud detection queries**.
- **Timeline:** 7 days.

This project mirrors real-world fintech analyst work at Razorpay, Cred, Slice, Jupiter, PhonePe, Paytm, and other Indian fintechs.

---

## 🗄 Dataset Structure

| Column       | Type         | Description |
|--------------|-------------|-------------|
| txn_id       | BIGINT (PK) | Unique 8-digit transaction ID |
| user_id      | INT         | Account making the transaction (1–14,755) |
| merchant_id  | INT         | Merchant receiving money (1–800) |
| amount       | DECIMAL(10,2) | ₹1 – ₹100,000 |
| txn_time     | DATETIME    | Timestamp (2024-01-01 → 2024-06-30) |
| status       | VARCHAR(10) | `SUCCESS` or `FAILED` |
| payment_mode | VARCHAR(15) | `UPI`, `CARD`, `NETBANKING`, `WALLET` |
| city         | VARCHAR(30) | 20 Indian cities |
| txn_type     | VARCHAR(10) | `DEBIT`, `CREDIT`, `REFUND` |

### Scale
- ~200,000 transactions
- ~14,500 legitimate users
- ~255 suspect users
- 800 merchants across 12 categories

---

## 🎯 Fraud Patterns to Detect

### **Tier 1 (Week 3 Skills)**
1. **Velocity Fraud** – 30+ txns/day by one user  
2. **Round-Amount Clustering** – 15+ transactions with exact round values  
3. **Card Testing** – 30+ transactions under ₹10/day  
4. **Failed-Then-Succeeded Pairs** – 20+ failed attempts, then success  
5. **Odd-Hour Concentration** – 80%+ activity between 2–5 AM  

### **Tier 2 (Week 4 Skills)**
6. **Mule Accounts** – Credits followed by quick debits  
7. **Refund Abuse** – Refund ratio > 40%  
8. **Merchant Collusion** – Top 5 users contribute > 60% volume  
9. **Just-Under-Threshold** – 10+ transactions at ₹9,999  
10. **Dormant-Then-Active** – 90+ day inactivity, then sudden burst  

### **Tier 3 (Advanced SQL)**
11. **Velocity Spike** – Peak monthly txns ≥ 5× average  
12. **Geographic Impossibility** – Same user in 2 cities within 60 minutes  

---

## 🛠 SQL Concepts Required
- **Week 3:** `GROUP BY`, `HAVING`, `COUNT`, `SUM`, `CASE WHEN`, `WHERE`, `IN`, `BETWEEN`
- **Week 4:** Joins, subqueries, `EXISTS`, correlated subqueries
- **Advanced:** Window functions (`LAG`, `ROW_NUMBER`, `OVER PARTITION BY`), `TIMESTAMPDIFF`

---
