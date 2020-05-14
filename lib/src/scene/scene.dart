import 'package:flurine_scene/src/parser/scene_parser.dart';

class Scene {
  final String name;
  final List params;

  Scene(this.name, this.params);

  factory Scene.parse(String text) => SceneParser().parse(text.trim()).value;

  @override
  String toString() => {
        'name': name,
        'params': params,
      }.toString();
}
