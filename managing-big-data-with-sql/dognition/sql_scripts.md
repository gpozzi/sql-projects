# Index

#### 1. [WHERE clause](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#where-clause)
#### 2. [AS, DISTINCT, ORDER BY, FORMATTING](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#as-distinct-order-by-formatting)
#### 3. [Summarizing data](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#summarizing-data)
#### 4. [GROUP BY and HAVING](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#group-by-and-having)
#### 5. [INNER JOIN](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#inner-join)
#### 6. [OUTER JOINS](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#outer-joins)
#### 7. [Subqueries and derived tables](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#subqueries-and-derived-tables)
#### 8. [Logical functions](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#logical-functions)

# WHERE clause

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### How would you select the Dog IDs for the dogs in the Dognition data set that were DNA tested (these should have a 1 in the dna_tested field of the dogs table)? Try it below (if you do not limit your output, your query should output data from 1433 dogs):

```sql
SELECT
       dog_guid,
       dna_tested
FROM
       dogs
WHERE
       dna_tested=1;
```

#### How would you query the User IDs of customers who bought annual subscriptions, indicated by a "2" in the membership_type field of the users table? (If you do not limit the output of this query, your output should contain 4919 rows.)

```sql
SELECT
       user_guid
FROM
       users
WHERE
       membership_type=2;
```

#### How would you query all the data from customers located in the state of North Carolina (abbreviated "NC") or New York (abbreviated "NY")? If you do not limit the output of this query, your output should contain 1333 rows.

```sql
SELECT
       *
FROM
       users
WHERE
       state IN ("NC","NY")
```

#### Now that you have seen how datetime data can be used to impose criteria on the data you select, how would you select all the Dog IDs and time stamps of Dognition tests completed before October 15, 2015 (your output should have 193,246 rows)?

```sql
SELECT
       dog_guid, created_at
FROM
       complete_tests
WHERE
       created_at < '2015-10-15';
```

#### How would you select all the User IDs of customers who do not have null values in the State field of their demographic information (if you do not limit the output, you should get 17,985 from this query -- there are a lot of null values in the state field!)?

```sql
SELECT
       user_guid
FROM
       users
WHERE
       state IS NOT NULL;
```

#### How would you retrieve the Dog ID, subcategory_name, and test_name fields, in that order, of the first 10 reviews entered in the Reviews table to be submitted in 2014?

```sql
SELECT
       dog_guid,
       subcategory_name,
       test_name
FROM
       reviews
WHERE
       YEAR(created_at)=2014
LIMIT 10;
```

#### How would you select all of the User IDs of customers who have female dogs whose breed includes the word "terrier" somewhere in its name (if you don't limit your output, you should have 1771 rows in your output)?

```sql
SELECT
       user_guid, gender, breed
FROM
       dogs
WHERE
       gender='female' AND breed LIKE ("%terrier%");
```

#### How would you select the Dog ID, test name, and subcategory associated with each completed test for the first 100 tests entered in October, 2014?

```sql
SELECT
       dog_guid,
       test_name,
       subcategory_name
FROM
       complete_tests
WHERE
       YEAR(created_at) = "2014" and MONTH(created_at) = 10
LIMIT 100;
```

# AS, DISTINCT, ORDER BY, FORMATTING

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### How would you change the title of the "start_time" field in the exam_answers table to "exam start time" in a query output?

```sql
SELECT
       start_time AS "exam start time"
FROM
       exam_answers
```

#### How would you list all the possible combinations of test names and subcategory names in complete_tests table? (If you do not limit your output, you should retrieve 45 possible combinations)

```sql
SELECT
       DISTINCT test_name,
       subcategory_name
FROM
       complete_tests
```

#### Below, try executing a query that would sort the same output as described above by membership_type first in descending order, and state second in ascending order:

```sql
SELECT
       DISTINCT user_guid,
       state,
       membership_type
FROM
       users
WHERE
       country="US" AND state IS NOT NULL and membership_type IS NOT NULL
ORDER BY
       membership_type DESC, state ASC
```

#### How would you get a list of all the subcategories of Dognition tests, in alphabetical order, with no test listed more than once (if you do not limit your output, you should retrieve 16 rows)?

```sql
SELECT
       DISTINCT subcategory_name
FROM
       complete_tests
ORDER BY
       subcategory_name
```

#### How would you create a text file with a list of all the non-United States countries of Dognition customers with no country listed more than once?

```sql
non_us_countries = %sql 
SELECT
       DISTINCT country
FROM
       users
WHERE
       country!='US';
non_us_countries.csv('non_us_countries.csv')
```

