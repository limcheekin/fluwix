import 'package:flutter/material.dart';
import 'package:showcase_view/showcase_view.dart';
import 'package:source_code_view/source_code_view.dart';

import 'presentation/pages/number_trivia_view.dart';

class NumberTriviaScreen extends StatelessWidget {
  const NumberTriviaScreen({Key? key}) : super(key: key);

  static const owner = 'limcheekin';
  static const repository = 'fluwix';
  static const branch = 'number_trivia_flutter_clean_architecture';
  static const srcDir = 'number_trivia/lib';
  static const testDir = 'number_trivia/test';

  @override
  Widget build(BuildContext context) {
    return ShowcaseView(
      title: 'Number Trivia',
      widget: NumberTriviaView(),
      owner: owner,
      repository: repository,
      ref: branch,
      readMe: 'number_trivia/README.md',
      codePaths: [
        'number_trivia/pubspec.yaml',
        '$srcDir/dependencies.dart',
        '$srcDir/number_trivia_screen.dart',
        '$srcDir/presentation/pages/number_trivia_view.dart',
        '$srcDir/presentation/pages/number_trivia_controller.dart',
        '$srcDir/presentation/pages/number_trivia_presenter.dart',
        '$srcDir/presentation/widgets/loading_widget.dart',
        '$srcDir/presentation/widgets/message_display.dart',
        '$srcDir/presentation/widgets/trivia_controls.dart',
        '$srcDir/presentation/widgets/trivia_display.dart',
        '$srcDir/domain/entities/number_trivia.dart',
        '$srcDir/domain/repositories/number_trivia_repository.dart',
        '$srcDir/domain/usecases/get_concrete_number_trivia.dart',
        '$srcDir/domain/usecases/get_random_number_trivia.dart',
        '$srcDir/data/datasources/number_trivia_local_data_source.dart',
        '$srcDir/data/datasources/number_trivia_remote_data_source.dart',
        '$srcDir/data/repositories/number_trivia_repository_impl.dart',
        '$srcDir/common/network/network_info.dart',
        '$srcDir/common/presentation/input_converter.dart',
      ],
      additionalTabs: [
        Tab(text: 'Test'),
      ],
      additionalTabBarViews: [
        SingleChildScrollView(
          child: SourceCodeView(
            owner: owner,
            repository: repository,
            ref: branch,
            paths: [
              '$testDir/fixtures/fixture_reader.dart',
              '$testDir/domain/usecases/get_concrete_number_trivia_test.dart',
              '$testDir/domain/usecases/get_random_number_trivia_test.dart',
              '$testDir/data/repositories/number_trivia_repository_impl_test.dart',
              '$testDir/data/datasources/number_trivia_local_data_source_test.dart',
              '$testDir/data/datasources/number_trivia_remote_data_source_test.dart',
              '$testDir/common/network/network_info_test.dart',
              '$testDir/common/presentation/input_converter_test.dart',
            ],
          ),
        ),
      ],
    );
  }
}
