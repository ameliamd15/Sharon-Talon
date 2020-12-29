# Sharon-Talon

iOS App for Sharon High School Newspaper

The app is built using Swift and Objective-C and basically works off of the xml rss newsfeed from the Talon website: https://shstalon.com/feed/. Using the feed, this app downloads articles at runtime so it doesn't have to be updated in future for new articles. The only time it would need an update is when the Talon website address changes. I have also included menus for the different categories found on the main page. 

While the rss feed is a nice way to fetch article names, their authors, thumbnails and other related metadata to show in the app, for showing the content of each article, I actually get the url of the article from the rss feed, download the ugly wordpress html, then extract the main html content of the article (found in the &lt;div&gt; tag with a class="entry-content") using SwiftSoup parser - https://github.com/scinfu/SwiftSoup (a JSoup clone) and manipulate it to fit onto the phone. I also extract, resize and show the main article image (again this is parsed from the raw html of the page - using the div.featured-image-wrap xpath). The thumbnails found in the articles list view are cached and fetched only once using Alamofire (https://github.com/Alamofire)

For parsing the xml rss feeds, I use the AlamofireRSSParser library (https://github.com/AdeptusAstartes/AlamofireRSSParser)

All library dependencies are maintained using cocoapods (https://cocoapods.org/) so that future updates to the app (for example, when we have a new ios version next year) are easy to do. Checkout the Podfile in the project for the version numbers.