#### How would you find the User ID, Dog ID, and test name of the first 10 tests to ever be completed in the Dognition database?

```sql
SELECT
       user_guid,
       dog_guid,
       test_name
FROM
       complete_tests
ORDER BY
       created_at
LIMIT 10
```

#### How would create a text file with a list of all the customers with yearly memberships who live in the state of North Carolina (USA) and joined Dognition after March 1, 2014, sorted so that the most recent member is at the top of the list?

```sql
file = %sql
SELECT
       DISTINCT user_guid,
       state,
       created_at
FROM
       users
WHERE
       membership_type=2 AND state="NC" AND country="US" AND created_at>'2014_03_01'
ORDER BY
       created_at DESC;
file.csv('NC_yearly_after_March_1_2014.csv')
```

#### See if you can find an SQL function from the list provided at: http://www.w3resource.com/mysql/mysql-functions-and-operators.php that would allow you to output all of the distinct breed names in UPPER case. Create a query that would output a list of these names in upper case, sorted in alphabetical order.

```sql
SELECT
       DISTINCT UPPER(breed)
FROM
       dogs
ORDER BY
       breed;
```
# Summarizing data

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### Try combining this query with a WHERE clause to find how many individual dogs completed tests after March 1, 2014 (the answer should be 13,289):

```sql
SELECT
       COUNT(DISTINCT Dog_Guid)
FROM
       complete_tests
WHERE
       created_at > '2014_03_01'
```

#### To observe the second difference yourself first, count the number of rows in the dogs table using COUNT(*):

```sql
SELECT
       COUNT(*)
FROM
       dogs
```

#### Now count the number of rows in the exclude column of the dogs table:

```sql
SELECT
       COUNT(exclude)
FROM
       dogs
```

#### How many distinct dogs have an exclude flag in the dogs table (value will be "1")? (the answer should be 853)

```sql
SELECT
       COUNT(DISTINCT dog_guid)
FROM
       dogs
WHERE
       exclude=1
```

#### What is the average, minimum, and maximum ratings given to "Memory versus Pointing" game? (Your answer should be 3.5584, 0, and 9, respectively)

```sql
SELECT
       test_name,
       AVG(rating) AS avg,
       MIN(rating) AS min,
       MAX(rating) AS max
FROM
       reviews
WHERE
       test_name = "Memory versus Pointing"
```

#### How would you query how much time it took to complete each test provided in the exam_answers table, in minutes? Title the column that represents this data "Duration." Note that the exam_answers table has over 2 million rows, so if you don't limit your output, it will take longer than usual to run this query. (HINT: use the TIMESTAMPDIFF function described at: http://www.w3resource.com/mysql/date-and-time-functions/date-and-time-functions.php. It might seem unkind of me to keep suggesting you look up and use new functions I haven't demonstrated for you, but I really want you to become confident that you know how to look up and use new functions when you need them! It will give you a very competitive edge in the business world.)

```sql
SELECT
       TIMESTAMPDIFF(minute, start_time, end_time) AS Duration
FROM
       exam_answers
LIMIT 200
```

#### Include a column for Dog_Guid, start_time, and end_time in your query, and examine the output. Do you notice anything strange?

```sql
SELECT
       dog_guid,
       start_time,
       end_time,
       TIMESTAMPDIFF(minute,start_time,end_time) AS Duration
FROM
       exam_answers
LIMIT 2000
```

#### What is the average amount of time it took customers to complete all of the tests in the exam_answers table, if you do not exclude any data (the answer will be approximately 587 minutes)?

```sql
SELECT
       AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS avgDuration
FROM
       exam_answers
```

#### What is the average amount of time it took customers to complete the "Treat Warm-Up" test, according to the exam_answers table (about 165 minutes, if no data is excluded)?

```sql
SELECT
       AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS avgDuration
FROM
       exam_answers
WHERE
       test_name="Treat WarmaUp"
```

#### How many possible test names are there in the exam_answers table?

```sql
SELECT
       COUNT(DISTINCT test_name)
FROM
       exam_answers
```

#### What is the minimum and maximum value in the Duration column of your query that included the data from the entire table?

```sql
SELECT
       MIN(TIMESTAMPDIFF(minute,start_time,end_time)) AS minDuration,
       MAX(TIMESTAMPDIFF(minute,start_time,end_time)) AS maxDuration
FROM
       exam_answers
```

#### How many of these negative Duration entries are there? (the answer should be 620)

```sql
SELECT
       COUNT(TIMESTAMPDIFF(minute,start_time,end_time)) AS Duration
FROM
       exam_answers
WHERE
       TIMESTAMPDIFF(minute,start_time,end_time) < 0
```

