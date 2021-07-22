-- Questions 1-4: How many unique dog_guids and user_guids are there in the reviews and dogs table independently?

-- Q1

%%sql 

SELECT COUNT(DISTINCT dog_guid) 

FROM reviews;

-- Q2

%%sql  

SELECT COUNT(DISTINCT user_guid) 

FROM reviews; 

-- Q3

%%sql 

SELECT COUNT(DISTINCT dog_guid) 

FROM dogs; 

-- Q4

%%sql 

SELECT COUNT(DISTINCT user_guid) 

FROM dogs; 

-- Question 5: How would you extract the user_guid, dog_guid, breed, breed_type, and breed_group for all animals who completed the "Yawn Warm-up" game (you should get 20,845 rows if you join on dog_guid only)?

-- Question 6: How would you extract the user_guid, membership_type, and dog_guid of all the golden retrievers who completed at least 1 Dognition test (you should get 711 rows)?

-- Question 7: How many unique Golden Retrievers who live in North Carolina are there in the Dognition database (you should get 30)?

-- Question 8: How many unique customers within each membership type provided reviews (there should be 2900 in the membership type with the greatest number of customers, and 15 in the membership type with the fewest number of customers if you do NOT include entries with NULL values in their ratings field)?

-- Question 9: For which 3 dog breeds do we have the greatest amount of site_activity data, (as defined by non-NULL values in script_detail_id)(your answers should be "Mixed", "Labrador Retriever", and "Labrador Retriever-Golden Retriever Mix"?

