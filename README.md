# goole_sigin_firebase

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


//* For Firebase join collection to collection
[
====================================================



firestore
    .collection("projects")
    .where("projOwner", isEqualTo: id)

If you have 10 or less share IDs in the list, you can use an "in" query to find matches from projects, and it will not work with any more.

firestore
    .collection("projects")
    .where("projOwner", whereIn: listOfIds)

So, if you think the list could ever be larger than 10, you should just start by performing individual queries for each share ID.
========================================================================================
]