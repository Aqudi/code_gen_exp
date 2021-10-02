import 'package:code_gen_exp/generators/tlwr_page_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

Builder pageBuilder(BuilderOptions options) {
  return PartBuilder([TLWRPageGenerator()], '.g.dart');
}
