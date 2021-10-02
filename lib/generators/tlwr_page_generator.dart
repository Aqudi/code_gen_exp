import 'package:analyzer/dart/element/element.dart';
import 'package:code_gen_exp/annotations/tlwr_page.dart';
import 'package:code_gen_exp/visitors/page_visitor.dart';
import 'package:source_gen/source_gen.dart';
import 'package:build/build.dart';

class TLWRPageGenerator extends GeneratorForAnnotation<TLWRPage> {
  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    String className = element.displayName;
    String path = buildStep.inputId.path;
    // final optionOfLabel = optionOf(annotation.peek('label'));
    // return optionOfLabel.fold(() => "//$className\n//$path\n//",
    //     (label) => "//$className\n//$path\n//${label.stringValue}");

    print("tlwr page generator updated");
    print("//$className//$path//");

    final visitor = PageVisitor();
    element.visitChildren(visitor);

    final classBuffer = StringBuffer();

    // 5
    final newClassName = "${className}Addon";
    classBuffer.writeln('class $newClassName {');

    // routeName을 className을 기준으로 생성합니다.
    classBuffer.writeln('String get routeName => \'/$className\';');

    // classBuffer.writeln('Map<String, dynamic> variables = {};');

    // classBuffer.writeln('$className() {');

    // for (final field in visitor.fields.keys) {
    //   // remove '_' from private variables
    //   final variable =
    //       field.startsWith('_') ? field.replaceFirst('_', '') : field;

    //   classBuffer.writeln("variables['${variable}'] = super.$field;");
    // }

    // classBuffer.writeln('}');
    // generateGettersAndSetters(visitor, classBuffer);
    classBuffer.writeln('}');
    return classBuffer.toString();
  }

  void generateGettersAndSetters(
      PageVisitor visitor, StringBuffer classBuffer) {
    for (final field in visitor.fields.keys) {
      final variable =
          field.startsWith('_') ? field.replaceFirst('_', '') : field;
      classBuffer.writeln(
          "${visitor.fields[field]} get $variable => variables['$variable'];");
      classBuffer
          .writeln('set $variable(${visitor.fields[field]} $variable) {');
      classBuffer.writeln('super.$field = $variable;');
      classBuffer.writeln("variables['$variable'] = $variable;");
      classBuffer.writeln('}');
    }
  }
}
