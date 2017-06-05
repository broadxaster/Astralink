# Astralink
Introduction
=========================
iOS application that displays the most trending repositories on GitHub that were created in the last day, last week and last month. The user should be able to choose which timeframe they want to view. In the same screen, the list of trending repositories sorted by the number of stars should be shown in some kind of list

Design
=========================
Astralink sample app composed of 3 main pieces:**Network manager**, **Model**, **User Defaults Utils**
1. **Network** - The network layer manage all the request/response and expose block function for async task
2. **Model** - The Model layer manage all the parsing into easy to use model
2. **User Defaults Utils** - The User Defaults Utils layer manage all the persistent data (favorites)

Getting Started
=========================
1. Please run pod install terminal command
2. open the Astralink.xcworkspace

open source libraries
=========================
1. **Almofire** - a HTTP networking library written in Swift https://github.com/Alamofire/Alamofire
2. **SDWebImage** - provides an async image downloader with cache support https://github.com/rs/SDWebImage

Not implemented features
=========================
1. UI that is better suitable for iPads
2. Implement search for each list.
3. Provide a clear user experience when there is no internet connection.
