<p align="center">
<img src="https://raw.githubusercontent.com/Shashwat-Joshi/WikiSearch/main/docs/assets/wikisearch.svg" height="130" alt="WikiSearch" />
</p>

<p align="center" style="margin-bottom: 50px">
<a href="https://github.com/Shashwat-Joshi/WikiSearch/issues">
        <img src="https://img.shields.io/github/issues/Shashwat-Joshi/WikiSearch" alt="Issues"></a>
    <a href="https://github.com/Shashwat-Joshi/WikiSearch/network/members" alt="Forks">
        <img src="https://img.shields.io/github/forks/Shashwat-Joshi/WikiSearch" /></a>
    <a href="https://github.com/Shashwat-Joshi/WikiSearch/stargazers" alt="Stars">
        <img src="https://img.shields.io/github/stars/Shashwat-Joshi/WikiSearch" /></a>
    <a href="https://github.com/Shashwat-Joshi/WikiSearch/graphs/contributors">
        <img src="https://img.shields.io/github/contributors/Shashwat-Joshi/WikiSearch"
            alt="Contributors"></a>
    <a href="https://github.com/Shashwat-Joshi/WikiSearch/blob/main/LICENSE">
        <img src="https://img.shields.io/github/license/Shashwat-Joshi/WikiSearch"
        alt="License"></a>
    <a href="https://flutter.dev/">
        <img src="https://img.shields.io/badge/-Flutter-blue"
            alt="Flutter"/></a>
</p>

# Table of contents

<!--ts-->
   * [Project Description](#Project-Description)
   * [Working](#Working)
      * [App Architecture](#App-Architecture)
      * [BLoC/Cubit Pattern](#bloccubit-pattern)
      * [Caching using HiveDB](#Caching-using-HiveDB)
   * [App UI](#App-UI)
   * [Project Setup](#Project-Setup)
   * [To-Do](#To-Do)
   * [How to get started with Flutter](#How-to-get-started-with-Flutter)
<!--te-->


# Project Description
- WikiSearch is a [Flutter](https://flutter.dev/) search engine which was build using BLoC/Cubit pattern and powered by the [MediaWiki](https://www.mediawiki.org/wiki/API:Main_page) API.
- It also uses the [NewsApi](https://newsapi.org/) to show the latest news in its homescreen.
- WikiSearch also uses caching to improve UX, for caching we have used a NoSQL database called [HiveDB](https://docs.hivedb.dev/#/).


# Working


## App Architecture
<center>
<img alt="App Architecture" src="https://raw.githubusercontent.com/Shashwat-Joshi/WikiSearch/main/docs/assets/app_architecture.png">
</center>

### Application logic flow :
1. When initiated either by a function call or initState, cubit receives this request.
2. Then the cubit calls the repositories which further makes an API call to fetch this data.
3. This data is stored in the cubit and once successful the cubit emits a suitable state and UI changes accordingly.
4. If the data was fetched successfully it is cached using HiveDB.
5. The UI is displayed according to these states.


## BLoC/Cubit Pattern
BLoC is a state management solution for flutter. In this project we have used cubit pattern.  
Below is a diagramatic representation of how cubit pattern works :
<center>
    <img style="margin-top: 20px; margin-bottom: 20px" src="https://raw.githubusercontent.com/Shashwat-Joshi/WikiSearch/main/docs/assets/cubit.png">
</center>  

To know more about BLoC: https://github.com/felangel/bloc


## Caching using HiveDB

<img src="https://raw.githubusercontent.com/hivedb/hive/master/.github/logo_transparent.svg?sanitize=true" width="160" height="160" alt="Flutter logo" align="right">

Caching is used to improve the app's performance in terms of UX, caching in this app was implemented using [HiveDB](https://docs.hivedb.dev/#/).

**Hive** - Hive is a lightweight and blazing fast key-value database written in pure Dart.  
Hive is a NoSQL database which has really great performance in terms of both write and read operations. 

### Data we are caching in this application:
1. Search history (whatever keywords the user searched for).
2. List of wiki articles that are being fetched from the MediaWiki API.


# App UI

<div style="text-align: center">
    <table><tr>
        <td style="text-align: center">
            <img src="https://raw.githubusercontent.com/Shashwat-Joshi/WikiSearch/main/docs/assets/news_list.gif" width="250"/>
        </td>
        <td style="text-align: center">
            <img src="https://github.com/Shashwat-Joshi/WikiSearch/blob/main/docs/assets/wiki_search.gif?raw=true" width="250"/>
        </td>
        <td style="text-align: center">
            <img src="https://github.com/Shashwat-Joshi/WikiSearch/blob/main/docs/assets/cache_demo.gif?raw=true" width="250"/>
        </td>
        <td style="text-align: center">
        </td>
    </tr></table>
</div>

# Project Setup

The basic steps you need to follow to get started with this project.

**Requirements :**   
- [Flutter](https://flutter.dev/docs/get-started/install) and [Dart](https://dart.dev/get-dart) SDK
- [git](https://git-scm.com/downloads)

**Step 1: Clone this repo**
```
git clone https://github.com/Shashwat-Joshi/WikiSearch.git
```

**Step 2: Run these commands in the project directory to download the required packages**
```
flutter clean
flutter pub get
```

**Step 3: To run the project in release**
```
flutter run --release
```

# To-Do

- [ ] Implementing pagination (⭐ caching should only be done for top 10 results)  
    - [ ] Pagination for top news in home screen.
    - [ ] Pagination for wiki search results  
- [ ] Light Theme mode (🌓)
- [ ] Connecting weather API 
  - [ ] Fetch data from weather API and display it on home screen.
  - [ ] Cache weather data.
- [ ] Improving documentation (😅)

# How to get started with Flutter

<img src="https://raw.githubusercontent.com/github/explore/80688e429a7d4ef2fca1e82350fe8e3517d3494d/topics/flutter/flutter.png" width="160" height="160" alt="Flutter logo" align="right">

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
