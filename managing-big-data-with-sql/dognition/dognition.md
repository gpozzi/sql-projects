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
