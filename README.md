### CHAT APP FLUTTER
 Testing App For Flutter Chat_app Using FireBase as Backend

 Staring 12-09-2022 to 30 -09- 22
  

 ************************************************************
 ## For Auth in Firebase we use 

 1.Phone Auth && Google SigIn 
 
 ### Using Provider as StateManagement


## For  FireStore Query 

====================================================

    First off, how can I get each document in the share list's ID?

For this, you're required to actually query the entire collection. You can iterate the results to collect the IDs of each document. There is no easy way to just get a list of IDs directly from web and mobile client code. See: How to get a list of document IDs in a collection Cloud FireStore?

    And secondly, is it possible to compare that ID to the contents of a List using a .where() clause?

If you have a list of document ID strings in memory that could be any length, you will need to perform a query filtering projects for "projOwner" for each individual ID. There are no SQL-like joins in FireStore, so you can't simply join the two collections together with a single query.

Here's how you do a single one - you have to call out the name of the field to filter on:

FireStore
    .collection("projects")
    .where("projOwner", isEqualTo: id)

If you have 10 or less share IDs in the list, you can use an "in" query to find matches from projects, and it will not work with any more.

FireStore
    .collection("projects")
    .where("projOwner", whereIn: listOfIds)

So, if you think the list could ever be larger than 10, you should just start by performing individual queries for each share ID.
========================================================================================
]