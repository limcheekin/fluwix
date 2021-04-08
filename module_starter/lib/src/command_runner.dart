import 'dart:io';

import 'logger.dart';
import 'string.dart';

class CommandRunner {
  /// Method called on module creation
  void create(List<String> args) async {
    String module_name;

    if (args.isEmpty) {
      Logger.logError(
          'Module name not found, please specify module name in format "module_name".');
      return;
    } else {
      module_name = args[0];
    }

    final current = Directory.current;
    final workingDirectoryPath = current.path;
    final moduleDirectory = '$workingDirectoryPath/$module_name';

    try {
      Logger.logInfo(
          'Creating flutter module "$module_name" using your current flutter version...');

      final result = Process.runSync(
        'flutter',
        [
          'create',
          '-t',
          'module',
          module_name,
        ],
        workingDirectory: workingDirectoryPath,
        runInShell: true,
      );

      if (result.exitCode != 0) {
        Logger.logError(
            'Exit Code: ${result.exitCode}\nError: ${result.stderr}');
      }

      final templateDirectory = '$workingDirectoryPath/module_starter/template';

      await _copyPasteFileContent(
        '$templateDirectory/pubspec.yaml',
        '$moduleDirectory/pubspec.yaml',
      );

      await _copyPasteFileContent(
        '$templateDirectory/analysis_options.yaml',
        '$moduleDirectory/analysis_options.yaml',
      );

      await _copyPasteFileContent(
        '$templateDirectory/main.dart',
        '$moduleDirectory/lib/main.dart',
      );

      await _copyPasteFileContent(
        '$templateDirectory/module_name_screen.dart',
        '$moduleDirectory/lib/${module_name}_screen.dart',
      );

      final ModuleName = module_name.toPascalCase();
      final Module_Name = module_name.toPascalCase(joinDelimiter: ' ');
      final moduleName =
          ModuleName.substring(0, 1).toLowerCase() + ModuleName.substring(1);

      Logger.logInfo('Update $module_name/pubspec.yaml');
      await _changeAllInFile(
        '$moduleDirectory/pubspec.yaml',
        'module_name',
        module_name,
      );
      await _changeAllInFile(
        '$moduleDirectory/pubspec.yaml',
        'Module Name',
        Module_Name,
      );
      await _changeAllInFile(
        '$moduleDirectory/pubspec.yaml',
        'moduleName',
        moduleName,
      );

      Logger.logInfo('Update $module_name/lib/main.dart');
      await _changeAllInFile(
        '$moduleDirectory/lib/main.dart',
        'module_name',
        module_name,
      );
      await _changeAllInFile(
        '$moduleDirectory/lib/main.dart',
        'Module Name',
        Module_Name,
      );
      await _changeAllInFile(
        '$moduleDirectory/lib/main.dart',
        'ModuleName',
        ModuleName,
      );

      Logger.logInfo('Update $module_name/lib/${module_name}_screen.dart');
      await _changeAllInFile(
        '$moduleDirectory/lib/${module_name}_screen.dart',
        'module_name',
        module_name,
      );
      await _changeAllInFile(
        '$moduleDirectory/lib/${module_name}_screen.dart',
        'Module Name',
        Module_Name,
      );
      await _changeAllInFile(
        '$moduleDirectory/lib/${module_name}_screen.dart',
        'ModuleName',
        ModuleName,
      );

      Process.runSync(
        'flutter',
        [
          'pub',
          'get',
        ],
        workingDirectory: moduleDirectory,
      );

      Logger.logInfo('You are good to go ! :)', lineBreak: true);
    } catch (error) {
      Logger.logError('Error creating module : $error');

      Process.runSync(
        'rm',
        [
          '-rf',
          moduleDirectory,
        ],
      );
    }
  }

  /// Copy all the content of [sourceFilePath] and paste it in [targetFilePath]
  Future<void> _copyPasteFileContent(
      String sourceFilePath, String targetFilePath) async {
    try {
      final sourceFile = File(sourceFilePath);
      final targetFile = File(targetFilePath);

      final sourceContent = sourceFile.readAsStringSync();
      targetFile.writeAsStringSync(sourceContent);
    } catch (error) {
      Logger.logError('Error copying file contents : $error');
    }
  }

  /// Update recursively all imports in [filePath] from [oldValue] to [newValue]
  Future<void> _changeAllInFile(
      String filePath, String oldValue, String newValue) async {
    try {
      final file = File(filePath);
      final content = file.readAsStringSync();
      if (content.contains(oldValue)) {
        final newContent = content.replaceAll(oldValue, newValue);
        file.writeAsStringSync(newContent);
      }
    } catch (error) {
      Logger.logError('Error updating file $filePath : $error');
    }
  }
}
