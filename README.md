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


