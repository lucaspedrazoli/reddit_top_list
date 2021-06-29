## To run the project
Create a `Environment.swift` file inside the `RedditTopList` folder.
Add this code in your environment file: 
```
import Foundation

struct Environment {

  static func run() {
    let token = "YOUR TOKEN HERE"
    let userSession = UserSessionDataSource()
    userSession.write(token, for: .accessToken)
  }
}
```

*Don't forget to replace the string with your reddit bearer token.*

## Architecture
The App artechitecutre was made with `MVVM` and `CLEAN` concepts.
![Clean Circle](https://user-images.githubusercontent.com/3194444/123875715-8b050c00-d910-11eb-9dc7-dcd44f77aae9.png)

Following the dependency rules, the circles represents different areas in the system. <br>
**Nothing in an inner circle can know anything at all about something in an outer circle**
* Entities: They represent the data that come from the Api.
* Data Sources: Know how to get access to the Data.
* Repositories: Know how to interact with the Data sources
* View Models: They will have the data logic and business rules of its context. They Can have one or more repositories to access different kinds of data. Furthermore, they can transform the data to make the view controllers life easier.
* View Controllers: Will have the User Interface stuff. Will use UIKit and others features to render data and get the User Input.
* Dependency injection: Will bind all these areas together. Can have A/B tests and replace interfaces for any reason.

## Considerations
* The `storyboard` were used superficially. Just to follow the guideline. I hope this is not a problem 👍
* When you open an image in the browser it will save **automatically** in your device.
* App state-preservation/restoration were made with `NSUserActivity`. A boolean value that represents a user interaction will be saved just to demonstrate the feature, since the app does not persist the table view data.





