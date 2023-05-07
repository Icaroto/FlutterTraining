class Todos {
  Todos(this.listBase);
/*
// { "name": "Pokemon Sword", "dex": "The Isle of Armor", "number": "380" },
// { "name": "Pokemon Shield", "dex": "The Isle of Armor", "number": "380" },
// { "name": "Let's Go Pikachu", "dex": "", "number": "006" },
// { "name": "Let's Go Eevee", "dex": "", "number": "006" }
//POST EXTRACT:
- Minor - All forms needs to be added (001)
- Oricorio - Name and Image

TODO: 
- Re organize the Games. Dexes and Trackers to be enums/objects
- With that in place, you can add properties on how the list can be displayed/
- eg. Vivillon shouldnt be grouped in one , but rather a flat list

TODO:
- On Living or any list tile of type Expand, keep it opened after ticking one

-- LINKS:
BANNER: https://www.geeksforgeeks.org/flutter-banner-widget/
TABBAR: https://stackoverflow.com/questions/51824959/tabbar-on-bottom-of-app-with-column
https://blog.logrocket.com/how-to-build-a-bottom-navigation-bar-in-flutter/#:~:text=BottomNavigationBar%20is%20a%20widget%20that,navigate%20to%20a%20given%20page.

TODO BUG:
  Alolan Sandslash breaks weakness
  Big names on details break
  When opening search background goes up
  Searching someting, going back then in again shows filtered result with everythign gone
TODO: Checklist:
  - Add 3 tab buttons: All, Missing, Captured
  - Add more options to floating button: Save, All shiny?, Create LF, FT
TODO: Replace the cards with the data they need instead of passing the whole pokemon object, that way it can be used on either screen (details or catch)
TODO: Replace nulls with ?????
TODO: Switch case for games
Style
  --> TODO: List style, text color is different
  --> TODO: Remove the Theme from the main dart
  --> TODO: Fix Name breaking on Giga and Mega pokes

Bugs
  --> If you keep a search text and go back to main screen and back to list, list is empty
  --> Keyboard opened raises image in the background. Need to keep in the same place.
  
Later:
  --> TODO: Add keywords for search
  --> TODO: Make loading generic to load ANY page
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
