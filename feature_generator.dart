// tool/feature_generator.dart
import 'dart:io';

//generate it with the following command
// dart run feature_generator.dart {name of feature}

void main(List<String> args) async {
  if (args.isEmpty) {
    print('❌ Please provide a feature name');
    exit(1);
  }

  final feature = args[0];
  final pascal = _toPascal(feature);
  final camel = _toCamel(feature);

  final base = 'lib/Features/$pascal';
  final files = {
    '$base/data/models/${feature}_model.dart': 'class ${pascal}Model {}\n',
    '$base/data/repos/${feature}_repo.dart':
        'abstract class ${pascal}Repo {}\n',
    '$base/data/repos/${feature}_repo_impl.dart': '''
import '${feature}_repo.dart';

class ${pascal}RepoImpl implements ${pascal}Repo {
  // TODO: Implement methods
}
''',
    '$base/presentation/cubits/${feature}_cubit.dart': '''
import 'package:flutter_bloc/flutter_bloc.dart';

class ${pascal}Cubit extends Cubit<int> {
  ${pascal}Cubit() : super(0);
  // TODO: Add your state and logic
}
''',
    '$base/presentation/views/pages/${feature}_screen.dart': '''
import 'package:flutter/material.dart';

class ${pascal}Screen extends StatelessWidget {
  const ${pascal}Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('$pascal Screen')),
    );
  }
}
''',
  };

  for (var entry in files.entries) {
    final file = File(entry.key);
    await file.create(recursive: true);
    await file.writeAsString(entry.value);
    print('✅ Created: ${entry.key}');
  }

  // Inject route (GoRouter)
  await _injectIntoFile(
      'lib/core/resources/routes_manager.dart', 'GoRoute(', '''
    GoRoute(
      path: '/$feature',
      name: '${pascal}Route',
      builder: (context, state) => const ${pascal}Screen(),
    ),
    ''');

  // Inject into service locator
  await _injectIntoFile(
      'lib/injection/service_locator.dart', 'init() async {', '''
  injector.registerLazySingleton<${pascal}Repo>(() => ${pascal}RepoImpl());
  injector.registerFactory(() => ${pascal}Cubit());
    ''');

  // Inject into MultiBlocProvider
  await _injectIntoFile('lib/main.dart', 'MultiBlocProvider(', '''
        BlocProvider<${pascal}Cubit>(
          create: (_) => injector<${pascal}Cubit>(),
        ),
    ''');

  print('\n🎉 Done generating $feature feature with MVVM + BLoC structure');
}

String _toPascal(String name) => name[0].toUpperCase() + name.substring(1);
String _toCamel(String name) => name[0].toLowerCase() + name.substring(1);

Future<void> _injectIntoFile(String path, String anchor, String content) async {
  final file = File(path);
  if (!await file.exists()) {
    print('⚠️ File not found: $path');
    return;
  }

  var original = await file.readAsString();

  if (!original.contains(content.trim())) {
    final lines = original.split('\n');
    final insertIndex = lines.indexWhere((line) => line.contains(anchor));
    if (insertIndex == -1) {
      print('❌ Could not find anchor "$anchor" in $path');
      return;
    }

    // Insert content directly after the anchor line
    lines.insert(insertIndex + 1, content);
    await file.writeAsString(lines.join('\n'));
    print('✅ Injected into $path');
  } else {
    print('⚠️ Skipped injection into $path (already exists)');
  }
}
