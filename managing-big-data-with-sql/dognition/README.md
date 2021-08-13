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

All queries were executed in **jupyter notebook** platform.

### Data description

Dataset has been provided by [Dognition](https://www.dognition.com/), it contains **46 attributes**, which are:

- **`activity_type`**: Type of physical interaction with the website (ie: “cancel_monthly”, “video_player”, “pdf_report_render”, etc.). (**categorical**)
- **`birthday`**: Birth year of the dog. (**ordinal**)
- **`breed`**: Name of breed. (**categorical**)
- **`breed_group`**: Group to which a dog’s breed belongs (Herding, Hound, NonSporting, Sporting, Terrier, Toy, Working). (**categorical**)
- **`breed_type`**: Type of dog breed (pure breed, mixed breed, cross breed, popular hybrid). (**categorical**)
- **`category_id`**: All data is NULL in this field of the database. (**categorical**)
- **`city`**: City of the user. (**categorical**)
- **`country`**: Country of the user. (**categorical**)
- **`created_at`**: Time stamp when the record in that row was created. (**ordinal**)
- **`description`**: Description related to script_detail_id. (**categorical**)
- **`dimension`**: One of Dognition’s 9 personality profiles (Ace, Charmer, Einstein, Expert, Maverick, Protodog, Renaissance-dog, Socialite, Stargazer). (**categorical**)
- **`dna_tested`**: Flag for whether a dog’s DNA has been tested (1=Yes/0=No). (**binary**)
- **`dog_fixed`**: Flag for whether a dog is neutered (also known as “fixed”) (1=Yes/0=No). (**binary**)
- **`dog_guid`**: Unique ID for a dog. (**categorical**)
- **`end_time`**: Timestamp when the user submitted their answer to a question in a Dognition test. (**ordinal**)
- **`exclude`**: Flag provided by Dognition indicating whether an entry should be excluded (reasons not documented in the current data set; (1=Exclude, 0=Don’t necessarily exclude). (**binary**)
- **`free_start_user`**: Flag indicating whether a user received a “free start” by getting the first 4 games for free (1=free start, 0=not free start). (**binary**)
- **`gender`**: Gender of the dog. (**categorical**)
- **`last_active_at`**: Time-stamp of user’s last activity in his/her Dognition account. (**ordinal**)
- **`loop_number`**: Exam questions often have multiple “loops.” This signifies which loop the customer was on. Negative numbers represent “re-dos.”. (**ordinal**)
- **`max_dogs`**: Number of dogs associated with a user. (**ordinal**)
- **`mean iti (days)`**: Mean inter-test-interval (ITI) between each test a dog completed (in days). (**ordinal**)
- **`mean iti (minutes)`**: Mean inter-test-interval (ITI) between each test a dog completed (in minutes). (**ordinal**)
- **`median iti (days)`**: Median inter-test-interval (ITI) between each test a dog completed (in days). (**ordinal**)
- **`median iti (minutes)`**: Median inter-test-interval (ITI) between each test a dog completed (in minutes). (**ordinal**)
- **`membership_id`**: Unique ID. (**categorical**)
- **`membership_type`**: Type of subscription. 1=Dognition Assessment of initial 20 games, 2=Annual, 3=Monthly, 4=Free, 5=Subscription type of membership chosen by the user. Annual subscriptions provide the Dognition Assessment plus 12 months of subscription service (one new test and activity are “unlocked” per month, beginning of the month after purchase). Monthly subscriptions provide the Dognition Assessment plus the subscription service billed monthly. Free subscriptions were either offered through a “free start” promotion or through the Dognition MOOC. These users have access to the first 4 games for free and can then upgrade to unlock the rest. The Subscription” option (value of 5) is a recent test that offers the entire 20-game Dognition Assessment for free, but then allows user to upgrade to a monthly subscription. (**categorical**)
- **`rank_by_dogid`**: The chronological rank of each test a dog completed (e.g. 1=first test dog completed, 3=third test dog completed, etc.). (**ordinal**)
- **`rank_by_userid`**: The chronological rank of each test a user completed (e.g. 1=first test user completed, 3=third test user completed, etc.). (**ordinal**)
- **`rating`**: The answer to the question “How surprising were [your dog’s name]’s choices?” Users could choose any number between 1 (not surprising) to 9 (very surprising)
- **`script_detail_id`**: Number corresponding with the exact webpage a customer was on. (**categorical**)
- **`script_id`**: An ID representing the type of Dognition activity users are engaged in. Numbers represent personality questionnaire (first set of questions after registering a dog), Dognition Assessment versions, other surveys, and monthly games available after the initial Dognition Assessment is completed. (**categorical**)
- **`sign_in_count`**: Number of times a user signs in to his/her Dognition account. (**ordinal**)
- **`start_time`**: Timestamp when user received a question in a Dognition test. (**ordinal**)
- **`state`**: State of the user. (**categorical**)
- **`step_type`**: Key for whether the test item was a question or a stopwatch. (**categorical**)
- **`subcategory_name`**: Name of the cognitive sub-category a test belongs to (Communication, Cunning, Empathy, Expression Game, Impossible Task, Laterality, Memory, Numerosity, Perspective Game, Reasoning, Self Control Game, Shaker Game, Shell Game, Smell Game, Social Bias, Spatial Navigation). (**categorical**)
- **`subscribed`**: Flag for whether a user has a paid subscription (1=Yes/0=No). (**binary**)
- **`test_name`**: Name of Dognition test. (**categorical**)
- **`time diff between first and last game (days)`**: Time difference between the first and last game completed by a dog (in days). (**ordinal**)
- **`time diff between first and last game (minutes)`**: Time difference between the first and last game completed by a dog (in minutes). (**ordinal**)
- **`total tests completed`**: Number of tests completed by the dog. (**ordinal**)
- **`updated_at`**: Time stamp when the record in that row was created (will be the same as created_at if the record was never updated). (**ordinal**)
- **`user_guid`**: Unique ID for a human user. (**categorical**)
- **`weight`**: Weight of the dog (lbs). (**ordinal**)
- **`zip`**: Zip code of the user. (**categorical**)
