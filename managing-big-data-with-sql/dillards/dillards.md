#### Use HELP and SHOW to confirm the relational schema provided to us for the Dillard’s dataset shows the correct column names and primary keys for each table. 

```sql
HELP TABLE strinfo
HELP TABLE skstinfo
HELP TABLE skuinfo
HELP TABLE trnsact
HELP TABLE deptinfo
HELP TABLE store_msa
```

```sql
SHOW TABLE strinfo
SHOW TABLE skstinfo
SHOW TABLE skuinfo
SHOW TABLE trnsact
SHOW TABLE deptinfo
SHOW TABLE store_msa
```

#### Examine instances of transaction table where “amt” is different than “sprice”. What did you learn about how the values in “amt”, “quantity”, and “sprice” relate to one another?

```sql
SELECT
  * 
FROM
  trnsact
WHERE 
  amt <> sprice;
```

#### Even though the Dillard’s dataset had primary keys declared and there were not many NULL values, there are still many bizarre entries that likely reflect entry errors. To see some examples of these likely errors, examine:
#### (a) rows in the trsnact table that have “0” in their orgprice column (how could the original price be 0?),

```sql
SELECT 
  *
FROM
  trnsact
WHERE
  orgprice = '0';
```

#### (b) rows in the skstinfo table where both the cost and retail price are listed as 0.00, and

```sql
SELECT
  *
FROM
  skstinfo
WHERE
  cost = '0'
AND
  retail = '0';
```

#### (c) rows in the skstinfo table where the cost is greater than the retail price (although occasionally retailers will sell an item at a loss for strategic reasons, it is very unlikely that a manufacturer would provide a suggested retail price that is lower than the cost of the item).

```sql
SELECT
  *
FROM
  skstinfo
WHERE
  cost > retail;
```

#### Write your own queries that retrieve multiple columns in a precise order from a table, and that restrict the rows retrieved from those columns using “BETWEEN”, “IN”, and references to text strings. Try at least one query that uses dates to restrict the rows you retrieve.

```sql
SELECT
  saledate,
  count(saledate)
FROM
trnsact
WHERE
  state = 'NY'
  AND saledate BETWEEN DATE '2004-03-01' AND DATE '2004-03-30'
GROUP BY
  saledate
ORDER BY
  saledate DESC;
```

#### Use COUNT and DISTINCT to determine how many distinct skus there are in pairs of the skuinfo, skstinfo, and trnsact tables. Which skus are common to pairs of tables, or unique to specific tables? 

```sql
SELECT
  COUNT(DISTINCT a.sku)
FROM
  skuinfo a
JOIN
  skstinfo b
ON
  a.sku = b.sku;
```

#### Use COUNT to determine how many instances there are of each sku associated with each store in the skstinfo table and the trnsact table?

```sql
SELECT
  sku,
  store,
  COUNT(sku)
FROM
  skstinfo
GROUP BY
  sku,
  store;
```

#### Use COUNT and DISTINCT to determine how many distinct stores there are in the strinfo, store_msa, skstinfo, and trnsact tables.

```sql
SELECT
  COUNT(DISTINCT store)
FROM
  strinfo;
```

```sql
SELECT
  COUNT(DISTINCT store)
FROM
  store_msa;
```

```sql
SELECT
  COUNT(DISTINCT store)
FROM
  skstinfo;
```

```sql
SELECT
  COUNT(DISTINCT store)
FROM
  trnsact;
```

#### Which stores are common to all four tables, or unique to specific tables? 

```sql
SELECT
  i.store,
  k.store,
  t.store,
  s.store
FROM
  strinfo i 
LEFT 
  JOIN skstinfo k 
ON
  i.store = k.store
LEFT JOIN
  trnsact t
ON
  i.store = t.store
LEFT JOIN
  store_msa s
ON
  t.store = s.store;
```

#### It turns out there are many skus in the trnsact table that are not in the skstinfo table. As a consequence, we will not be able to complete many desirable analyses of Dillard’s profit, as opposed to revenue, because we do not have the cost information for all the skus in the transact table (recall that profit = revenue - cost). Examine some of the rows in the trnsact table that are not in the skstinfo table; can you find any common features that could explain why the cost information is missing? 

```sql
SELECT
  * 
FROM
  trnsact t 
LEFT JOIN
  skstinfo k
ON
  t.sku=b.sku
  AND t.store = k.store
WHERE
  k.sku IS NULL;
```

#### Although we can’t complete all the analyses we’d like to on Dillard’s profit, we can look at general trends. What is Dillard’s average profit per day? 

```sql
SELECT
  SUM(t.amt - t.quantity * k.cost) / COUNT(DISTINCT t.saledate)
FROM
  trnsact t
LEFT JOIN
  skstinfo k
ON
  t.sku = k.sku
  AND t.store = k.store
WHERE
  t.stype = 'P';
```

#### On what day was the total value (in $) of returned goods the greatest?

```sql
SELECT
  saledate,
  SUM(amt)
FROM
  trnsact
WHERE
  stype = 'R'
GROUP BY
  saledate 
ORDER BY
  SUM(amt) DESC;
```

#### On what day was the total number of individual returned items the greatest? 

```sql
SELECT
  saledate,
  SUM(quantity) 
FROM
  trnsact
WHERE
  stype = 'R'
GROUP BY
  saledate 
ORDER BY
  SUM(quantity) DESC;
```

