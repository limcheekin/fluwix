include: package:pedantic/analysis_options.yaml

analyzer:
  errors:
    import_of_legacy_library_into_null_safe: ignore

  exclude:
    - "**/*.g.dart"
    - "**/*.freezed.dart"
    - "**/*.mocks.dart"
    - "**/generated_plugin_registrant.dart"