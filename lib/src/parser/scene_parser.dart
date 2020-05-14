import 'package:flurine_scene/src/scene/scene.dart';
import 'package:petitparser/petitparser.dart';
import 'scene_definition.dart';

class SceneParser extends GrammarParser {
  SceneParser() : super(SceneParserDefinition());
}

class SceneParserDefinition extends SceneGrammarDefinition {

  @override
  Parser scene() => super.scene().map((value) => Scene(value[1],value[3]));

  @override
  Parser sceneBody() => super.sceneBody().map((value) => value[2]);

  @override
  Parser sceneParam() => super.sceneParam().map((value) => [value[0],value[4]]);

  @override
  Parser variableName() => super.variableName().map((value) => [value[0],value[1].join('')].join(''));
}

dynamic toNum(String s) {
  final doubleValue = double.parse(s);
  final intValue = doubleValue.toInt();
  if (intValue - doubleValue == 0) {
    return intValue;
  } else {
    return doubleValue;
  }
}
