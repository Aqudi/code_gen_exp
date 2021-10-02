import 'package:code_gen_exp/builders/locating_builder.dart';
import 'package:code_gen_exp/builders/node_aggregating_builder.dart';
import 'package:code_gen_exp/generators/tlwr_page_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder pageBuilder(BuilderOptions options) {
  return PartBuilder([TLWRPageGenerator()], '.tlwr.dart');
}

Builder locatingBuilder(BuilderOptions options) => LocatingBuilder();

Builder nodeAggregatingBuilder(BuilderOptions options) =>
    NodeAggregatingBuilder();
