RadioStationApp

MVVM Architecture: The app follows the Model-View-ViewModel (MVVM) design pattern to separate business logic from UI code, enhancing maintainability and testability.

Data Fetching: The app fetches radio station data from an external API using asynchronous networking calls. Data is decoded into Swift structures for use in the app.

User Interaction: Users can view radio stations, mark them as favorites, and access their favorites list. Changes to favorites are reflected in the UI in real-time through the use of @Published properties and @EnvironmentObject.

Persistent Storage: The app saves the user's favorite stations using UserDefaults, enabling persistence across app launches.

