name: module_name
description: Module Name module.

publish_to: "none"

version: 1.0.0+1

environment:
  sdk: ">=2.12.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter

  # Add your dependency here
  common_ui:
    path: ../common_ui
  showcase_view:
    path: ../showcase_view  

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  pedantic:

flutter:
  uses-material-design: true

  module:
    androidX: true
    androidPackage: com.example.module_name
    iosBundleIdentifier: com.example.moduleName
