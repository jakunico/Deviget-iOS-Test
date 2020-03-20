# Deviget iOS Test

### Features

- Universal app
- Supports all iOS 13 devices
- Master-Detail UI using Xcode's template
- Fully built with Storyboards
- Fetch Posts from Reddit's API
- Load posts on demand through paging
- Pull to refresh fetches latest posts
- Dismiss all
- Dismiss individual posts
- Save post image
- No third party dependencies

### Missing features

I had to leave these out due to time constraints:

- Proper networking error handling and retry mechanism.
- App state preservation/restoration.
- Unit Tests / UI Tests.

### Architecture overview

- Used Xcode's Master-Detail template as a starting point.
- Used Model-View-Presenter approach (in `MasterViewController` and `DetailViewController` which are managed by `MasterPresenter`).
- Used Model-View-ViewModel approach (in `DetailViewController` and `PostTableCell`). Both of these receive a `PostViewModel` that contains all data necessary to display a `Post`.
- Networking layer uses Swift generics and response patterns providing an easy way to add more endpoints in the future.
- Swift's `Codable` is used to perform decoding of JSON data into our model objects.
- Swift's `URLSession` is used for all requests. Image requests check cache first before reaching the API for improved UX and loading times.