####  What is the maximum price paid for an item in our database? What is the minimum price paid for an item in our database?

```sql
SELECT
  MAX(sprice)
FROM
  trnsact
WHERE
  stype = 'P';
```

```sql
SELECT
  MIN(sprice)
FROM
  trnsact
WHERE
  stype = 'P';
```

#### How many departments have more than 100 brands associated with them, and what are their descriptions? 

```sql
SELECT
  DISTINCT i.dept,
  d.deptdesc,
  COUNT(distinct i.brand) 
FROM
  skuinfo i
LEFT JOIN
  deptinfo d
ON
  i.dept=d.dept 
GROUP BY
  i.dept, d.deptdesc
HAVING
  COUNT(distinct i.brand) > 100;
```

#### Write a query that retrieves the department descriptions of each of the skus in the skstinfo table

```sql
SELECT
  k.sku,
  d.deptdesc
FROM
  skstinfo k 
LEFT JOIN
  skuinfo i 
ON
  k.sku = i.sku 
LEFT JOIN
  deptinfo d
ON
  i.dept = d.dept;
```

#### What department (with department description), brand, style, and color had the greatest total value of returned items? 



#### In what state and zip code is the store that had the greatest total revenue during the time period monitored in our dataset? 

```sql
SELECT
  i.state,
  i.zip,
FROM
  strinfo i
LEFT JOIN
  trnsact t
ON
  t.store = i.store
WHERE
  stype = 'P'
GROUP BY
  i.state,
  i.zip
ORDER BY
  SUM(t.amt) DESC
LIMIT 1;
```

#### How many distinct dates are there in the saledate column of the transaction table for each month/year combination in the database?

```sql
SELECT 
  EXTRACT(month FROM saledate) AS num_month, 
  EXTRACT(year FROM saledate) AS num_year, 
  COUNT(DISTINCT EXTRACT (day FROM saledate)) AS days_in_month, 
FROM
  trnsact
GROUP BY
  month_num,
  year_num
ORDER BY
  num_year,
  num_month
```

#### Use a CASE statement within an aggregate function to determine which sku had the greatest total sales during the combined summer months of June, July, and August. 

```sql
SELECT
  DISTINCT sku,
  SUM(CASE WHEN (EXTRACT(month FROM saledate)=6 OR EXTRACT(month FROM saledate)=7 OR EXTRACT(month FROM saledate)=8) AND stype='p' THEN amt END) AS summer
FROM
  trnsact
GROUP BY
  sku
ORDER BY
  summer DESC
HAVING
  summer > 0

```

#### How many distinct dates are there in the saledate column of the transaction table for each month/year/store combination in the database? Sort your results by the number of days per combination in ascending order. 

```sql
SELECT 
  EXTRACT (month FROM saledate) AS month_num, 
  EXTRACT (year FROM saledate) AS year_num,
  store,
  COUNT (DISTINCT saledate) AS amt_dates
FROM
  trnsact
GROUP BY
  month_num, year_num, store
ORDER BY
  amt_dates ASC
```

#### What is the average daily revenue for each store/month/year combination in the database? Calculate this by dividing the total revenue for a group by the number of sales days available in the transaction table for that group. 

```sql
SELECT 
  store, 
  EXTRACT (month FROM saledate) AS month_num,
  EXTRACT (year FROM saledate) AS year_num,
  COUNT (DISTINCT saledate) AS amt_dates,
  SUM(amt) AS total_revenue,
  revenue/amt_dates AS avg_dr 
FROM
  trnsact
WHERE
  stype='p'
GROUP BY
  store, month_num, year_num
ORDER BY
  avg_dr desc
```

#### What is the average daily revenue brought in by Dillard’s stores in areas of high, medium, or low levels of high school education? 

```sql

```

#### Compare the average daily revenues of the stores with the highest median msa_income and the lowest median msa_income. In what city and state were these stores, and which store had a higher average daily revenue?

```sql



```

#### What is the brand of the sku with the greatest standard deviation in sprice? Only examine skus that have been part of over 100 sales transactions. 

```sql
SELECT 
  DISTINCT (t.SKU) AS item,
  s.brand AS brand,
  STDDEV_SAMP(t.sprice) AS stdev,
  COUNT(DISTINCT(t.SEQ||t.STORE||t.REGISTER||t.TRANNUM||t.SALEDATE)) AS distinct_transactions
FROM
  TRNSACT t
JOIN
  SKUINFO s
ON
  t.sku=s.sku
WHERE
  t.stype='p'
HAVING
  distinct_transactions>100
GROUP BY
  item, brand
ORDER BY
  stdev DESC

```

#### Examine all the transactions for the sku with the greatest standard deviation in sprice (ie, your answer to exercise 7)

```sql

```

#### What was the average daily revenue Dillard’s brought in during each month of the year?

```sql

```

#### Which department, in which city and state of what store, had the greatest % increase in average daily sales revenue from November to December? 

```sql

```

#### What is the city and state of the store that had the greatest decrease in average daily revenue from August to September? 

```sql

```

#### Determine the month of minimum total revenue for each store. Count the number of stores whose month of minimum total revenue was in each of the twelve months. Then determine the month of minimum average daily revenue. Count the number of stores whose month of minimum average daily revenue was in each of the twelve months. How do they compare?