#### How would you query all the columns of all the rows that have negative durations so that you could examine whether they share any features that might give you clues about what caused the entry mistake?

```sql
SELECT
       *
FROM
       exam_answers
WHERE
       TIMESTAMPDIFF(minute,start_time,end_time) < 0
```

#### What is the average amount of time it took customers to complete all of the tests in the exam_answers table when the negative durations are excluded from your calculation (you should get 11233 minutes)?

```sql
SELECT
       AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS avgDuration
FROM
       exam_answers
WHERE
       TIMESTAMPDIFF(minute,start_time,end_time) > 0
```

# GROUP BY and HAVING

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### Output a table that calculates the number of distinct female and male dogs in each breed group of the Dogs table, sorted by the total number of dogs in descending order (the sex/breed_group pair with the greatest number of dogs should have 8466 unique Dog_Guids):

```sql
SELECT
       gender,
       breed_group,
       COUNT(DISTINCT dog_guid) AS numdogs
FROM
       dogs
GROUP BY
       gender,
       breed_group
ORDER BY
       numdogs DESC;
```

#### Revise the query your wrote in Question 1 so that it uses only numbers in the GROUP BY and ORDER BY fields.

```sql
SELECT
       gender,
       breed_group,
       COUNT(DISTINCT dog_guid) AS numdogs
FROM
       dogs
GROUP BY
       1,
       2
ORDER BY
       3 DESC;
```

#### Revise the query your wrote in Question 2 so that it (1) excludes the NULL and empty string entries in the breed_group field, and (2) excludes any groups that don't have at least 1,000 distinct Dog_Guids in them. Your result should contain 8 rows. (HINT: sometimes empty strings are registered as non-NULL values. You might want to include the following line somewhere in your query to exclude these values as well): breed_group!=""

```sql
SELECT
       gender,
       breed_group,
       COUNT(DISTINCT dog_guid) AS numdogs
FROM
       dogs
WHERE
       breed_group IS NOT NULL AND breed_group != "None" AND breed_group != ""
GROUP BY
       1,
       2
HAVING
       numdogs >= 1000
ORDER BY
       3 DESC;
```

#### Write a query that outputs the average number of tests completed and average mean inter-test-interval for every breed type, sorted by the average number of completed tests in descending order (popular hybrid should be the first row in your output).

```sql
SELECT
       breed_type,
       AVG(total_tests_completed) AS numtests,
       AVG(mean_iti_minutes)
AS
       avgmeanITI
FROM
       dogs
GROUP BY
       breed_type
ORDER BY
       AVG(total_tests_completed) DESC;
```

#### Write a query that outputs the average amount of time it took customers to complete each type of test where any individual reaction times over 6000 hours are excluded and only average reaction times that are greater than 0 seconds are included (your output should end up with 67 rows).

```sql
SELECT
       test_name,
       AVG(TIMESTAMPDIFF(HOUR,start_time,end_time)) AS Duration
FROM
       exam_answers
WHERE
       timestampdiff(MINUTE,start_time,end_time) < 6000
GROUP BY
       test_name
HAVING
       AVG (timestampdiff(MINUTE,start_time,end_time)) > 0
ORDER BY
       Duration DESC;
```

#### Write a query that outputs the total number of unique User_Guids in each combination of State and ZIP code (postal code) in the United States, sorted first by state name in ascending alphabetical order, and second by total number of unique User_Guids in descending order (your first state should be AE and there should be 5043 rows in total in your output).

```sql
SELECT
       state,
       zip,
       COUNT(DISTINCT user_guid) AS numusers
FROM
       users
WHERE
       Country="US"
GROUP BY
       State,
       zip
ORDER BY
       State ASC,
       numusers DESC;
```

#### Write a query that outputs the total number of unique User_Guids in each combination of State and ZIP code in the United States that have at least 5 users, sorted first by state name in ascending alphabetical order, and second by total number of unique User_Guids in descending order (your first state/ZIP code combination should be AZ/86303).

```sql
SELECT
       state,
       zip,
       COUNT(DISTINCT user_guid) AS numusers
FROM
       users
WHERE
       Country="US"
GROUP BY
       State,
       zip
HAVING
       numusers >= 5
ORDER BY
       State ASC,
       numusers DESC;
```

# INNER JOIN

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### How many unique dog_guids and user_guids are there in the reviews and dogs table independently?

`Q1`

```sql
SELECT
       COUNT(DISTINCT dog_guid) 
FROM
       reviews;
```

`Q2`
```sql
SELECT
       COUNT(DISTINCT user_guid) 
FROM
       reviews; 
```

