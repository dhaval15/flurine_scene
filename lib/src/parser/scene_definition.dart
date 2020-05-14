/* Rules
 */

import 'package:petitparser/petitparser.dart';

import 'token.dart';
import 'keywords.dart';

extension P on Iterable<Parser<dynamic>> {
  Parser toParser() {
    var p = iterator.current;
    while (iterator.moveNext()) {
      p = p | iterator.current;
    }
    return p;
  }
}

class SceneGrammarDefinition extends GrammarDefinition with TokenMixin {
  @override
  Parser runtime() => ref(scene);

  Parser scene() =>
      ref(whiteSpace) &
      ref(sceneName) &
      ref(whiteSpace) &
      ref(sceneBody) &
      ref(whiteSpace) ;

  Parser sceneName() => ref(variableName);

  Parser sceneBody() =>
      ref(token, OPEN_BRACES) &
      ref(whiteSpace)&
      ref(sceneParameters).optional() &
      ref(whiteSpace) &
      ref(token, CLOSE_BRACES);

  Parser sceneParameters() =>
      sceneParam().separatedBy(ref(separator), includeSeparators: false);

  Parser separator() =>
      ref(whiteSpace)&
      ref(token, COMMA) &
      ref(whiteSpace);

  Parser sceneParam() =>
      ref(variableName) &
      ref(whiteSpace)&
      ref(token, EQUAL) &
      ref(whiteSpace) &
      ref(paramValue);

  Parser variableName() => pattern('A-Za-z') & pattern('0-9A-Za-z').star();

  Parser paramValue() =>
      ref(scene) |
      ref(stringToken) |
      ref(numberToken) |
      ref(trueToken) |
      ref(falseToken);

  Parser whiteSpace() => ref(blanks).star();

  Parser blanks() => ref(token, WHITE_SPACE) | ref(token, NEW_LINE) & ref(token,TAB_LINE);

  Parser booleanToken() => ref(trueToken) | ref(falseToken);

  Parser trueToken() => ref(token, 'true');

  Parser falseToken() => ref(token, 'false');

  Parser nullToken() => ref(token, 'null');

  Parser lambdaToken() =>
      ref(token, DOLLAR) & characterNormal().star() & ref(token, DOLLAR);

  Parser stringToken() => ref(token, ref(stringPrimitive), 'string');

  Parser numberToken() => ref(token, ref(numberPrimitive), 'number');

  Parser characterPrimitive() =>
      ref(characterNormal) | ref(characterEscape) | ref(characterUnicode);

  Parser characterNormal() => pattern('^"\\');

  Parser characterEscape() => char('\\') & pattern(jsonEscapeChars.keys.join());

  Parser characterUnicode() => string('\\u') & pattern('0-9A-Fa-f').times(4);

  Parser funcName() => characterNormal().times(2);

  Parser numberPrimitive() =>
      char('-').optional() &
      char('0').or(digit().plus()) &
      char('.').seq(digit().plus()).optional() &
      pattern('eE')
          .seq(pattern('-+').optional())
          .seq(digit().plus())
          .optional();

  Parser stringPrimitive() =>
      char('"') & ref(characterPrimitive).star() & char('"');

  Parser parameter() => ref(characterPrimitive).star();
}

const Map<String, String> jsonEscapeChars = {
  '\\': '\\',
  '/': '/',
  '"': '"',
  'b': '\b',
  'f': '\f',
  'n': '\n',
  'r': '\r',
  't': '\t',
};
