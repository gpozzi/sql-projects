Index
1. Queries that test relationships between test completion and dog characteristics 
2. Queries that test relationships between test completion and testing circumstances

# Queries that test relationships between test completion and dog characteristics

#### To get a feeling for what kind of values exist in the Dognition personality dimension column, write a query that will output all of the distinct values in the dimension column. Use your relational schema or the course materials to determine what table the dimension column is in. Your output should have 11 rows.

```mysql
SELECT DISTINCT dimension
FROM dogs;
```

#### Use the equijoin syntax (described in MySQL Exercise 8) to write a query that will output the Dognition personality dimension and total number of tests completed by each unique DogID. This query will be used as an inner subquery in the next question. LIMIT your output to 100 rows for troubleshooting purposes.

```mysql
SELECT DISTINCT d.dog_guid AS id, d.dimension, COUNT(c.created_at)
FROM dogs d LEFT JOIN complete_tests c
ON d.dog_guid = c.dog_guid
GROUP BY id
```

#### Re-write the query in Question 2 using traditional join syntax (described in MySQL Exercise 8).

```mysql
SELECT DISTINCT d.dog_guid AS id, d.dimension, COUNT(c.created_at)
FROM dogs d, complete_tests c
WHERE d.dog_guid = c.dog_guid
GROUP BY id
LIMIT 100;
```

#### To start, write a query that will output the average number of tests completed by unique dogs in each Dognition personality dimension.  Choose either the query in Question 2 or 3 to serve as an inner query in your main query.  If you have trouble, make sure you use the appropriate aliases in your GROUP BY and SELECT statements

```mysql
SELECT clean.dimension,AVG(clean.numtests) AS avgdogs
FROM(SELECT DISTINCT d.dog_guid AS ID, d.dimension, COUNT(c.created_at) AS numtests
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     GROUP BY ID) AS clean
GROUP BY dimension
LIMIT 20;
```

#### How many unique DogIDs are summarized in the Dognition dimensions labeled "None" or ""? (You should retrieve values of 13,705 and 71)

```mysql
SELECT d.dimension, COUNT(DISTINCT d.dog_guid) AS counted
FROM dogs d JOIN complete_tests c
ON d.dog_guid = c.dog_guid
WHERE d.dimension ='' OR d.dimension IS NULL
GROUP BY d.dimension
```

#### To determine whether there are any features that are common to all dogs that have non-NULL empty strings in the dimension column, write a query that outputs the breed, weight, value in the "exclude" column, first or minimum time stamp in the complete_tests table, last or maximum time stamp in the complete_tests table, and total number of tests completed by each unique DogID that has a non-NULL empty string in the dimension column.

```mysql
SELECT d.dog_guid AS ID, d.breed, d.weight, d.exclude, MIN(c.created_at) AS Min, MAX(c.updated_at) AS Max, COUNT(c.updated_at)
FROM dogs d JOIN complete_tests c
ON d.dog_guid = c.dog_guid
WHERE d.dimension = ''
GROUP BY ID
LIMIT 30;
```

#### Rewrite the query in Question 4 to exclude DogIDs with (1) non-NULL empty strings in the dimension column, (2) NULL values in the dimension column, and (3) values of "1" in the exclude column. NOTES AND HINTS: You cannot use a clause that says d.exclude does not equal 1 to remove rows that have exclude flags, because Dognition clarified that both NULL values and 0 values in the "exclude" column are valid data. A clause that says you should only include values that are not equal to 1 would remove the rows that have NULL values in the exclude column, because NULL values are never included in equals statements (as we learned in the join lessons). In addition, although it should not matter for this query, practice including parentheses with your OR and AND statements that accurately reflect the logic you intend. Your results should return 402 DogIDs in the ace dimension and 626 dogs in the charmer dimension.

```mysql
SELECT clean.dimension,COUNT(DISTINCT clean.ID) AS countdogs
FROM(SELECT DISTINCT d.dog_guid AS ID, d.dimension
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE(d.dimension IS NOT NULL AND d.dimension !='') AND (d.exclude = '' OR d.exclude IS NULL)
     GROUP BY ID) AS clean
GROUP BY dimension;
```

#### Write a query that will output all of the distinct values in the breed_group field.

```mysql
SELECT DISTINCT breed_group
FROM dogs
```

