# Project at a glance: Dillards

<img src="https://image.freepik.com/vector-gratis/tienda-ropa-ninos-ropa-infantil-estilo-adolescente-prendas-moda-nina-bolsas-compra-comprador-boutique-moda-infantil-ilustracion-metafora-concepto-aislado-vector_335657-1330.jpg" width="300">

## Business case

In 1938 William T Dillard founded a store in Nashville Arkansas, a southern state of the United States. Today, that store has grown into approximately 300 department stores in 29 states across United States of America, and each one of those stores has the same name, Dillard's. It sells all kinds of merchandise, from clothing, to accessories, to home decor. It has departments targeted towards women, as well as departments targeted towards men. It is a very popular place to shop. Luckily, it is also a store that collects a lot of data.

Like most stores, when you are ready to purchase an item in Dillard's, you bring it to a sales associate working at a cash register. The sales associate will take the item and use the bar code reader to scan the bar code on the tag that took the store attached the item. This information from the bar code is sent to a centralized database where it is stored in a transaction table. When the customer pays for the item, the payment details are also sent to the transaction table. The receipt is printed and the transaction is completed.

Hundreds of millions of purchase transactions are recorded at Dillard's per year. This provides a very good opportunity to use business analytics tools to **learn what factors influence customer purchasing.**

<img src="https://www.pymnts.com/wp-content/uploads/2020/08/department-store-Dillards-earnings.jpg" width="1000">

### Important information:

- The 20-game Dognition Assessment assesses 5 core dimensions of cognition: empathy, communication, cunning, memory, and reasoning.
- With a few exceptions, all games are presented to customers in the same order. Customers are not able to advance through tasks or trials out of order. This rule is implemented to make it as easy as possible for participants to follow all the steps of the games correctly.
- After completing the 20-game Dognition Assessment, customers can sign up to receive additional games and activities at the rate of one game and one activity per
month.
- The Dognition team ran an experiment to determine whether a promotion that gave customers free access to the first 4 games of the Dognition Assessment would entice them to pay to complete the rest of the Dognition Assessment.
- All information that could be used to identify specific users has been removed.
- More details about the Dognition data collection method can be found at: http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0135176 (Stewart, Laughlin, et al. “Citizen science as a new tool in dog cognition research.” PloS One 10.9 (2015): e0135176.)

### Data description

The data includes sales transaction data from August 2004 through July 2005. It includes exactly what items were included in each transaction, how much they cost and when and where the purchase was made. Additionally, there are census information about the metropolitan's statistical area surrounding the store in which the purchase was made. This information is spread across six tables ranging from 60 to over 120 million rows and size.

Dataset has been donated by [Dillard's](https://www.dillards.com/) to Walton School of Business at the University of Arkansas, which in turn partnered with Duke University to provide this information via Coursera to its enrolled students. It contains **46 attributes**, which are:

- `activity_type`
- `birthday`
- `breed`
- `breed_group`
- `breed_type`
- `category_id`
- `city`
- `country`
- `created_at`
- `description`
- `dimension`
- `dna_tested`
- `dog_fixed`
- `dog_guid`
- `end_time`
- `exclude`
- `free_start_user`
- `gender`
- `last_active_at`
- `loop_number`
- `max_dogs`
- `mean iti (days)`
- `mean iti (minutes)`
- `median iti (days)`
- `median iti (minutes)`
- `membership_id`
- `membership_type`
- `rank_by_dogid`
- `rank_by_userid`
- `rating`
- `script_detail_id`
- `start_time`
- `state`
- `step_type`
- `subcategory_name`
- `subscribed`
- `test_name`
- `time diff between first and last game (days)`
- `time diff between first and last game (minutes)`
- `total tests completed`
- `updated_at`
- `user_guid`
- `weight`
- `zip`
