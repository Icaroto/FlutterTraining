class Todos {
  Todos(this.listBase);
/*
Style
  --> TODO: Style for search bar on list (background too)
  --> TODO: List style, text color is different
  --> TODO: Remove the Theme from the main dart
  --> TODO: Fix Name breaking on Giga and Mega pokes

Functionality
  --> TODO: Try to fit weakness in the current detail page
  --> TODO: Improve list in the Games tab.
    --> TODO: Add number to each game
    --> TODO: Improve Game object (Game -> DLC/Sub Area Dex)
  --> TODO: Make loading generic to load ANY page
  --> TODO: Add keywords for search
  --> TODO: Move all logic to the Pokemon class (eg, shiny, forms, get list of abilities)
  --> TODO: Improve code to switch images

Bugs
  --> If you keep a search text and go back to main screen and back to list, list is empty
  --> Keyboard opened raises image in the background. Need to keep in the same place.
  
TODO: Clean code creating components, constants and etc
TODO: Properly pick the colors for Primary and Secondary based on ...something?


Later:
iOS fixes
  --> TODO: List to have a back button on iOS
  --> TODO: Details page remove static height/width as it breaks on iOS
  --> TODO: Check why image looks smaller on iOS????
TODO: Remove the wait 2 seconds from loading
TODO: Trackers, Collection, FT/LF
  --> TODO: Details to have Catch Data (Ball, OT, Ability)
  --> TODO: Component: Tab to switch between Shiny/Normal in tracker
  --> TODO: Make sure to keep the second image disabled until the pokemon is caught
TODO: Remove Stacks with kBasicBackground and move to Theme
TODO: Details Page to receive a list of pokemon in the right index
  --> TODO: Add swipe on detail page based on list
TODO: Get rest of database
TODO: Animations
  --> TODO: Make the ball spin
  --> TODO: List to Details image scaling (hero animation)

Maybe
TODO: Routes
*/
  String listBase;
}
