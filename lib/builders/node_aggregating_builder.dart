import 'package:build/build.dart';
import 'package:glob/glob.dart';

class NodeAggregatingBuilder implements Builder {
  @override
  final buildExtensions = const {
    r'$lib$': ['tlwr.dart']
  };

  @override
  Future<void> build(BuildStep buildStep) async {
    final exports = buildStep.findAssets(Glob('**/*.tlwr'));
    final content = [
      await for (var exportLibrary in exports)
        'export \'${exportLibrary.changeExtension('.dart').uri}\' '
            'show ${await buildStep.readAsString(exportLibrary)};',
    ];
    if (content.isNotEmpty) {
      buildStep.writeAsString(
          AssetId(buildStep.inputId.package, 'lib/tlwr.dart'),
          content.join('\n'));
    }
  }
}
