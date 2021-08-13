#### Use COUNT and DISTINCT to determine how many distinct skus there are in pairs of the skuinfo, skstinfo, and trnsact tables. Which skus are common to pairs of tables, or unique to specific tables? 

#### Use COUNT to determine how many instances there are of each sku associated with each store in the skstinfo table and the trnsact table?

#### Use COUNT and DISTINCT to determine how many distinct stores there are in the strinfo, store_msa, skstinfo, and trnsact tables.

#### Which stores are common to all four tables, or unique to specific tables? 

#### It turns out there are many skus in the trnsact table that are not in the skstinfo table. As a consequence, we will not be able to complete many desirable analyses of Dillard’s profit, as opposed to revenue, because we do not have the cost information for all the skus in the transact table (recall that profit = revenue - cost). Examine some of the rows in the trnsact table that are not in the skstinfo table; can you find any common features that could explain why the cost information is missing? 

#### Although we can’t complete all the analyses we’d like to on Dillard’s profit, we can look at general trends. What is Dillard’s average profit per day? 

#### On what day was the total value (in $) of returned goods the greatest? On what day was the total number of individual returned items the greatest?

####  What is the maximum price paid for an item in our database? What is the minimum price paid for an item in our database?

#### How many departments have more than 100 brands associated with them, and what are their descriptions? 

#### Write a query that retrieves the department descriptions of each of the skus in the skstinfo table

#### What department (with department description), brand, style, and color had the greatest total value of returned items? 

#### In what state and zip code is the store that had the greatest total revenue during the time period monitored in our dataset? 

#### 
