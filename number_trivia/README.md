# number_trivia

## Overview
The number trivia module showcases Flutter App Architecture using the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package.

![Number Trivia image](https://github.com/limcheekin/fluwix/raw/main/number_trivia/images/thumbnail.png "Number Trivia image")

The codes here considered the latest code of the [Flutter TDD Clean Architecture Course](https://resocoder.com/2019/08/27/flutter-tdd-clean-architecture-course-1-explanation-project-structure/) with the following changes:
 - Dependencies updated to the latest version and null safety support.
 - Replaced [data_connection_checker](https://pub.dev/packages/data_connection_checker) package to [connectivity_plus](https://pub.dev/packages/connectivity_plus) as it doesn't support null safety.
 - Added [freezed](https://pub.dev/packages/freezed) package to generate toString/toJson/fromJson.

## Code Metrics
### Code
__Directory: fluwix/number_trivia/lib__

#### Directories
| path | files | code | comment | blank | total |
| :--- | ---: | ---: | ---: | ---: | ---: |
| . | 24 | 617 | 36 | 141 | 794 |
| common | 5 | 56 | 5 | 19 | 80 |
| common/error | 2 | 14 | 1 | 6 | 21 |
| common/network | 1 | 13 | 0 | 5 | 18 |
| common/presentation | 1 | 17 | 0 | 4 | 21 |
| common/usecases | 1 | 12 | 4 | 4 | 20 |
| data | 3 | 112 | 11 | 29 | 152 |
| data/datasources | 2 | 59 | 11 | 21 | 91 |
| data/repositories | 1 | 53 | 0 | 8 | 61 |
| domain | 4 | 58 | 0 | 20 | 78 |
| domain/entities | 1 | 12 | 0 | 4 | 16 |
| domain/repositories | 1 | 7 | 0 | 2 | 9 |
| domain/usecases | 2 | 39 | 0 | 14 | 53 |
| presentation | 9 | 296 | 5 | 53 | 354 |
| presentation/bloc | 3 | 104 | 2 | 28 | 134 |
| presentation/pages | 1 | 51 | 2 | 4 | 57 |
| presentation/widgets | 5 | 141 | 1 | 21 | 163 |

### Test
__Directory: fluwix/number_trivia/test__

#### Languages
| language | files | code | comment | blank | total |
| :--- | ---: | ---: | ---: | ---: | ---: |
| Dart | 9 | 603 | 99 | 89 | 791 |
| JSON | 3 | 16 | 0 | 0 | 16 |

#### Directories
| path | files | code | comment | blank | total |
| :--- | ---: | ---: | ---: | ---: | ---: |
| . | 12 | 619 | 99 | 89 | 807 |
| common | 2 | 59 | 12 | 11 | 82 |
| common/network | 1 | 27 | 3 | 6 | 36 |
| common/presentation | 1 | 32 | 9 | 5 | 46 |
| data | 3 | 330 | 66 | 46 | 442 |
| data/datasources | 2 | 149 | 30 | 24 | 203 |
| data/repositories | 1 | 181 | 36 | 22 | 239 |
| domain | 2 | 54 | 11 | 12 | 77 |
| domain/usecases | 2 | 54 | 11 | 12 | 77 |
| fixtures | 4 | 18 | 0 | 3 | 21 |
| presentation | 1 | 158 | 10 | 17 | 185 |
| presentation/bloc | 1 | 158 | 10 | 17 | 185 |

## References
For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

For instructions integrating Flutter modules to your existing applications,
see the [add-to-app documentation](https://flutter.dev/docs/development/add-to-app).
