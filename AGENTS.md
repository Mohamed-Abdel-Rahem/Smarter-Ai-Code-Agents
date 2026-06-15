# Project Guide

## Overview
This is a Flutter application named `smart_ai_code_agent`. The current app is the default Flutter counter example: `lib/main.dart` defines the app entry point, a Material app, and a stateful home page with a counter incremented by a floating action button. The project is still in an early starter state, with one widget test in `test/widget_test.dart`.

## Architecture
The current code is not yet split into Clean Architecture layers. As features are added, use this structure:

- presentation: Flutter widgets, screens, BLoC classes, events, states, and UI-only formatting.
- domain: entities, repository contracts, use cases, value objects, and domain errors.
- data: models, data sources, repository implementations, API clients, local storage, and mapping between models and domain entities.

## Key Patterns
- BLoC only for state management
- Clean Architecture
- Repository abstraction
- Use cases for business logic
- Models map to/from entities
- Domain errors instead of silent failures

## Feature Modules
No feature folders exist yet. The project currently has only `lib/main.dart`, which contains the starter counter UI. When features are introduced, create a folder per feature and keep its presentation, domain, and data code grouped clearly by responsibility.

## Tech Stack
- Flutter app project on the stable channel, based on the Flutter revision recorded in `.metadata`.
- Dart SDK constraint: `^3.11.5`.
- Runtime packages:
  - `flutter`
  - `cupertino_icons: ^1.0.8`
- Development and test packages:
  - `flutter_test`
  - `flutter_lints: ^6.0.0`

## Dependency Injection
No `get_it` or `injectable` setup is currently present. When dependency injection is added, register repositories, data sources, use cases, and BLoC factories through the DI layer instead of constructing dependencies directly in widgets.

## Error Handling
Data sources should convert low-level exceptions into typed failures or errors. Repository implementations should return domain-level errors instead of leaking platform, network, or persistence exceptions. Use cases should expose success or failure clearly to presentation. BLoC should translate domain errors into user-facing states, messages, or recovery actions.

## Testing
The current test pattern is a Flutter widget smoke test in `test/widget_test.dart`, which pumps `MyApp`, taps the add icon, and verifies that the counter changes from `0` to `1`.

As the app grows, test:
- use cases for business rules and domain error handling
- repository implementations with mocked data sources
- BLoC state transitions for success, loading, and failure paths
- widgets for visible behavior and user interactions

## Agent Rules
- Do not put business logic in UI
- Do not bypass repositories
- Do not use Cubit
- Do not run terminal commands unless I ask
- Modify only needed files
- Keep code English only
