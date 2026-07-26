# dermaai

lib/
├── core/
│   ├── constants/
│   │   └── app_constants.dart
│   ├── theme/
│   │   └── app_theme.dart
│   ├── network/
│   │   ├── api_client.dart
│   │   └── api_exception.dart
│   ├── router/
│   │   └── app_router.dart
│   └── widgets/
│       ├── custom_button.dart
│       ├── disclaimer_card.dart
│       └── shimmer_placeholder.dart
├── features/
│   ├── analysis/
│   │   ├── data/
│   │   │   ├── models/
│   │   │   │   └── analysis_model.dart
│   │   │   └── repositories/
│   │   │       └── analysis_repository_impl.dart
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   │   └── analysis_result.dart
│   │   │   └── repositories/
│   │   │       └── analysis_repository.dart
│   │   └── presentation/
│   │       ├── bloc/
│   │       │   ├── analysis_bloc.dart
│   │       │   ├── analysis_event.dart
│   │       │   └── analysis_state.dart
│   │       └── screens/
│   │           ├── home_screen.dart
│   │           ├── image_preview_screen.dart
│   │           ├── loading_screen.dart
│   │           └── result_screen.dart
│   ├── history/
│   │   └── presentation/
│   │       └── screens/
│   │           └── history_screen.dart
│   └── settings/
│       └── presentation/
│           └── screens/
│               └── settings_screen.dart
├── injection/
│   └── dependency_injection.dart
├── main.dart
└── root_navigation_wrapper.dart