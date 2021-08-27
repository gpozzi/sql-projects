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

#### 