#### Write a query that outputs the breed, weight, value in the "exclude" column, first or minimum time stamp in the complete_tests table, last or maximum time stamp in the complete_tests table, and total number of tests completed by each unique DogID that has a NULL value in the breed_group column.

```mysql
SELECT DISTINCT d.dog_guid, d.breed_group, d.weight, d.exclude, MIN(c.created_at), MAX(c.updated_at), COUNT(c.updated_at)
FROM dogs d LEFT JOIN complete_tests c
ON d.dog_guid = c.dog_guid
WHERE d.breed_group IS NULL
GROUP BY dog_guid
LIMIT 20
```

#### Adapt the query in Question 7 to examine the relationship between breed_group and number of tests completed. Exclude DogIDs with values of "1" in the exclude column. Your results should return 1774 DogIDs in the Herding breed group.

```mysql
SELECT clean.gruped, COUNT(DISTINCT clean.updated_at) AS counted
FROM(SELECT d.dog_guid AS ID, d.breed_group AS gruped, d.dimension, c.updated_at
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE(d.exclude = '' OR d.exclude IS NULL)
     GROUP BY ID) AS clean
GROUP BY clean.gruped;
```

#### Adapt the query in Question 10 to only report results for Sporting, Hound, Herding, and Working breed_groups using an IN clause.

```mysql
SELECT clean.gruped, COUNT(DISTINCT clean.updated_at) AS Conteo
FROM(SELECT d.dog_guid AS ID, d.breed_group AS gruped, d.dimension, c.updated_at
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE(d.exclude = '' OR d.exclude IS NULL) AND (d.breed_group IN ('Sporting','Hound','Herding','Working'))
     GROUP BY ID) AS clean
GROUP BY clean.gruped;
```

#### Begin by writing a query that will output all of the distinct values in the breed_type field.

```mysql
SELECT DISTINCT breed_type
FROM dogs
```

#### Adapt the query in Question 7 to examine the relationship between breed_type and number of tests completed. Exclude DogIDs with values of "1" in the exclude column. Your results should return 8865 DogIDs in the Pure Breed group.

```mysql
SELECT tipo AS types,COUNT(completados) AS counted
FROM(SELECT DISTINCT d.dog_guid AS ID, d.breed_type AS type, c.updated_at AS completed
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE (d.exclude = 0 OR d.exclude IS NULL)
     GROUP BY ID) AS clean
GROUP BY types;
```

#### For each unique DogID, output its dog_guid, breed_type, number of completed tests, and use a CASE statement to include an extra column with a string that reads "Pure_Breed" whenever breed_type equals 'Pure Breed" and "Not_Pure_Breed" whenever breed_type equals anything else. LIMIT your output to 50 rows for troubleshooting.

```mysql
SELECT d.dog_guid, d.breed_type, COUNT(c.updated_at), CASE breed_type
                                                        WHEN 'Pure breed' THEN 'Pure_breed'
                                                        ELSE 'Not_pure_breed'
                                                        END AS breed
FROM dogs d, complete_tests c
WHERE d.dog_guid = c.dog_guid
GROUP BY breed
LIMIT 50
```

#### Adapt your queries from Questions 7 and 14 to examine the relationship between breed_type and number of tests completed by Pure_Breed dogs and non_Pure_Breed dogs. Your results should return 8336 DogIDs in the Not_Pure_Breed group.

```mysql
SELECT breed,COUNT(contar) AS counted
FROM(SELECT DISTINCT d.dog_guid AS ID, d.dimension,CASE breed_type
                                                        WHEN 'Pure breed' THEN 'Pure_breed'
                                                        ELSE 'Not_pure_breed'
                                                        END AS breed, c.created_at AS count_dogs
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE(d.exclude = 0 OR d.exclude IS NULL)
     GROUP BY ID) AS clean
GROUP BY breed;
```

#### Adapt your query from Question 15 to examine the relationship between breed_type, whether or not a dog was neutered (indicated in the dog_fixed field), and number of tests completed by Pure_Breed dogs and non_Pure_Breed dogs. There are DogIDs with null values in the dog_fixed column, so your results should have 6 rows, and the average number of tests completed by non-pure-breeds who are neutered is 10.5681.

