# Transformers
### Version
1.0 

## Description
The Transformer App is a demo product showcasing a mobile application that provides a user interface for a provided API. The way in which the user interface is displayed is open-ended and we encourage you to be creative with your design..

## Requirement
- iOS 10.0+ || Xcode 11.7+
- Language : Swift 5.0

## Usage
As application is using CocoaPods you will need to install them.

Steps:
- Clone the repo, and run `pod install` from the project path first.
- Open Transformer.xcworkspace file
- Run on any iOS Device


## Getting started
In order to run the Transformer App it would be requiring an internet connection. Home page contains two buttons Cybertron and Battlefield. If app is being opend for first time data needs to be added. In order to do so, go to Cybertron and then go to create plage to create a transformer with respective details. Once added you will be redirected to list of transformer screen. Repeat the step to add as many transformers requried. (Note: In order to go to battlefield you are requried to have atleast one autobot and one decepticon). 
Once transformers are added go to battlefied from home page to see who won the fight. In order to see final results go to result page.

### Transformer definition
Each Transformer has the following criteria (ranked from 1 to 10) on their ​tech spec​: 
● Strength ● Intelligence ● Speed ● Endurance ● Rank ● Courage ● Firepower ● Skill
The “overall rating” of a Transformer is the following formula: (Strength + Intelligence + Speed + Endurance + Firepower).
Each Transformer must either be an Autobot or a Decepticon.

###  Basic rules of the battle:
- The teams should be sorted by rank and faced off one on one against each other in order to determine a victor, the loser is eliminated

#### A battle between opponents uses the following rules:
- If any fighter is down 4 or more points of courage and 3 or more points of strength compared to their opponent, the opponent automatically wins the face-off regardless of
overall rating (opponent has ran away)
- Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they win the fight regardless of overall rating
- The winner is the Transformer with the highest overall rating
- In the event of a tie, both Transformers are considered destroyed
- Any Transformers who don’t have a fight are skipped (i.e. if it’s a team of 2 vs. a team of 1, there’s only going to be one battle)
- The team who eliminated the largest number of the opposing team is the winner

### Special rules:
- Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
- In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroyed


## Design Pattern

### MVVM architecture
MVVM (Model-View-ViewModel) is derived from MVC(Model-View-Controller). It is introduced to solve existing problems of Cocoa's MVC architecture in iOS world. One of its feature is to make a better seperation of concerns so that it is easier to maintain and extend.

- Model: It is simillar to model layer in MVC (contains data)
- View: UIViews + UIViewControllers (Both layout view and controllers as View)
- ViewModel: A mediator to glue two above layer together. (contains business logic)

> Note: An important point in MVVM is that it uses a binder as communication tool between View and ViewModel layers. A technique named Data Binding is used.
Also MVVM gives more benifit in Unit testing as code is decoupled, testing can be done easily for business logic.


## Constants
The `Contacts` folder that can be found in the root `Transformer` folder contains constants for different purposes split between their according `structs`, such as:
* ServiceConstants
* AppConstants
* AppStrings

    There are several structs per requriment these can be modified or more can be added.
    
## Storyboard
The `Storyboard` folder that can be found in the root `Transformer` folder contains constants all storyboard used in the application.

#### Storyboard.swift
The `Storyboard.swift` file can be used to maintain different storyboard.
> Note: If in future more storyborad are added in project, just add those in this file and use accordingly.

## Utility
The `Utility` folder that can be found in the root `Transformer` folder contains `keychain` file which is being used to store/retrive important data from keychain of the application.

## Model
The `Model` folder that can be found in the root `Transformer` folder contains all models data for the application. (Model - part of MVVM design pattern)

## Controllers
The `Controllers` folder that can be found in the root `Transformer` folder contains all view and view models for respective screens in the application. This folder further contains more folder such as:
* General
* Home
* Cybertron
* Battlefield
These folder are structured in a manner of the app flow.
General contains the BaseViewController responsible for any comman functionality needed to be implimented for different view controllers.
Where as `Home -> Cybertron -> Battlefield` is the flow of the application

Further `Cybertron` contains two more folders as the flow extends `Cybertron -> List -> Create`.
Also  `Battlefield` contains two more folders as the flow extends `Battlefield -> Battlefield List -> Result`.

For every folder which represents the particular screen in the flow of the application, there are two more floder `View` and `ViewModel`
* `View` - Contains the view for that particular screen. Display visual elements and controls on the screen. View is represented by View and ViewController.
* `ViewModel` - Contains the business logic/ data management for those particular view. Responsible for transforming model information into values that can be displayed on a view. It interacts with the Network layer to retrieve the data. This layer will notify the changes in data to the View layer using completion handler/delegation.

> Note: View and View Model are kept seperate in order to follow the MVVM pattern in order to segregate the logics.

## SupportFiles
The `SupportFiles` folder that can be found in the root `Transformer` folder contains all resources for the application.

## ConfigFiles
The `ConfigFiles` folder that can be found in the root `Transformer` folder contains constants all configuration files in the application. If needed more configurations can be added for different environments.
> Note: This file contains the BaseURL for the secific environment. This url can be changed from this file for different environments.

## NetworkLayer
The `NetworkLayer` folder that can be found in the root `Transformer` folder contains constants all resources responsible to make API calls.

## Theme
The `App Theme` can be changed through  `UIColorExtension`  and  `UIFontExtension`. Also if needed UIFontExtension can be used to give different fonts for different devices.

## Unit Testing
- Unit testing achived via XCTest. 
- Test cases have been written for all the business logic applied in the application.
- function names are kept Self-explanatory manner, so that they will explain what they will achive : ` test_(task to be achived)_(function name to be tested) `.
- AAA ( Arrange - Act - Assert ) Testing Rule has been followed to make the test cases.

## Libraries
`CocoaPods ` is used for adding third party library.
### Libraries
- 'SDWebImage' : For image cache
- 'ProgressHUD' : For showing hud while network call is being made
- 'SwiftLint' : Enforce Swift style and conventions


## Assumptions        
- App support english language.
- Only portrait mode supported.
- Network is always available while using the app.

## Improvements
- Network Check for API calls
- Localization
- UI Test cases
- All librarys can be removed and custom cache/hud can be implimented

