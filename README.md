### To build the application please:
- Clone the repository from version control.
- Open the project in Xcode.
- Build the project using the appropriate scheme and target.
- No third party library installation needed

### To run the application please:
- Select a target device or simulator in Xcode.
- Run the application using the "Run" or "Build and Run" command.
- No API keys or additional configurations needed

### Decisions

For this project I've decided to use MVVM + Coordinators pattern as it good in reusability (encapsulating the logic which can be shared across multiple views, reducing code duplication) and scalability (as the app grows, we can add new views, viewModels and coordinators without changes to existing code).

### Assumptions
1) UI and Design Decisions
   I assumed that the application should follow standard iOS design guidelines as no specific design instructions were provided. This ensures a familiar and intuitive user experience.
2) Navigation
   It was assumed that the navigation in the project would be managed using coordinators. This decision aligns with common iOS app architectures and provides a smooth user experience.
3) Network Conditions
   The app is intended to be used in environments with stable internet connectivity. This assumption helped focus on core functionality without implementing extensive offline capabilities or complex error handling for network issues.
4) Device Compatibility
   The application is designed to run on devices with iOS 17.0 or later. This assumption was made to utilize the latest SwiftUI features and provide a modern user interface (partly).

### Challenges
1. Integrating SwiftUI with UIKit
Challenge: Integrating SwiftUI views within an existing UIKit-based project presented several challenges, especially with navigation and state management.

Solution: To overcome this, a UIHostingController was used to embed SwiftUI views within the UIKit structure. Navigation was managed by coordinating between UINavigationController for UIKit views and SwiftUI navigation mechanisms. Proper state management techniques, such as using @State and @ObservedObject, were employed to ensure data consistency and smooth interaction between the two frameworks.

2. Challenge: Managing the state of dynamically created buttons with one framework and use it as a part of another to ensure only one button is selected at a time, and providing visual feedback was complex.

Solution: Implemented state management within the SortButtonsView using @State to track the selected button. The button's appearance was dynamically updated based on this state.
