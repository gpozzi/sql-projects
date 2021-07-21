-- **Question 1: How would you select the Dog IDs for the dogs in the Dognition data set that were DNA tested (these should have a 1 in the dna_tested field of the dogs table)?  Try it below (if you do not limit your output, your query should output data from 1433 dogs):**

%%sql
SELECT DISTINCT dimension
FROM dogs;
