# Project at a glance: Dognition

<img src="https://i.imgur.com/wqfrRRS.jpg" width="300">

## Business case

Dognition (https://www.dognition.com) is a company that teaches you how to build a deeper connection with your dog by giving you an unprecedented perspective on your dog’s personality and capabilities.

As a customer, you purchase the opportunity to follow detailed instructions and how-to videos about how to play 20 fun and interactive games with your dog that were created by scientists, trainers, and behavioral specialists. These 20 games comprise the Dognition Assessment. When you finish the assessment, you receive a 10-15 page report about your dog’s unique personality dimension.

The Profile Report gives you individualized insight into the cognitive strategies your dog uses to interact with the world, and in-depth breakdowns of how your dog performed in each game compared to other dogs. You are also told your dog's Personality Profile, which is one of nine profiles or “dimensions” with titles like “Socialite,” “Einstein,” or “Maverick.”

<img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/ace-badge-30fe7e40ce64ca184222d06feda3aef7.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/charmer-badge-d969b9008b8ec9e7bab37635ae508ebd.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/socialite-badge-00fc21966d3ac77f1885a3d9194964b7.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/expert-badge-bb045f374b05c13a3427cd74a6844e56.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/renaissance-dog-badge-a9b0c505fd6bcc0f3cb15fbaa696d85f.png" width="100">

<img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/protodog-badge-f3a41926abebb18d9015c0766e49505a.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/einstein-badge-1493afc11f9d66f4f343ec2f9dc06e00.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/maverick-badge-19d5212404388d137f4baa3bf1727c68.png" width="100"> <img src="https://d2kl333iheywy2.cloudfront.net/assets/cat/badges/stargazer-badge-6e4eb51f2ea0a268c5f884ea53f5f5f3.png" width="100">

One of Dognition’s primary goals is to be able to collect as much data as possible from as many different kinds of dogs as possible. Thus, they have tasked us with helping them **figure out what business changes they could implement to increase the number of tests users complete on their website**. They have made the data set described below available for our Excel to MySQL: Analytic Techniques for Business Specialization course so that we as a class can learn how to use data analytics to make these types of actionable recommendations.

### Important information:

- The 20-game Dognition Assessment assesses 5 core dimensions of cognition: empathy, communication, cunning, memory, and reasoning.
- With a few exceptions, all games are presented to customers in the same order. Customers are not able to advance through tasks or trials out of order. This rule is implemented to make it as easy as possible for participants to follow all the steps of the games correctly.
- After completing the 20-game Dognition Assessment, customers can sign up to receive additional games and activities at the rate of one game and one activity per
month.
- The Dognition team ran an experiment to determine whether a promotion that gave customers free access to the first 4 games of the Dognition Assessment would entice them to pay to complete the rest of the Dognition Assessment.
- All information that could be used to identify specific users has been removed.
- More details about the Dognition data collection method can be found at: http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0135176 (Stewart, Laughlin, et al. “Citizen science as a new tool in dog cognition research.” PloS One 10.9 (2015): e0135176.)

### Platform

All queries were executed in **jupyter notebook** platform, hence the *%%sql* statement before all queries in sql files into this folder.

### Data description

Dataset has been provided by [Dognition](https://www.dognition.com/), it contains **46 attributes**, which are:

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
