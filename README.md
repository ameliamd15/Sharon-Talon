# Sharon-Talon

IOS App for Sharon High School Newspaper

The app basically works off of the xml rss newsfeed from the Talon website: https://shstalon.com/feed/. Using the feed, this app downloads articles at runtime so it needs no updating in future unless the website address changes. 

Currently I have also included the different categories found on the main page. 
While the rss feed is a nice way to fetch article names, their authors, thumbnails and other related metadata to show in the app, for showing the content of each article, I actually get the url of the article from the rss feed, get the html, then extract the main html content of the article using SwiftSoup parser - https://github.com/scinfu/SwiftSoup (a JSoup clone) and manipulate it to fit onto the phone

For parsing the xml rss feeds, I use https://github.com/Alamofire/Alamofire and https://github.com/Alamofire through CocoaPods.

