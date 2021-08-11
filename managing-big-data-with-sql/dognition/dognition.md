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
