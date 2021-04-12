# flutter_app

A new Flutter application.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

# sources

https://resocoder.com/2020/03/09/flutter-firebase-ddd-course-1-domain-driven-design-principles/

# Presentation

- widgets only
- state
- dumb

# Application

- Features
- Subfeatures
- No UI
- No business logic
- user input is validated (by calling things in the domain layer)

# Domain

- business logic
- does not depend on anything else
- everything depends on domain
- ideally should not care if you use rest api calls or firestore

# Infrastructure

- API
- Databases
- firebase
- DTO (Data Transfer Objects)
  - convert data between entities and value objects from the domain layer and the plain data of the outside world


# Notes:

- do not use async in init state


# Homework

- Rearange login
- research logins
- detail screen (not fetching again!)
- rename repository
- 