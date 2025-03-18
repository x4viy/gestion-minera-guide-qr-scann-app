# PedidosApp

```
flutter --version
```
This flutter app uses clean architecture principles and 
bloc state management.

Flutter 3.29.2 • channel stable • https://github.com/flutter/flutter.git
Framework • revision c236373904 • 2025-03-13 16:17:06 -0400
Engine • revision 18b71d647a
Tools • Dart 3.7.2 • DevTools 2.42.3

## Tipos de Commit

Los siguientes son los tipos de commit que se deben utilizar:

### feat
- **Descripción**: Indica la adición de una nueva funcionalidad para el usuario.
- **Ejemplo**: `feat(auth): add login with email`

### fix
- **Descripción**: Solución de un bug o error en el código.
- **Ejemplo**: `fix(ui): correct alignment in dashboard`

### docs
- **Descripción**: Cambios en la documentación, como modificaciones en el README o comentarios en el código.
- **Ejemplo**: `docs(readme): update installation instructions`

### style
- **Descripción**: Cambios de formato que no afectan la lógica del código, como espacios en blanco, comas, o formateo.
- **Ejemplo**: `style: reformat code in utils module`

### refactor
- **Descripción**: Cambios en el código que no corrigen errores ni añaden funcionalidades, sino que mejoran su estructura o legibilidad.
- **Ejemplo**: `refactor(api): improve response handling`

### test
- **Descripción**: Añadir o modificar pruebas existentes sin cambiar la funcionalidad del código.
- **Ejemplo**: `test(auth): add unit tests for login`

## Directory structure

### Root Directory
- **di/**: Dependency injection configuration files.
  - **init_dependencies.main.dart**: Main dependency initialization for the application.

- **main.dart**: Entry point of the application.

## src/
- **core/**: Core functionalities and utilities shared across the application.
  - **common/**: Common components and utilities.
    - **app_user/**: User-related state management.
    - **cubits/**: General state management cubits.
    - **database/**: Database-related utilities.
    - **entities/**: Core entities used across the application.
    - **widgets/**: Common reusable widgets.

  - **error/**: Error handling utilities.
  - **helper/**: Helper functions and utilities.
  - **network/**: Network-related utilities.
  - **router/**: Routing utilities and configurations.
  - **secrets/**: Application secrets and configurations.
  - **styles/**: Styling utilities and configurations.
  - **theme/**: Theme-related configurations.
  - **translations/**: Localization and translation utilities.
  - **usecase/**: Use case definition.
  - **utils/**: General utilities.

- **features/**: Feature-specific directories.
  - **auth/**: Authentication feature.
    - **data/**: Data layer for authentication.
      - **datasources/**: Data sources for authentication (local/remote)
      - **models/**: Data models for authentication.
      - **repositories/**: Repository implementations for authentication.

    - **domain/**: Domain layer for authentication.
      - **repository/**: Repository interfaces for authentication.
      - **usecases/**: Use cases for authentication.

    - **presentation/**: Presentation layer for authentication.
      - **bloc/**: BLoC (Business Logic Component) for authentication.
      - **pages/**: UI pages for authentication.
      - **widgets/**: Reusable widgets for authentication.

  - **home/**: Home feature.
    - **data/**: Data layer for home.
      - **datasources/**: Data sources for home.
      - **models/**: Data models for home.
      - **repositories/**: Repository implementations for home.

    - **domain/**: Domain layer for home.
      - **repository/**: Repository interfaces for home.
      - **usecases/**: Use cases for home.

    - **presentation/**: Presentation layer for home.
      - **bloc/**: BLoC (Business Logic Component) for home.
      - **pages/**: UI pages for home.
      - **widgets/**: Reusable widgets for home.

- **shared/**: Shared utilities and components across features.