`Q3`

```sql
SELECT
       COUNT(DISTINCT dog_guid) 
FROM
       dogs; 
```

`Q4`

```sql
SELECT
       COUNT(DISTINCT user_guid) 
FROM
       dogs; 
```

#### How would you extract the user_guid, dog_guid, breed, breed_type, and breed_group for all animals who completed the "Yawn Warm-up" game (you should get 20,845 rows if you join on dog_guid only)?

```sql
SELECT
       d.user_guid AS UserID, d.dog_guid AS DogID, d.breed, d.breed_type, d.breed_group 
FROM
       dogs d,
       complete_tests c 
WHERE
       d.dog_guid = c.dog_guid AND test_name='Yawn Warm-up';
```

#### How would you extract the user_guid, membership_type, and dog_guid of all the golden retrievers who completed at least 1 Dognition test (you should get 711 rows)?

```sql
SELECT
       DISTINCT d.user_guid AS UserID,
       u.membership_type,
       d.dog_guid AS dog_id,
       d.breed 
FROM
       dogs d,
       complete_tests c,
       users u 
WHERE
       d.dog_guid = c.dog_guid 
       AND d.user_guid = u.user_guid   
       AND d.breed = "golden retriever";
```

#### How many unique Golden Retrievers who live in North Carolina are there in the Dognition database (you should get 30)?

```sql
SELECT
       u.state AS state,
       d.breed AS breed,
       COUNT(DISTINCT d.dog_guid)
FROM
       users u,
       dogs d 
WHERE
       d.user_guid = u.user_guid AND breed="Golden Retriever"
GROUP BY
       state 
HAVING
       state="NC";
```

#### How many unique customers within each membership type provided reviews (there should be 2900 in the membership type with the greatest number of customers, and 15 in the membership type with the fewest number of customers if you do NOT include entries with NULL values in their ratings field)?

```sql
SELECT
       u.membership_type AS membership,
       COUNT(DISTINCT r.user_guid) 
FROM
       users u,
       reviews r 
WHERE
       u.user_guid = r.user_guid
       AND r.rating IS NOT NULL
GROUP BY
       membership_type;
```

#### For which 3 dog breeds do we have the greatest amount of site_activity data, (as defined by non-NULL values in script_detail_id)(your answers should be "Mixed", "Labrador Retriever", and "Labrador Retriever-Golden Retriever Mix"?

```sql
SELECT
       d.breed,
       COUNT(a.script_detail_id) AS activity 
FROM
       dogs d,
       site_activities a 
WHERE
       d.dog_guid = a.dog_guid
       AND a.script_detail_id IS NOT NULL 
GROUP BY
       breed ORDER BY activity DESC
```
# OUTER JOINS

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### How would you re-write this query using the traditional join syntax? 
```mySQL
SELECT
       d.user_guid AS userid,
       d.dog_guid AS dogid, 
       d.breed,
       s.breed_type,
       d.breed_group
FROM
       dogs d,
       complete_tests c
WHERE
       d.dog_guid = c.dog_guid
       AND test_name='Yawn Warm-up';
```
#### Solution
```mySQL
SELECT
       d.user_guid AS userid,
       d.dog_guid AS dogid,
       d.breed,
       d.breed_type,
       d.breed_group
FROM
       dogs d
JOIN
       complete_tests c
ON
       d.dog_guid = c.dog_guid
WHERE
       test_name='Yawn Warm-up';
```
#### How could you retrieve this same information using a RIGHT JOIN?

```mysql
SELECT
       r.dog_guid AS rDogID,
       d.dog_guid AS dDogID,
       r.user_guid AS rUserID,
       d.user_guid AS dUserID,
       AVG(r.rating) AS AvgRating,
       COUNT(r.rating) AS NumRatings,
       d.breed,
       d.breed_group,
       d.breed_type
FROM
       reviews r
LEFT JOIN
       dogs d
ON
       r.dog_guid = d.dog_guid
       AND r.user_guid = d.user_guid
WHERE
       r.dog_guid IS NOT NULL
GROUP BY
       r.dog_guid
HAVING
       NumRatings >= 10
ORDER BY
       AvgRating DESC;
```

#### How would you use a left join to retrieve a list of all the unique dogs in the dogs table, and retrieve a count of how many tests each one completed? Include the dog_guids and user_guids from the dogs and complete_tests tables in your output. (If you do not limit your query, your output should contain 35050 rows. HINT: use the dog_guid from the dogs table to group your results.)