```mysql
SELECT breed,castrated,AVG(count_dogs) AS Conteo, COUNT(DISTINCT ID)
FROM(SELECT DISTINCT d.dog_guid AS ID, d.breed_group, d.dog_fixed AS castrado,CASE breed_type
                                                        WHEN 'Pure breed' THEN 'Pure_breed'
                                                        ELSE 'Not_pure_breed'
                                                        END AS Raza, COUNT(c.created_at) AS count_dogs
     FROM dogs AS d JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE(d.exclude = 0 OR d.exclude IS NULL)
     GROUP BY ID) AS clean
GROUP BY breed,castrated;
```

#### Adapt your query from Question 7 to include a column with the standard deviation for the number of tests completed by each Dognition personality dimension.

```mysql
SELECT dimension, STDDEV(conteo) AS deviation
FROM (SELECT DISTINCT d.dog_guid AS ID, d.dimension AS dimension, COUNT(c.updated_at) AS counted
      FROM dogs d LEFT JOIN complete_tests c
      ON d.dog_guid = c.dog_guid
      GROUP BY ID) AS clean
GROUP BY dimension
```

#### Write a query that calculates the average amount of time it took each dog breed_type to complete all of the tests in the exam_answers table. Exclude negative durations from the calculation, and include a column that calculates the standard deviation of durations for each breed_type group

```mysql
SELECT d.breed_type AS type, AVG(TIMESTAMPDIFF(minute, e.start_time, e.end_time)) AS difference
FROM dogs d, exam_answers e
WHERE d.dog_guid = e.dog_guid AND TIMESTAMPDIFF(minute, e.start_time, e.end_time) > 0
GROUP BY type
```

# Queries that test relationships between test completion and testing circumstances

#### Using the function you found in these websites (https://dev.mysql.com/doc/refman/5.7/en/sql-function-reference.html, http://www.w3resource.com/mysql/mysql-functions-and-operators.php), write a query that will output one column with the original created_at time stamp from each row in the completed_tests table, and another column with a number that represents the day of the week associated with each of those time stamps.  Limit your output to 200 rows starting at row 50.

```mysql
SELECT created_at, DAYOFWEEK(created_at)
FROM complete_tests
LIMIT 49,200;
```

#### Include a CASE statement in the query you wrote in Question 1 to output a third column that provides the weekday name (or an appropriate abbreviation) associated with each created_at time stamp.

```mysql
SELECT created_at, DAYOFWEEK(created_at),
(CASE
WHEN DAYOFWEEK(created_at)=1 THEN "Su"
WHEN DAYOFWEEK(created_at)=2 THEN "Mo"
WHEN DAYOFWEEK(created_at)=3 THEN "Tu"
WHEN DAYOFWEEK(created_at)=4 THEN "We"
WHEN DAYOFWEEK(created_at)=5 THEN "Th"
WHEN DAYOFWEEK(created_at)=6 THEN "Fr"
WHEN DAYOFWEEK(created_at)=7 THEN "Sa"
END) AS daylabel
FROM complete_tests
LIMIT 49,200;
```

#### Adapt the query you wrote in Question 2 to report the total number of tests completed on each weekday. Sort the results by the total number of tests completed in descending order. You should get a total of 33,190 tests in the Sunday row of your output.

```mysql
SELECT DAYOFWEEK(created_at),COUNT(created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(created_at)=1 THEN "Su"
WHEN DAYOFWEEK(created_at)=2 THEN "Mo"
WHEN DAYOFWEEK(created_at)=3 THEN "Tu"
WHEN DAYOFWEEK(created_at)=4 THEN "We"
WHEN DAYOFWEEK(created_at)=5 THEN "Th"
WHEN DAYOFWEEK(created_at)=6 THEN "Fr"
WHEN DAYOFWEEK(created_at)=7 THEN "Sa"
END) AS daylabel
FROM complete_tests
GROUP BY daylabel
ORDER BY numtests DESC;
```

#### Rewrite the query in Question 3 to exclude the dog_guids that have a value of "1" in the exclude column (Hint: this query will require a join.)  This time you should get a total of 31,092 tests in the Sunday row of your output.

