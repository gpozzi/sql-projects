# WHERE clause

#### How would you select the Dog IDs for the dogs in the Dognition data set that were DNA tested (these should have a 1 in the dna_tested field of the dogs table)? Try it below (if you do not limit your output, your query should output data from 1433 dogs):

```sql
SELECT dog_guid, dna_tested
FROM dogs
WHERE dna_tested=1;
```

#### How would you query the User IDs of customers who bought annual subscriptions, indicated by a "2" in the membership_type field of the users table? (If you do not limit the output of this query, your output should contain 4919 rows.)

```sql
SELECT user_guid
FROM users
WHERE membership_type=2;
```

#### How would you query all the data from customers located in the state of North Carolina (abbreviated "NC") or New York (abbreviated "NY")? If you do not limit the output of this query, your output should contain 1333 rows.

```sql
SELECT *
FROM users
WHERE state IN ("NC","NY")
```

#### Now that you have seen how datetime data can be used to impose criteria on the data you select, how would you select all the Dog IDs and time stamps of Dognition tests completed before October 15, 2015 (your output should have 193,246 rows)?

```sql
SELECT dog_guid, created_at
FROM complete_tests
WHERE created_at<'2015-10-15';
```

#### How would you select all the User IDs of customers who do not have null values in the State field of their demographic information (if you do not limit the output, you should get 17,985 from this query -- there are a lot of null values in the state field!)?

```sql
SELECT user_guid
FROM users
WHERE state IS NOT NULL;
```

#### How would you retrieve the Dog ID, subcategory_name, and test_name fields, in that order, of the first 10 reviews entered in the Reviews table to be submitted in 2014?

```sql
SELECT dog_guid, subcategory_name, test_name
FROM reviews
WHERE YEAR(created_at)=2014
LIMIT 10;
```

#### How would you select all of the User IDs of customers who have female dogs whose breed includes the word "terrier" somewhere in its name (if you don't limit your output, you should have 1771 rows in your output)?

```sql
SELECT user_guid, gender, breed
FROM dogs
WHERE gender='female' AND breed LIKE ("%terrier%");
```

#### How would you select the Dog ID, test name, and subcategory associated with each completed test for the first 100 tests entered in October, 2014?

```sql
SELECT dog_guid, test_name, subcategory_name
FROM complete_tests
WHERE YEAR(created_at)="2014" and MONTH(created_at)=10
LIMIT 100;
```

# AS, DISTINCT, ORDER BY, FORMATTING

#### How would you change the title of the "start_time" field in the exam_answers table to "exam start time" in a query output?

```sql
SELECT start_time AS "exam start time"
FROM exam_answers
```

#### How would you list all the possible combinations of test names and subcategory names in complete_tests table? (If you do not limit your output, you should retrieve 45 possible combinations)

```sql
SELECT DISTINCT test_name, subcategory_name
FROM complete_tests
```

#### Below, try executing a query that would sort the same output as described above by membership_type first in descending order, and state second in ascending order:

```sql
SELECT DISTINCT user_guid, state, membership_type
FROM users
WHERE country="US" AND state IS NOT NULL and membership_type IS NOT NULL
ORDER BY membership_type DESC, state ASC
```

#### How would you get a list of all the subcategories of Dognition tests, in alphabetical order, with no test listed more than once (if you do not limit your output, you should retrieve 16 rows)?

```sql
SELECT DISTINCT subcategory_name
FROM complete_tests
ORDER BY subcategory_name
```

#### How would you create a text file with a list of all the non-United States countries of Dognition customers with no country listed more than once?

```sql
non_us_countries=%sql SELECT DISTINCT country FROM users WHERE
country!='US'@
non_us_countries.csv('non_us_countries.csv')
```

#### How would you find the User ID, Dog ID, and test name of the first 10 tests to ever be completed in the Dognition database?

```sql
SELECT user_guid, dog_guid, test_name
FROM complete_tests
ORDER BY created_at
LIMIT 10
```

#### How would create a text file with a list of all the customers with yearly memberships who live in the state of North Carolina (USA) and joined Dognition after March 1, 2014, sorted so that the most recent member is at the top of the list?

```sql
NC_yearly_after_March_1_2014=%sql SELECT DISTINCT user_guid, state, created_at
FROM users WHERE membership_type=2 AND state="NC" AND country="US" AND
created_at>'2014_03_01' ORDER BY created_at DESC
NC_yearly_after_March_1_2014.csv('NC_yearly_after_March_1_2014.csv')
```

#### See if you can find an SQL function from the list provided at: http://www.w3resource.com/mysql/mysql-functions-and-operators.php that would allow you to output all of the distinct breed names in UPPER case. Create a query that would output a list of these names in upper case, sorted in alphabetical order.

```sql
SELECT DISTINCT UPPER(breed)
FROM dogs
ORDER BY breed@
```
# Summarizing data
#### Try combining this query with a WHERE clause to find how many individual dogs completed tests after March 1, 2014 (the answer should be 13,289):