```mysql
SELECT
       d.user_guid AS duserID,
       c.user_guid AS cuserID,
       d.dog_guid AS ddogID,
       c.dog_guid AS ddogID,
       count(test_name)
FROM
       dogs d
LEFT JOIN
       complete_tests c
ON
       d.dog_guid = c.dog_guid
GROUP BY
       d.dog_guid;
```

#### Repeat the query you ran in Question 3, but intentionally use the dog_guids from the completed_tests table to group your results instead of the dog_guids from the dogs table. (Your output should contain 17987 rows)

```mysql
SELECT
       d.user_guid AS duserID,
       c.user_guid AS cuserID,
       d.dog_guid AS ddogID,
       c.dog_guid AS ddogID,
       count(test_name)
FROM
       dogs d
LEFT JOIN
       complete_tests c
ON
       d.dog_guid = c.dog_guid
GROUP BY
       c.dog_guid;
```

#### Write a query using COUNT DISTINCT to determine how many distinct dog_guids there are in the completed_tests table.

```mysql
SELECT
       COUNT(DISTINCT dog_guid)
FROM
       complete_tests;
```

#### We want to extract all of the breed information of every dog a user_guid in the users table owns. If a user_guid in the users table does not own a dog, we want that information as well. Write a query that would return this information. Include the dog_guid from the dogs table, and user_guid from both the users and dogs tables in your output. (HINT: you should get 952557 rows in your output!)

```mysql
SELECT
       u.user_guid AS uUserID,
       d.user_guid AS dUserID,
       d.dog_guid AS dDogID,
       d.breed
FROM
       users u
LEFT JOIN
       dogs d
ON
       u.user_guid=d.user_guid;
```

#### Adapt the query you wrote above so that it counts the number of rows the join will output per user_id. Sort the results by this count in descending order. Remember that if you include dog_guid or breed fields in this query, they will be randomly populated by only one of the values associated with a user_guid (see MySQL Exercise 6; there should be 33,193 rows in your output).

```mysql
SELECT
       u.user_guid AS uUserID,
       d.user_guid AS dUserID,
       d.dog_guid AS dDogID,
       d.breed,
       count(*) AS rows
FROM
       users u
LEFT JOIN
       dogs d
ON
       u.user_guid = d.user_guid
GROUP BY
       u.user_guid
ORDER BY
       rows DESC;
```

#### How many rows in the users table are associated with user_guid 'ce225842-7144-11e5-ba71-058fbc01cf0b'?

```mysql
SELECT
       COUNT(user_guid)
FROM
       users
WHERE
       user_guid = 'ce225842-7144-11e5-ba71-058fbc01cf0b';
```

#### Examine all the rows in the dogs table that are associated with user_guid 'ce225842-7144-11e5-ba71-058fbc01cf0b'?

```mysql
SELECT
       *
FROM
       dogs
WHERE
       user_guid = 'ce225842-7144-11e5-ba71-058fbc01cf0b';
```

#### How would you write a query that used a left join to return the number of distinct user_guids that were in the users table, but not the dogs table (your query should return a value of 2226)?

```mysql
SELECT
       COUNT(user_guid)
FROM
       users
WHERE
       user_guid = 'ce225842-7144-11e5-ba71-058fbc01cf0b';
```

#### How would you write a query that used a right join to return the number of distinct user_guids that were in the users table, but not the dogs table (your query should return a value of 2226)?

```mysql
SELECT
       COUNT(DISTINCT u.user_guid)
FROM
       users u
LEFT JOIN
       dogs d
ON
       u.user_guid = d.user_guid
WHERE
       d.user_guid IS NULL;
```

#### Use a left join to create a list of all the unique dog_guids that are contained in the site_activities table, but not the dogs table, and how many times each one is entered.  Note that there are a lot of NULL values in the dog_guid of the site_activities table, so you will want to exclude them from your list.  (Hint: if you exclude null values, the results you get will have two rows with words in their site_activities dog_guid fields instead of real guids, due to mistaken entries)

```mysql
SELECT
       s.dog_guid AS not_present,
       COUNT(*) AS NumEntries
FROM
       site_activities s
LEFT JOIN
       dogs d
ON
       s.dog_guid = d.dog_guid
WHERE
       d.dog_guid IS NULL 
       AND s.dog_guid IS NOT NULL
GROUP BY
       not_present;
```

# Subqueries and derived tables

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### How could you use a subquery to extract all the data from exam_answers that had test durations that were greater than the average duration for the "Yawn Warm-Up" game? Start by writing the query that gives you the average duration for the "Yawn Warm-Up" game by itself (and don't forget to exclude negative values; your average duration should be about 9934)

```mysql
SELECT
       AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS avg_duration
FROM
       exam_answers
WHERE
       TIMESTAMPDIFF(minute,start_time,end_time)>0 AND test_name="Yawn Warm-Up";
```