```mysql
SELECT DAYOFWEEK(c.created_at),COUNT(c.created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(c.created_at)=1 THEN "Su"
WHEN DAYOFWEEK(c.created_at)=2 THEN "Mo"
WHEN DAYOFWEEK(c.created_at)=3 THEN "Tu"
WHEN DAYOFWEEK(c.created_at)=4 THEN "We"
WHEN DAYOFWEEK(c.created_at)=5 THEN "Th"
WHEN DAYOFWEEK(c.created_at)=6 THEN "Fr"
WHEN DAYOFWEEK(c.created_at)=7 THEN "Sa"
END) AS daylabel
FROM complete_tests c JOIN dogs d
ON c.dog_guid=d.dog_guid
WHERE d.exclude IS NULL OR d.exclude=0
GROUP BY daylabel
ORDER BY numtests DESC;
```

#### Write a query to retrieve all the dog_guids for users common to the dogs and users table using the traditional inner join syntax (your output will have 950,331 rows).

```mysql
SELECT dog_guid
FROM dogs d INNER JOIN users u
ON d.user_guid=u.user_guid
```

#### Write a query to retrieve all the distinct dog_guids common to the dogs and users table using the traditional inner join syntax (your output will have 35,048 rows).

```mysql
SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
```

#### Start by writing a query that retrieves distinct dog_guids common to the dogs and users table, excuding dog_guids and user_guids with a "1" in their respective exclude columns (your output will have 34,121 rows).

```mysql
SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE (u.exclude IS NULL OR u.exclude=0) AND (d.exclude IS NULL OR
d.exclude=0);
```

#### Now adapt your query from Question 4 so that it inner joins on the result of the subquery you wrote in Question 7 instead of the dogs table.  This will give you a count of the number of tests completed on each day of the week, excluding all of the dog_guids and user_guids that the Dognition team flagged in the exclude columns.

```mysql
SELECT DAYOFWEEK(c.created_at) AS dayasnum, YEAR(c.created_at) AS year,
COUNT(c.created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(c.created_at)=1 THEN "Su"
WHEN DAYOFWEEK(c.created_at)=2 THEN "Mo"
WHEN DAYOFWEEK(c.created_at)=3 THEN "Tu"
WHEN DAYOFWEEK(c.created_at)=4 THEN "We"
WHEN DAYOFWEEK(c.created_at)=5 THEN "Th"
WHEN DAYOFWEEK(c.created_at)=6 THEN "Fr"
WHEN DAYOFWEEK(c.created_at)=7 THEN "Sa"
END) AS daylabel
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY daylabel
ORDER BY numtests DESC;
```

#### Adapt your query from Question 8 to provide a count of the number of tests completed on each weekday of each year in the Dognition data set. Exclude all dog_guids and user_guids with a value of "1" in their exclude columns. Sort the output by year in ascending order, and then by the total number of tests completed in descending order. HINT: you will need a function described in one of these references to retrieve the year of each time stamp in the created_at field: https://dev.mysql.com/doc/refman/5.7/en/sql-function-reference.html http://www.w3resource.com/mysql/mysql-functions-and-operators.php

```mysql
SELECT DAYOFWEEK(c.created_at) AS dayasnum, YEAR(c.created_at) AS
year, COUNT(c.created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(c.created_at)=1 THEN "Su"
WHEN DAYOFWEEK(c.created_at)=2 THEN "Mo"
WHEN DAYOFWEEK(c.created_at)=3 THEN "Tu"
WHEN DAYOFWEEK(c.created_at)=4 THEN "We"
WHEN DAYOFWEEK(c.created_at)=5 THEN "Th"
WHEN DAYOFWEEK(c.created_at)=6 THEN "Fr"
WHEN DAYOFWEEK(c.created_at)=7 THEN "Sa"
END) AS daylabel
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY year,daylabel
ORDER BY year ASC, numtests DESC;
```

#### First, adapt your query from Question 9 so that you only examine customers located in the United States, with Hawaii and Alaska residents excluded. HINTS: In this data set, the abbreviation for the United States is "US", the abbreviation for Hawaii is "HI" and the abbreviation for Alaska is "AK". You should have 5,860 tests completed on Sunday of 2013.

