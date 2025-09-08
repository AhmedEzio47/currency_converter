# currency_converter

A mobile app that converts one currency to another.

## Build Instructions

To build and run the project, follow these steps:

1. Make sure you have both `git` and `flutter` SDK installed on your device.
2. Clone the repository by running:
   ```
   git clone https://github.com/AhmedEzio47/currency_converter.git
   ```
3. Get the project dependencies by running:
   ```
   flutter pub get
   ```
4. Run the app on an emulator or connected device using:
   ```
   flutter run
   ```
5. If you want to easily test the app on Android, you can download the
   APK [here](https://drive.google.com/file/d/1X1qswmtwy8LslG6rz18VStU3LyNn6KwR/view?usp=sharing):

## Architecture

This app follows the Clean Architecture pattern, which promotes testability, separation of concerns,
and maintainability. By organizing the code into distinct layers, it becomes easier to manage
dependencies and scale the application over time.

## Image Loader Library

The app uses the `cached_network_image` package to load images efficiently. This library provides
effective caching mechanisms that reduce network calls and improve overall performance, ensuring a
smoother user experience.

## Database

For local data storage, the app utilizes `Hive` as a part of the `flutter_common_package`, a
lightweight and fast key-value database that works
well with Flutter. `Hive` does not require a platform-specific database setup, making it easy to
integrate and maintain across different platforms. And it can be integrated with `dio` easily
by using `dio_cache_interceptor_hive_store`