#### Once you've verified that your subquery is written correctly on its own, incorporate it into a main query to extract all the data from exam_answers that had test durations that were greater than the average duration for the "Yawn Warm-Up" game (you will get 11059 rows)

```mysql
SELECT
       *
FROM
       exam_answers
WHERE
       TIMESTAMPDIFF(minute,start_time,end_time) > (SELECT
                                                        AVG(TIMESTAMPDIFF(minute,start_time,end_time)) AS avg_duration
                                                    FROM
                                                        exam_answers
                                                    WHERE
                                                        TIMESTAMPDIFF(minute,start_time,end_time)>0
                                                        AND test_name="Yawn Warm-Up");
```

#### Use an IN operator to determine how many entries in the exam_answers tables are from the "Puzzles", "Numerosity", or "Bark Game" tests. You should get a count of 163022.

```mysql
SELECT
       COUNT(*)
FROM
       exam_answers
WHERE
       subcategory_name IN ('Puzzles','Numerosity','Bark Game');
```

#### Use a NOT IN operator to determine how many unique dogs in the dog table are NOT in the "Working", "Sporting", or "Herding" breeding groups. You should get an answer of 7961.

```mysql
SELECT
       COUNT(DISTINCT dog_guid)
FROM
       dogs
WHERE
       breed_group NOT IN ('Working','Sporting','Herding');
```

#### How could you determine the number of unique users in the users table who were NOT in the dogs table using a NOT EXISTS clause? You should get the 2226, the same result as you got in Question 10 of MySQL Exercise 8: Joining Tables with Outer Joins.

```mysql
SELECT
       DISTINCT u.user_guid AS uUserID
FROM
       users u
WHERE
       NOT EXISTS (SELECT
                         d.user_guid
                   FROM
                         dogs d
                   WHERE
                         u.user_guid = d.user_guid);
```

#### Write a query using an IN clause and equijoin syntax that outputs the dog_guid, breed group, state of the owner, and zip of the owner for each distinct dog in the Working, Sporting, and Herding breed groups. (You should get 10,254 rows; the query will be a little slower than some of the others we have practiced)

```mysql
SELECT
       DISTINCT d.dog_guid,
       d.breed_group,
       u.state,
       u.zip
FROM
       dogs d,
       users u
WHERE
       breed_group IN ('Working','Sporting','Herding')
       AND d.user_guid=u.user_guid;
```

#### Write the same query as in Question 6 using traditional join syntax.

```mysql
SELECT
       DISTINCT d.dog_guid,
       d.breed_group,
       u.state,
       u.zip
FROM
       dogs d
JOIN
       users u
ON
       d.user_guid = u.user_guid
WHERE
       breed_group IN ('Working','Sporting','Herding');
```

#### Earlier we examined unique users in the users table who were NOT in the dogs table. Use a NOT EXISTS clause to examine all the users in the dogs table that are not in the users table (you should get 2 rows in your output).

```mysql
SELECT
       d.user_guid AS dUserID,
       d.dog_guid AS dDogID
FROM
       dogs d
WHERE
       NOT EXISTS (SELECT DISTINCT u.user_guid
FROM
       users u
WHERE
       d.user_guid = u.user_guid);
```

#### We saw earlier that user_guid 'ce7b75bc-7144-11e5-ba71-058fbc01cf0b' still ends up with 1819 rows of output after a left outer join with the dogs table. If you investigate why, you'll find out that's because there are duplicate user_guids in the dogs table as well. How would you adapt the query we wrote earlier (copied below) to only join unique UserIDs from the users table with unique UserIDs from the dog table?

```mysql
SELECT
       DistinctUUsersID.user_guid AS uuserid,
       d.user_guid AS duserid,
       count(*) AS rows
FROM
       (SELECT
              DISTINCT u.user_guid
        FROM
              users u
        WHERE
              u.user_guid = 'ce7b75bc-7144-11e5-ba71-058fbc01cf0b') AS distinctuusersid
LEFT JOIN
       dogs d
ON
       distinctuusersid.user_guid = d.user_guid
GROUP BY
       distinctuusersid.user_guid
ORDER BY
       rows DESC;
```

#### Now let's prepare and test the inner query for the right half of the join. Give the dogs table an alias, and write a query that would select the distinct user_guids from the dogs table (we will use this query as a inner subquery in subsequent questions, so you will need an alias to differentiate the user_guid column of the dogs table from the user_guid column of the users table).

```mysql
SELECT
       DISTINCT d.user_guid
FROM
       dogs d
```

