import 'package:flurine_scene/flurine_scene.dart';

const SAMPLE = '''
Container {
	height = 28,
	width = 28,
	child = Text {
		text = "Hello"
	}
}
''';

void main() {
  final output = SceneParser().parse(SAMPLE).value;
  print(output);
}
