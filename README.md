# Sharon-Talon

IOS App for Sharon High School Newspaper

The app basically works off of the xml rss newsfeed from the Talon website: https://shstalon.com/feed/

Currently I have also included the different categories found on the main page. This app downloads articles at runtime so needs no updating in future unless the website address changes. 
While then rss feed is a nice way to fetch articles, their authors, thumbnails and other related metadata to show in the app, for showing the content of the articles, I actually get the url of the article from the rss feed, get the html, then extract the main html content of the article using Swift JSoup parser and manipulate it to fit onto the phone
