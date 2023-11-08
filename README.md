# Dog Board - Flutter App

## Overview

“Dog Board” is a mobile application where you can find plenty of cute dog pictures. Besides its cuteness, the app was developed with Test Driven Development, considering the Clean Architecture, and best practices were diligently utilized.

<img src="screenshots/screenshot1.png" alt="App Screenshot" width="30%"> <img src="screenshots/screenshot2.png" alt="App Screenshot" width="30%"> <img src="screenshots/screenshot3.png" alt="App Screenshot" width="30%">

<img src="screenshots/screenshot4.png" alt="App Screenshot" width="30%"> <img src="screenshots/screenshot6.png" alt="App Screenshot" width="30%"> <img src="screenshots/screenshot5.png" alt="App Screenshot" width="30%">

## Architecture

The app is built following the principles of Clean Architecture, ensuring separation of concerns, testability, and maintainability. It employs a wide array of packages to achieve this robust architecture:

- **State Management:** `bloc`, `flutter_bloc`
- **Routing:** `auto_route`
- **Networking:** `dio`, `retrofit`
- **Dependency Injection:** `get_it`
- **Storage:** `hive`, `hive_flutter`,`path_provider`
- **Functional Programming:** `dartz`
- **Utilities:** `cached_network_image`, `equatable`, `json_annotation`, `json_serializable`
- **UI:** `cached_network_image`,`shimmer`, `lottie`
- **Testing:** `bloc_test`, `flutter_test`, `mocktail`
- **Code Generation:** `build_runner`, `retrofit_generator`, `auto_route_generator`

...among others. For a complete list, refer to the `pubspec.yaml`.

## Run The Project

### Prerequisites
- Flutter SDK version '>=3.1.4 <4.0.0'
  
### Setup and Run

1. **Clone the repository:**

```
git clone https://github.com/furkansoylemez/dog_board.git
```

2. **Navigate to the project directory:**

```
cd dog_board
```

3. **Install dependencies:**

```
flutter pub get
```

4. **Run the app:**

```
flutter run
```

## Tests

In the project, a total of 83 unit and widget tests were written, achieving a code coverage rate of over 73%. Additionally, end-to-end integration tests were written for the ImagesListByBreed and RandomImageByBreed features.

1. **Run Unit and Widget Tests:**

```
flutter test
```

2. **Run Integration Tests**

```
flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart
```

## File Structure

```
.
├── app
├── core
│   ├── app_router
│   ├── app_theme
│   ├── error
│   ├── extension
│   ├── mapper
│   ├── resources
│   └── use_case
├── data
│   ├── client
│   ├── data_source
│   ├── local_storage
│   │   └── hive_adapters
│   ├── model
│   │   └── base
│   └── repository
├── domain
│   ├── entity
│   ├── mapper
│   ├── repository
│   └── use_case
├── features
│   ├── dashboard
│   │   └── presentation
│   │       ├── bloc
│   │       └── page
│   ├── image_full_screen
│   │   └── presentation
│   │       └── page
│   ├── images_list
│   │   └── presentation
│   │       ├── images_list
│   │       │   └── page
│   │       ├── images_list_by_breed
│   │       │   ├── bloc
│   │       │   └── page
│   │       └── images_list_by_sub_breed
│   │           ├── bloc
│   │           └── page
│   └── random_image
│       └── presentation
│           ├── random_image
│           │   └── page
│           ├── random_image_by_breed
│           │   ├── bloc
│           │   └── page
│           └── random_image_by_sub_breed
│               ├── bloc
│               └── page
└── presentation
    └── widgets
```