```sql
SELECT COUNT(DISTINCT Dog_Guid)
FROM complete_tests
WHERE created_at>'2014_03_01'
```

#### To observe the second difference yourself first, count the number of rows in the dogs table using COUNT(*):

```sql
SELECT COUNT(*)
FROM dogs
```

#### Now count the number of rows in the exclude column of the dogs table:

```sql
SELECT COUNT(exclude)
FROM dogs
```

#### How many distinct dogs have an exclude flag in the dogs table (value will be "1")? (the answer should be 853)

```sql
SELECT COUNT(DISTINCT dog_guid)
FROM dogs
WHERE exclude=1
```

#### What is the average, minimum, and maximum ratings given to "Memory versus Pointing" game? (Your answer should be 3.5584, 0, and 9, respectively)

```sql
SELECT test_name, AVG(rating) AS AVG_Rating, MIN(rating) AS MIN_Rating,
MAX(rating) AS MAX_Rating
FROM reviews
WHERE test_name="Memory versus Pointing"
```

#### How would you query how much time it took to complete each test provided in the exam_answers table, in minutes? Title the column that represents this data "Duration." Note that the exam_answers table has over 2 million rows, so if you don't limit your output, it will take longer than usual to run this query. (HINT: use the TIMESTAMPDIFF function described at: http://www.w3resource.com/mysql/date-and-time-functions/date-and-time-functions.php. It might seem unkind of me to keep suggesting you look up and use new functions I haven't demonstrated for you, but I really want you to become confident that you know how to look up and use new functions when you need them! It will give you a very competitive edge in the business world.)

```sql
SELECT TIMESTAMPDIFF(minute,start_time,end_time) AS Duration
FROM exam_answers
LIMIT 200
```

#### Include a column for Dog_Guid, start_time, and end_time in your query, and examine the output. Do you notice anything strange?

```sql
SELECT dog_guid, start_time, end_time, TIMESTAMPDIFF(minute,start_time,end_time)
AS Duration
FROM exam_answers
LIMIT 2000
```

#### What is the average amount of time it took customers to complete all of the tests in the exam_answers table, if you do not exclude any data (the answer will be approximately 587 minutes)?

```sql
SELECT AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS AvgDuration
FROM exam_answers
```

#### What is the average amount of time it took customers to complete the "Treat Warm-Up" test, according to the exam_answers table (about 165 minutes, if no data is excluded)?

```sql
SELECT AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS AvgDuration
FROM exam_answers
WHERE test_name="Treat WarmaUp"
```

#### How many possible test names are there in the exam_answers table?

```sql
SELECT COUNT(DISTINCT test_name)
FROM exam_answers
```

#### What is the minimum and maximum value in the Duration column of your query that included the data from the entire table?

```sql
SELECT MIN(TIMESTAMPDIFF(minute,start_time,end_time)) AS MinDuration,
MAX(TIMESTAMPDIFF(minute,start_time,end_time)) AS MaxDuration
FROM exam_answers
```

#### How many of these negative Duration entries are there? (the answer should be 620)

```sql
SELECT COUNT(TIMESTAMPDIFF(minute,start_time,end_time)) AS Duration
FROM exam_answers
WHERE TIMESTAMPDIFF(minute,start_time,end_time)<0
```

#### How would you query all the columns of all the rows that have negative durations so that you could examine whether they share any features that might give you clues about what caused the entry mistake?

```sql
SELECT *
FROM exam_answers
WHERE TIMESTAMPDIFF(minute,start_time,end_time)<0
```

#### What is the average amount of time it took customers to complete all of the tests in the exam_answers table when the negative durations are excluded from your calculation (you should get 11233 minutes)?

```sql
SELECT AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS AvgDuration
FROM exam_answers
WHERE TIMESTAMPDIFF(minute,start_time,end_time)>0
```

# GROUP BY and HAVING

#### Output a table that calculates the number of distinct female and male dogs in each breed group of the Dogs table, sorted by the total number of dogs in descending order (the sex/breed_group pair with the greatest number of dogs should have 8466 unique Dog_Guids):

```sql
SELECT gender, breed_group, COUNT(DISTINCT dog_guid) AS Num_Dogs
FROM dogs
GROUP BY gender, breed_group
ORDER BY Num_Dogs DESC;
```

#### Revise the query your wrote in Question 1 so that it uses only numbers in the GROUP BY and ORDER BY fields.

```sql
SELECT gender, breed_group, COUNT(DISTINCT dog_guid) AS Num_Dogs
FROM dogs
GROUP BY 1, 2
ORDER BY 3 DESC;
```

#### Revise the query your wrote in Question 2 so that it (1) excludes the NULL and empty string entries in the breed_group field, and (2) excludes any groups that don't have at least 1,000 distinct Dog_Guids in them. Your result should contain 8 rows. (HINT: sometimes empty strings are registered as non-NULL values. You might want to include the following line somewhere in your query to exclude these values as well): breed_group!=""