```mysql
SELECT DAYOFWEEK(c.created_at) AS dayasnum, YEAR(c.created_at) AS year,
COUNT(c.created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(c.created_at)=1 THEN "Su"
WHEN DAYOFWEEK(c.created_at)=2 THEN "Mo"
WHEN DAYOFWEEK(c.created_at)=3 THEN "Tu"
WHEN DAYOFWEEK(c.created_at)=4 THEN "We"
WHEN DAYOFWEEK(c.created_at)=5 THEN "Th"
WHEN DAYOFWEEK(c.created_at)=6 THEN "Fr"
WHEN DAYOFWEEK(c.created_at)=7 THEN "Sa"
END) AS daylabel
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND u.country="US"
AND (u.state!="HI" AND u.state!="AK")
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY year,daylabel
ORDER BY year ASC, numtests DESC;
```

#### Write a query that extracts the original created_at time stamps for rows in the complete_tests table in one column, and the created_at time stamps with 6 hours subtracted in another column. Limit your output to 100 rows.

```mysql
SELECT created_at, DATE_SUB(created_at, interval 6 hour) AS corrected_time
FROM complete_tests
LIMIT 100;
```

#### Use your query from Question 11 to adapt your query from Question 10 in order to provide a count of the number of tests completed on each day of the week, with approximate time zones taken into account, in each year in the Dognition data set. Exclude all dog_guids and user_guids with a value of "1" in their exclude columns. Sort the output by year in ascending order, and then by the total number of tests completed in descending order. HINT: Don't forget to adjust for the time zone in your DAYOFWEEK statement and your CASE statement.

```mysql
SELECT DAYOFWEEK(DATE_SUB(created_at, interval 6 hour)) AS dayasnum,
YEAR(c.created_at) AS year, COUNT(c.created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=1 THEN "Su"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=2 THEN "Mo"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=3 THEN "Tu"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=4 THEN "We"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=5 THEN "Th"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=6 THEN "Fr"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=7 THEN "Sa"
END) AS daylabel
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND u.country="US"
AND (u.state!="HI" AND u.state!="AK")
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY year,daylabel
ORDER BY year ASC, numtests DESC;
```

#### Adapt your query from Question 12 so that the results are sorted by year in ascending order, and then by the day of the week in the following order: Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday.

```mysql
SELECT DAYOFWEEK(DATE_SUB(created_at, interval 6 hour)) AS dayasnum,
YEAR(c.created_at) AS year, COUNT(c.created_at) AS numtests,
(CASE
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=1 THEN "Su"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=2 THEN "Mo"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=3 THEN "Tu"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=4 THEN "We"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=5 THEN "Th"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=6 THEN "Fr"
WHEN DAYOFWEEK(DATE_SUB(created_at, interval 6 hour))=7 THEN "Sa"
END) AS daylabel
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND u.country="US"
AND (u.state!="HI" AND u.state!="AK")
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY year,daylabel
ORDER BY year ASC, FIELD(daylabel,'Mo','Tu','We','Th','Fr','Sa','Su');
```

#### Which 5 states within the United States have the most Dognition customers, once all dog_guids and user_guids with a value of "1" in their exclude columns are removed? Try using the following general strategy: count how many unique user_guids are associated with dogs in the complete_tests table, break up the counts according to state, sort the results by counts of unique user_guids in descending order, and then limit your output to 5 rows. California ("CA") and New York ("NY") should be at the top of your list.

```mysql
SELECT dogs_cleaned.state AS state, COUNT(DISTINCT dogs_cleaned.user_guid) AS
numusers
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid, u.user_guid, u.state
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND u.country="US"
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY state
ORDER BY numusers DESC
LIMIT 5;
```

#### Which 10 countries have the most Dognition customers, once all dog_guids and user_guids with a value of "1" in their exclude columns are removed? HINT: don't forget to remove the u.country="US" statement from your WHERE clause.

```mysql
SELECT dogs_cleaned.country AS country, COUNT(DISTINCT
dogs_cleaned.user_guid) AS numusers
FROM complete_tests c JOIN
(SELECT DISTINCT dog_guid, u.user_guid, u.country
FROM dogs d JOIN users u
ON d.user_guid=u.user_guid
WHERE ((u.exclude IS NULL OR u.exclude=0)
AND (d.exclude IS NULL OR d.exclude=0))) AS dogs_cleaned
ON c.dog_guid=dogs_cleaned.dog_guid
GROUP BY country
ORDER BY numusers DESC
LIMIT 10;
```