#### Now insert the query you wrote in Question 10 as a subquery on the right part of the join you wrote in question 9. The output should return columns that should have matching user_guids, and 1 row in the numrows column with a value of 1. If you are getting errors, make sure you have given an alias to the derived table you made to extract the distinct user_guids from the dogs table, and double-check that your aliases are referenced correctly in the SELECT and ON statements.

```mysql
SELECT
       distinctuusersid.user_guid AS uuserid,
       distinctdusersid.user_guid AS duserid,
       count(*) AS rows
FROM
       (SELECT
              DISTINCT u.user_guid
       FROM
              users u
       WHERE
              u.user_guid = 'ce7b75bc-7144-11e5-ba71-058fbc01cf0b') AS distinctuusersid
LEFT JOIN
       (SELECT
              DISTINCT d.user_guid
       FROM
              dogs d) AS distinctdusersid
ON
       distinctuusersid.user_guid = distinctdusersid.user_guid
GROUP BY
       distinctuusersid.user_guid
ORDER BY
       rows DESC;
```

#### Adapt the query from Question 10 so that, in theory, you would retrieve a full list of all the DogIDs a user in the users table owns, with its accompagnying breed information whenever possible.  HOWEVER, BEFORE YOU RUN THE QUERY MAKE SURE TO LIMIT YOUR OUTPUT TO 100 ROWS *WITHIN* THE SUBQUERY TO THE LEFT OF YOUR JOIN.

```mysql
SELECT
       distinctuusersid.user_guid AS uuserid,
       distinctdusersid.user_guid AS duserid,
       distinctdusersid.dog_guid AS dogid,
       distinctdusersid.breed AS breed
FROM
       (SELECT
              DISTINCT u.user_guid
       FROM
              users u
       LIMIT 100) AS distinctuusersid
LEFT JOIN
       (SELECT
              DISTINCT d.user_guid,
              d.dog_guid,
              d.breed
       FROM
              dogs d) AS distinctdusersid
ON
       distinctuusersid.user_guid = distinctdusersid.user_guid
ORDER BY
       distinctuusersid.user_guid;
```

#### You might have a good guess by now about why there are duplicate rows in the dogs table and users table, even though most corporate databases are configured to prevent duplicate rows from ever being accepted. To be sure, though, let's adapt this query we wrote above:

```mysql
SELECT
       distinctusersid.user_guid AS uUserID,
       d.user_guid AS duserid,
       count(*) AS rows
FROM
       (SELECT
              DISTINCT u.user_guid
              FROM users u) AS distinctusersid 
LEFT JOIN
       dogs d
ON
       distinctusersid.user_guid=d.user_guid
GROUP BY
       distinctusersid.user_guid
ORDER BY
       rows DESC 
```

#### Add dog breed and dog weight to the columns that will be included in the final output of your query. In addition, use a HAVING clause to include only UserIDs who would have more than 10 rows in the output of the left join (your output should contain 5 rows).

```mysql
SELECT
       distinctusersid.user_guid AS userid,
       d.breed,
       d.weight,
       count(*) AS rows
FROM
       (SELECT
              DISTINCT u.user_guid
       FROM
              users u) AS distinctusersid
LEFT JOIN
       dogs d
ON
       distinctusersid.user_guid=d.user_guid
GROUP BY
       distinctusersid.user_guid
HAVING
       rows > 10
ORDER BY
       rows DESC;
```

# Logical functions

