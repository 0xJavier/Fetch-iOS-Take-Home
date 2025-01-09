# Fetch take home

This repo contains work for Fetch's take home iOS project

| Home | Recipe Detail | Source | Youtube
| - | - | - | - |
| ![Simulator Screenshot - iPhone 16 Pro - 2025-01-09 at 02 54 07](https://github.com/user-attachments/assets/b970e6bd-a281-4ee6-b3e7-61c9dc921729) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-09 at 02 55 14](https://github.com/user-attachments/assets/6fe9cb2c-11b3-4c0e-96fc-4f2a8b5dadb3) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-09 at 02 55 21](https://github.com/user-attachments/assets/14e61f38-0ed7-49ae-981a-bb5765c88443) | ![Simulator Screenshot - iPhone 16 Pro - 2025-01-09 at 02 55 56](https://github.com/user-attachments/assets/6fdb21fc-6e6e-461a-ac11-720ac13b61a9) |

### Steps to Run the App
---
Simply clone the repo, open the project up, select a device, and click run!

### Focus Areas: What specific areas of the project did you prioritize? Why did you choose to focus on these areas?
---
I tried to really focus on making the app modular and follow best practices in terms of dependency injection. As apps grow in size, both in features and team size, it’s essential to have a code base that allows you to work on features without stepping on other developers. This is what modularization helps solve as teams can work in individual modules and so this project has multiple modules. Another important topic is dependency injection in places like ViewModels as while testing UI is doable with things like snapshot testing, it’s essential to allow you to mock ViewModels and test core business logic.

### Time Spent: Approximately how long did you spend working on this project? How did you allocate your time?
---
While the core functionality of the app was up and running around the 5-hour mark, I took about an extra 2 hours to include extras like more unit testing and allow users to tap on and look at a recipe's written instruction or YouTube tutorial on how to make the dish.

### Trade-offs and Decisions: Did you make any significant trade-offs in your approach?
---
While trying to move fast to complete this project in a reasonable amount of time, I do feel like there was a trade-off with how some stuff is set up. An example is how UIViewControllers need boilerplate code in order to show a SwiftUI screen. While this could have been abstracted into a base class, I felt like this was something that could be left out in order to finish the project itself.

In terms of decisions, a big one was using UIKit+SwiftUI instead of a 100% SwiftUI app. While it is possible to create this app with pure SwiftUI, I have found that using both allows you to have the best of both worlds where the battle-tested UIKit can help with navigation while SwiftUI allows you to create entire screens in record speed.

### Weakest Part of the Project: What do you think is the weakest part of your project?
---
I would say the app has two weak areas in animation and presentation / UI when it comes to recipe details. When a user taps on a recipe, the current recipe model has limited information, and so I feel like the UI could have been improved on. Another area is app animations. I feel like I could have worked on adding more micro animations that give an app character, like when the home screen reloads its data or having a recipe's image transition to the detail view similar to iOS 18's [zoom transition](https://developer.apple.com/documentation/uikit/enhancing-your-app-with-fluid-transitions).

### Additional Information: Is there anything else we should know?
---
While the goal of this project was to show a single screen with recipes, I felt like adding extra features like recipe detail view and allowing users to open links through YouTube or Safari to learn more about a recipe really added to this project. Of course, you can do more to improve a codebase, but with the constraints and time put in, I feel like this is a good start for a scalable codebase that can allow teams to move and add features quickly.
