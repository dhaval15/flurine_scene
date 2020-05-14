## Usage

A simple usage example:

```dart

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
```dart
class TimeHandler extends Handler {

  @override
  Future compute() async {
    return DateTime.now().second;
  }

  @override
  Duration get repeatingDuration => Duration(seconds:params.last);
}

class CounterHandler extends Handler {

  @override
  Duration get repeatingDuration => null;

  int begin, end, step,current;

  @override
  set params(List params) {
    this.params = params;
    begin = params[0];
    end = params[1];
    step = params[2];
    current = params[3];
  }

  @override
  Future compute() async {
    if (current == null || current > end) current = begin;
    int temp = current;
    current = current + step;
    return temp;
  }
}

class ConcatHandler extends Handler{

  @override
  Duration get repeatingDuration => null;

  @override
  Future compute() async{
    return params.join();
  }

}

```