```sql
SELECT gender, breed_group, COUNT(DISTINCT dog_guid) AS Num_Dogs
FROM dogs
WHERE breed_group IS NOT NULL AND breed_group!="None" AND breed_group!=""
GROUP BY 1, 2
HAVING Num_Dogs >= 1000
ORDER BY 3 DESC;
```

#### Write a query that outputs the average number of tests completed and average mean inter-test-interval for every breed type, sorted by the average number of completed tests in descending order (popular hybrid should be the first row in your output).

```sql
SELECT breed_type, AVG(total_tests_completed) AS TotTests, AVG(mean_iti_minutes)
AS AvgMeanITI
FROM dogs
GROUP BY breed_type
ORDER BY AVG(total_tests_completed) DESC;
```

#### Write a query that outputs the average amount of time it took customers to complete each type of test where any individual reaction times over 6000 hours are excluded and only average reaction times that are greater than 0 seconds are included (your output should end up with 67 rows).

```sql
SELECT test_name,
AVG(TIMESTAMPDIFF(HOUR,start_time,end_time)) AS Duration
FROM exam_answers
WHERE timestampdiff(MINUTE,start_time,end_time) < 6000
GROUP BY test_name
HAVING AVG (timestampdiff(MINUTE,start_time,end_time)) > 0 ORDER BY Duration
desc;
```

#### Write a query that outputs the total number of unique User_Guids in each combination of State and ZIP code (postal code) in the United States, sorted first by state name in ascending alphabetical order, and second by total number of unique User_Guids in descending order (your first state should be AE and there should be 5043 rows in total in your output).

```sql
SELECT state, zip, COUNT(DISTINCT user_guid) AS NUM_Users
FROM users
WHERE Country="US"
GROUP BY State, zip
ORDER BY State ASC, NUM_Users DESC;
```

#### Write a query that outputs the total number of unique User_Guids in each combination of State and ZIP code in the United States that have at least 5 users, sorted first by state name in ascending alphabetical order, and second by total number of unique User_Guids in descending order (your first state/ZIP code combination should be AZ/86303).

```sql
SELECT state, zip, COUNT(DISTINCT user_guid) AS NUM_Users
FROM users
WHERE Country="US"
GROUP BY State, zip
HAVING NUM_Users>=5
ORDER BY State ASC, NUM_Users DESC;
```

# INNER JOIN

#### How many unique dog_guids and user_guids are there in the reviews and dogs table independently?

`Q1`

```sql
SELECT COUNT(DISTINCT dog_guid) 
FROM reviews;
```

`Q2`
```sql
SELECT COUNT(DISTINCT user_guid) 
FROM reviews; 
```

`Q3`

```sql
SELECT COUNT(DISTINCT dog_guid) 
FROM dogs; 
```

`Q4`

```sql
SELECT COUNT(DISTINCT user_guid) 
FROM dogs; 
```

#### How would you extract the user_guid, dog_guid, breed, breed_type, and breed_group for all animals who completed the "Yawn Warm-up" game (you should get 20,845 rows if you join on dog_guid only)?

```sql
SELECT d.user_guid AS UserID, d.dog_guid AS DogID, d.breed, d.breed_type, d.breed_group 
FROM dogs d, complete_tests c 
WHERE d.dog_guid=c.dog_guid AND test_name='Yawn Warm-up';
```

#### How would you extract the user_guid, membership_type, and dog_guid of all the golden retrievers who completed at least 1 Dognition test (you should get 711 rows)?

```sql
SELECT DISTINCT d.user_guid AS UserID, u.membership_type, d.dog_guid AS DogID, d.breed 
FROM dogs d, complete_tests c, users u 
WHERE d.dog_guid=c.dog_guid 
AND d.user_guid=u.user_guid   
AND d.breed="golden retriever";
```

#### How many unique Golden Retrievers who live in North Carolina are there in the Dognition database (you should get 30)?

```sql
SELECT u.state AS state, d.breed AS breed, COUNT(DISTINCT d.dog_guid)
FROM users u, dogs d 
WHERE d.user_guid=u.user_guid AND breed="Golden Retriever"
GROUP BY state 
HAVING state="NC";
```

#### How many unique customers within each membership type provided reviews (there should be 2900 in the membership type with the greatest number of customers, and 15 in the membership type with the fewest number of customers if you do NOT include entries with NULL values in their ratings field)?

```sql
SELECT u.membership_type AS Membership, COUNT(DISTINCT r.user_guid) 
FROM users u, reviews r 
WHERE u.user_guid=r.user_guid AND r.rating IS NOT NULL
GROUP BY membership_type;
```

#### For which 3 dog breeds do we have the greatest amount of site_activity data, (as defined by non-NULL values in script_detail_id)(your answers should be "Mixed", "Labrador Retriever", and "Labrador Retriever-Golden Retriever Mix"?

```sql
SELECT d.breed, COUNT(s.script_detail_id) AS activity 
FROM dogs d, site_activities s 
WHERE d.dog_guid=s.dog_guid AND s.script_detail_id IS NOT NULL 
GROUP BY breed ORDER BY activity DESC
```
