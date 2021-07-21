-- Question 1: To get a feeling for what kind of values exist in the Dognition personality dimension column, write a query that will output all of the distinct values in the dimension column. Use your relational schema or the course materials to determine what table the dimension column is in. Your output should have 11 rows.

%%sql
SELECT DISTINCT dimension
FROM dogs;

-- Question 2: Use the equijoin syntax (described in MySQL Exercise 8) to write a query that will output the Dognition personality dimension and total number of tests completed by each unique DogID. This query will be used as an inner subquery in the next question. LIMIT your output to 100 rows for troubleshooting purposes.

%%sql
SELECT DISTINCT d.dog_guid AS id, d.dimension, COUNT(c.created_at)
FROM dogs d LEFT JOIN complete_tests c
ON d.dog_guid = c.dog_guid
GROUP BY id
LIMIT 100;

-- Question 3: Re-write the query in Question 2 using traditional join syntax (described in MySQL Exercise 8).

%%sql
SELECT DISTINCT d.dog_guid AS id, d.dimension, COUNT(c.created_at)
FROM dogs d, complete_tests c
WHERE d.dog_guid = c.dog_guid
GROUP BY id
LIMIT 100;

-- Question 4: To start, write a query that will output the average number of tests completed by unique dogs in each Dognition personality dimension. Choose either the query in Question 2 or 3 to serve as an inner query in your main query. If you have trouble, make sure you use the appropriate aliases in your GROUP BY and SELECT statements.

%%sql
SELECT clean.dimension,AVG(clean.numtests) AS Promedio
FROM(SELECT DISTINCT d.dog_guid AS ID, d.dimension, COUNT(c.created_at) AS numtests
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     GROUP BY ID) AS clean
GROUP BY dimension
LIMIT 20;

-- Question 5: How many unique DogIDs are summarized in the Dognition dimensions labeled "None" or ""? (You should retrieve values of 13,705 and 71)

%%sql
SELECT d.dimension, COUNT(DISTINCT d.dog_guid) AS conteo
FROM dogs d JOIN complete_tests c
ON d.dog_guid = c.dog_guid
WHERE d.dimension ='' OR d.dimension IS NULL
GROUP BY d.dimension

-- Question 6: To determine whether there are any features that are common to all dogs that have non-NULL empty strings in the dimension column, write a query that outputs the breed, weight, value in the "exclude" column, first or minimum time stamp in the complete_tests table, last or maximum time stamp in the complete_tests table, and total number of tests completed by each unique DogID that has a non-NULL empty string in the dimension column.

%%sql
SELECT d.dog_guid AS ID, d.breed, d.weight, d.exclude, MIN(c.created_at) AS Min, MAX(c.updated_at) AS Max, COUNT(c.updated_at)
FROM dogs d JOIN complete_tests c
ON d.dog_guid = c.dog_guid
WHERE d.dimension = ''
GROUP BY ID
LIMIT 30;

-- Question 7: Rewrite the query in Question 4 to exclude DogIDs with (1) non-NULL empty strings in the dimension column, (2) NULL values in the dimension column, and (3) values of "1" in the exclude column. NOTES AND HINTS: You cannot use a clause that says d.exclude does not equal 1 to remove rows that have exclude flags, because Dognition clarified that both NULL values and 0 values in the "exclude" column are valid data. A clause that says you should only include values that are not equal to 1 would remove the rows that have NULL values in the exclude column, because NULL values are never included in equals statements (as we learned in the join lessons). In addition, although it should not matter for this query, practice including parentheses with your OR and AND statements that accurately reflect the logic you intend. Your results should return 402 DogIDs in the ace dimension and 626 dogs in the charmer dimension.

%%sql
SELECT clean.dimension,COUNT(DISTINCT clean.ID) AS Conteo
FROM(SELECT DISTINCT d.dog_guid AS ID, d.dimension
     FROM dogs AS d LEFT JOIN complete_tests c
     ON d.dog_guid = c.dog_guid
     WHERE(d.dimension IS NOT NULL AND d.dimension !='') AND (d.exclude = '' OR d.exclude IS NULL)
     GROUP BY ID) AS clean
GROUP BY dimension;

-- Questions 8: Write a query that will output all of the distinct values in the breed_group field.

%%sql
SELECT dog_guid, test_name, subcategory_name
FROM complete_tests
WHERE YEAR(created_at)="2014" and MONTH(created_at)=10
LIMIT 100;
