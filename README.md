# Gazpacho-with-Rotten-Tomatoes
## Rotten Tomatoes Client

This is a movies app displaying box office and top rental DVDs using the [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON).

Time spent: 24h

### Features

#### Required

- [X] User can view a list of movies. Poster images load asynchronously.
- [X] User can view movie details by tapping on a cell.
- [X] User sees loading state while waiting for the API.
- [X] User sees error message when there is a network error
- [X] User can pull to refresh the movie list.

#### Optional

- [X] All images fade in. Only when coming from network, not cache. 
- [X] Segmented control to switch between list view and grid view
- [X] For the larger poster, load the low-res first and switch to high-res when complete.
- [X] All images are cached in memory and disk: AppDelegate has an instance of `NSURLCache` and `NSURLRequest` makes a request with `NSURLRequestReturnCacheDataElseLoad` cache policy. I tested it by turning off wifi and restarting the app.
- [X] Customize the highlight and selection effect of the cell.
- [X] Customize the navigation bar.
- [X] Add a tab bar for Box Office and DVD.
- [X] User can save movies in watchlist (Extra)
- [X] Custom App icon and Launch Screen (Extra)

### Walkthrough
![Video Walkthrough](http://i.imgur.com/7XS7rsz.gif)
![Video Walkthrough](http://i.imgur.com/x3Xq2Qf.gif?1)

Credits
---------
* [Rotten Tomatoes API](http://developer.rottentomatoes.com/docs/read/JSON)
* [AFNetworking](https://github.com/AFNetworking/AFNetworking)
* [MRProgress](https://github.com/mrackwitz/MRProgress)
