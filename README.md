# GithubTrends

### Requirements
- [x] Show github trending projects (via search)
- [x] Show project's details when a cell is tapped
- [x] Use MVVM
- [x] Use ReactiveCocoa 7.2.0
- [x] Use Swift 4.1.2

### Installation
1. Download or clone the project
2. Run 'carthage update --platform iOS' in the root folder. For steps to install carthage go here: https://github.com/Carthage/Carthage
3. With XCode 9.4.1 or above, open the GithubTrends.xcodeproj and hit run

### How the App works

The home screen of the app contains a search bar and a table view to show the results as the user types. The search will start triggering when the search text contains at least 3 characters. Each text added after that will generate a search, there's a throttle time of 1 second to not saturate the app and the backend with multiple search in a very short amount of time. The Github API only allows 10 searches per minute for open usage, the app will stop showing new results when this max rate is exceeded.

The results will show up in the table view and when the user taps, they will be taken to the project's detail screen. This screen shows more information about the project and it's owner, as well as a webview showing the raw data of the readme file.

### To-do list
- [ ] Show some errors to the users
- [ ] Add documentation
- [ ] Add more unit tests
- [ ] Make the tableview datasource reactive and reusable
- [ ] Improve service layer to make it reusable and separate the request logic
- [ ] Check network connection
- [ ] Add pager to the results
- [ ] Add splash screen, icon
- [ ] Improve design
