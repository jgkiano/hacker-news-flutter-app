# HN: Reader Flutter App

A Hacker News mobile app built with Dart and Flutter with some Firebase Cloud Function and Firestore magic.

[Download from Google Play Store](https://play.google.com/store/apps/details?id=me.kiano.hnr)

![alt sceenshot](https://storage.googleapis.com/me-kiano-static/grouped-screens.jpg)

## Features

* View list of top HN stories with original article images
* View list of top HN jobs
* Offline capabilities
* Dark mode 🌚 Because its 2019

## Under the hood

Articles / Jobs are fetched using the public [HN API](https://github.com/HackerNews/API) every 4 hours by a couple of Firebase cloud functions. The Cloud Functions then scrap the webpages of the articles to obtain images and descriptions of the articles. The result of this is then stored into Firebase Firestore which the app uses to display the articles / jobs.
