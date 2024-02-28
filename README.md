**SQL Query Example for Video Game Sales and Review Data By Michael O'Shea**
The purpose of this portfolio is to build a database, execute queries and showcase SQL Knowledge. For this project I used MySQL Workbench which is a visual database design tool that MySQL develops. It is a great tool for project like this, because it is free and extremely user friendly. For more information on MySQL workbench you can visit this website (https://www.mysql.com/products/workbench/). The data used in this project was sourced from datacamp.com (https://projects.datacamp.com/projects/1413), however, it was originally sourced from kaggle.com (https://www.kaggle.com/datasets/holmjason2/videogamedata/data). There were a few challenges I encountered during this project, for example, every SQL Relationship Database Management System has slightly different rules and functions. In MySQL I was having some trouble using Set Operators (EXCEPT and INTERSECT), but I was able to get around the issues by creating temporary tables. Another issue I ran into is that the data was originally all set up as one file from kaggle.com, which meant I had to do some data cleaning to split it up to the way the project was designed. 

**_Data Camp_**
Detacamp.com is a great website to learn and practice sql. This project specifically was designed by a data camp user for others to practice. The instructor of this project is Izzy Webber (https://www.datacamp.com/portfolio/izzyweber-9bc35945-95bd-423b-833e-40780c76586f)


**_Using the software_**
The software can be downloaded from this website:
MySQL Workbench: https://dev.mysql.com/downloads/workbench/
After downloading the software, create a connection on the local server. Once the connection is established go to the schemas tab and right click to create a schema called videogame_data. To create the individual tables in the schema, run this command (use videogame_data;) then run the create table statements. Once the tables are created the SQL script with all of the queries will work.

**_The Data_**
As mentioned above, the data required some cleaning to get it in the format necessary for the analysis. I used excel mainly for the data cleaning. I split up the one file into two files originally; one with sales data and one with reviews data. I then create ID fields for each of these tables. I also created an id for game name (game_id) then split the game name field into its own table. This resulted in three total tables: sales, reviews, and game_names.

Specific fields in the data:
game_name: The name of the game
Platform: The type of game system that the game was used on. (i.e. Wii, PC, Xbox, Playstation)
Publisher: The company that published the game. (i.e. Nintendo, Valve, PUBG Corporation)
games_sold: The number of games sold in millions.
Years: The year the game was released.
user_score: The review score that users gave to the game on average.
critic_score: The review score that critics game the game on average.