[back to index](https://github.com/gpozzi/sql-projects/blob/main/managing-big-data-with-sql/dognition/sql_scripts.md#index)

#### Write a query that will output distinct user_guids and their associated country of residence from the users table, excluding any user_guids or countries that have NULL values. You should get 16,261 rows in your result.

```mysql
SELECT
       DISTINCT user_guid,
       country
FROM
       users
WHERE
       country IS NOT NULL;
```

#### Use an IF expression and the query you wrote in Question 1 as a subquery to determine the number of unique user_guids who reside in the United States (abbreviated "US") and outside of the US.

```mysql
SELECT
       IF(cleaned_users.country='US','In US','Outside US') AS user_location,
       count(cleaned_users.user_guid) AS num_guids
FROM
       (SELECT
              DISTINCT user_guid,
              country
       FROM
              users
       WHERE
              user_guid IS NOT NULL AND country IS NOT NULL) AS cleaned_users
GROUP BY
       user_location;
```

#### Write a query using a CASE statement that outputs 3 columns: dog_guid, dog_fixed, and a third column that reads "neutered" every time there is a 1 in the "dog_fixed" column of dogs, "not neutered" every time there is a value of 0 in the "dog_fixed" column of dogs, and "NULL" every time there is a value of anything else in the "dog_fixed" column. Limit your results for troubleshooting purposes.

```mysql
SELECT
       dog_guid,
       dog_fixed,
       CASE dog_fixed
              WHEN "1" THEN "neutered"
              WHEN "0" THEN "not neutered"
              END AS neutered
FROM
       dogs
LIMIT 200;
```

#### We learned that NULL values should be treated the same as "0" values in the exclude columns of the dogs and users tables. Write a query using a CASE statement that outputs 3 columns: dog_guid, exclude, and a third column that reads "exclude" every time there is a 1 in the "exclude" column of dogs and "keep" every time there is any other value in the exclude column. Limit your results for troubleshooting purposes.

```mysql
SELECT
       dog_guid,
       exclude,
       CASE exclude
              WHEN "1" THEN "exclude"
              ELSE "keep"
              END AS exclude_renamed
FROM
       dogs
LIMIT 200;
```

#### Re-write your query from Question 4 using an IF statement instead of a CASE statement.

```mysql
SELECT
       dog_guid,
       exclude,
       IF(exclude="1","exclude","keep") AS exclude_cleaned
FROM
       dogs
LIMIT 200;
```

#### Write a query that uses a CASE expression to output 3 columns: dog_guid, weight, and a third column that reads...
**- "very small" when a dog's weight is 1-10 pounds**
**- "small" when a dog's weight is greater than 10 pounds to 30 pounds**
**- "medium" when a dog's weight is greater than 30 pounds to 50 pounds**
**- "large" when a dog's weight is greater than 50 pounds to 85 pounds**
**- "very large" when a dog's weight is greater than 85 pounds**
#### Limit your results for troubleshooting purposes.**

#### Remember that when you use AND to define values between two boundaries, you need to include the variable name in all clauses that define the conditions of the values you want to extract. In other words, you could use this combined clause in your query: “WHEN weight>10 AND weight<=30 THEN "small" …but this combined clause would cause an error: “WHEN weight>10 AND <=30 THEN "small"

```mysql
SELECT
       dog_guid,
       weight,
       CASE
              WHEN weight <= 0 THEN "very small"
              WHEN weight > 10 AND weight <= 30 THEN "small"
              WHEN weight > 30 AND weight <= 50 THEN "medium"
              WHEN weight > 50 AND weight <= 85 THEN "large"
              WHEN weight > 85 THEN "very large"
              END AS weight_grouped
FROM
       dogs
LIMIT 200;
```

#### For each dog_guid, output its dog_guid, breed_type, number of completed tests, and use an IF statement to include an extra column that reads "Pure_Breed" whenever breed_type equals 'Pure Breed" and "Not_Pure_Breed" whenever breed_type equals anything else. LIMIT your output to 50 rows for troubleshooting. HINT: you will need to use a join to complete this query.

```mysql
SELECT
       d.dog_guid AS dogid,
       d.breed_type AS breed_type,
       count(c.created_at) AS numtests,
       IF(d.breed_type='Pure Breed','pure_breed', 'not_pure_breed') AS pure_breed
FROM
       dogs d,
       complete_tests c
WHERE
       d.dog_guid = c.dog_guid
GROUP BY
       dogid,
       breed_type,
       pure_breed
LIMIT 50;
```

#### Write a query that uses a CASE statement to report the number of unique user_guids associated with customers who live in the United States and who are in the following groups of states:

#### - Group 1: New York (abbreviated "NY") or New Jersey (abbreviated "NJ")
#### - Group 2: North Carolina (abbreviated "NC") or South Carolina (abbreviated "SC")
#### - Group 3: California (abbreviated "CA")
#### - Group 4: All other states with non-null values

#### You should find 898 unique user_guids in Group1.

```mysql
SELECT
       COUNT(DISTINCT user_guid),
       CASE
              WHEN (state = "NY" OR state = "NJ") THEN "Group 1: NY & NJ"
              WHEN (state = "NC" OR state = "SC") THEN "Group 2: NC & SC"
              WHEN state = "CA" THEN "Group 3: CA"
              ELSE "Group 4: Other"
              END AS state_group
FROM
       users
WHERE
       country="US"
       AND state IS NOT NULL
GROUP BY
       state_group;
```

#### Write a query that allows you to determine how many unique dog_guids are associated with dogs who are DNA tested and have either stargazer or socialite personality dimensions. Your answer should be 70.

```mysql
SELECT
       COUNT(DISTINCT dog_guid)
FROM
       dogs
WHERE
       dna_tested=1 AND (dimension='stargazer' OR dimension='socialite');
```
