# Sharon-Talon - iOS App for SHS Newspaper
![Screenshot 1](/assets/Screenshots.png) 

The app is built using Swift and Objective-C and basically works off of the xml rss newsfeed from the Talon website: https://shstalon.com/feed/. Using the feed, this app downloads articles at runtime so it doesn't have to be updated in future for new articles. The only time it would need an update is when the Talon website address changes. I have also included menus for the different categories found on the main page. 

While the rss feed is a nice way to fetch article names, their authors, thumbnails and other related metadata to show in the app, for showing the content of each article, I actually get the url of the article from the rss feed, download the ugly wordpress html, then extract the main html content of the article (found in the &lt;div&gt; tag with a class="entry-content") using SwiftSoup parser - https://github.com/scinfu/SwiftSoup (a JSoup clone) and manipulate it to fit onto the phone. I also extract, resize and show the main article image (again this is parsed from the raw html of the page - using the div.featured-image-wrap xpath). The thumbnails found in the articles list view are cached and fetched only once using Alamofire (https://github.com/Alamofire)

For parsing the xml rss feeds, I use the AlamofireRSSParser library (https://github.com/AdeptusAstartes/AlamofireRSSParser)

All library dependencies are maintained using cocoapods (https://cocoapods.org/) so that future updates to the app (for example, when we have a new ios version next year) are easy to do. Checkout the Podfile in the project for the version numbers.

##Release History

###__Version 1.4__ __(Feb 19, 2021)__
1. Fixed occasional crashes when "Pull down to refresh" is used.
1. Article list now scrolls to the top when a new category is selected.
1. When the article title spans 3 lines, the last line gets truncated. We now show up to 3 lines of text for the title.
2. Fixed alignment of the author name.

###__Version 1.3__ __(Feb 17, 2021)__
1. Fixed an issue when dark mode kicks in.
1. Fixed an issue with RSS parser while parsing article categories.
1. Added "Pull to refresh" to refresh articles

###__Version 1.2__ __(Feb 15, 2021)__
1. Bug Fix - Occasional crash when the newsarticle contains a video.
1. Reduced the spinner size when loading article images.
1. Fixed the font for article heading.
1. Removed the unused empty space at the top and bottom of the article

###__Version 1.1__ __(Feb 13, 2021)__

