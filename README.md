# Headlines
An App that displays trend articles and allow the user to save news for reading later.

This Sample project is developed as part of coding evaluation.

## Explicit Project requirements.
-    As a user (of the application) I should be able to see three tabs: Headlines, Sources, Saved.
-    As a user I should be able to see list of current headlines of news in Headlines tab
-    As a user I should be able to see headlines based on user selected sources. 
-    As a user I should be able to see  title, description, author and thumbnail picture of headlines
-    As a user I should be able to tap on headlines and navigate to full article within the app.
-    As a user I should be able to save the article for reading later.
-    As a user I should be able to see list of available sources for articles.
-    As a user I should be able to select multiple source and persist for each sessions.
-    As a user I should be able to see saved article in saved tab.
-    As a user I should be able to select saved article and navigate to full article screen
-    As a user I should be able to delete saved articles by swiping right to left.

# Dependency Manager & Third-Party Libraries

### Cocoapods 
-   Application level Dependency Manager that provides a standard format for managing external libraries.
### Realm 
-  Realm is the first database built for mobile. An alternative to SQLite and Core Data that's fast, easy to use, and open source.
- [readme](../blob/master/Headlines/Headlines/Model/Doc)

## Project Architecture
This project has designed using The Model-View-ViewModel (MVVM) pattern separates objects into three types: models, views and view-models.

-   Models hold onto application data. They are usually structs or simple classes. eg. Headlines
-   View-models convert models into a format that views can use.
-   Views display visual elements and controls on screen. They are usually subclasses of UIView.

-   App start with HeadlinesViewController which displays current news headlines
-   User can read title, description and author name from HeadlinesViewController
-   User can select any headlines and read full article
-   User can save any article to read later
-   User can navigate to sources tab and select any source to see relevant headlines
-   User can see saved article in saved tab
-   User can delete the saved article by swiping right to left
-   User can see full article by selecting headlines

## User Interface Design.
-   The app is supported in all iOS Device family. The UI is adaptive accross all iOS Device.
-   All screens has been design in single storyboard. All Interface builder item has applied Autolayout and some has created via code too.
