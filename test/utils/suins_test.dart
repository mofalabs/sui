
import 'package:flutter_test/flutter_test.dart';
import 'package:sui/utils/suins.dart';

void main() {

  group('isValidSuiNSName', () {
    test('valid SuiNS names', () {
      expect(isValidSuiNSName('example.sui'),true);
      expect(isValidSuiNSName('EXAMPLE.sui'),true);
      expect(isValidSuiNSName('@example'),true);
      expect(isValidSuiNSName('1.example.sui'),true);
      expect(isValidSuiNSName('1@example'),true);
      expect(isValidSuiNSName('a.b.c.example.sui'),true);
      expect(isValidSuiNSName('A.B.c.123@Example'),true);
      expect(isValidSuiNSName('1-a@1-b'),true);
      expect(isValidSuiNSName('1-a.1-b.sui'),true);
      expect(isValidSuiNSName('-@test'),false);
      expect(isValidSuiNSName('-1@test'),false);
      expect(isValidSuiNSName('test@-'),false);
      expect(isValidSuiNSName('test@-1'),false);
      expect(isValidSuiNSName('test@-a'),false);
      expect(isValidSuiNSName('test.sui2'),false);
      expect(isValidSuiNSName('.sui2'),false);
      expect(isValidSuiNSName('test@'),false);
      expect(isValidSuiNSName('@@'),false);
      expect(isValidSuiNSName('@@test'),false);
      expect(isValidSuiNSName('test@test.test'),false);
      expect(isValidSuiNSName('@test.test'),false);
      expect(isValidSuiNSName('#@test'),false);
      expect(isValidSuiNSName('test@#'),false);
      expect(isValidSuiNSName('test.#.sui'),false);
      expect(isValidSuiNSName('#.sui'),false);
      expect(isValidSuiNSName('@.test.sue'),false);

      expect(isValidSuiNSName(''), false);
      expect(isValidSuiNSName(' '), false);
      expect(isValidSuiNSName('-.sui'), false);
      expect(isValidSuiNSName('--.sui'), false);
      expect(isValidSuiNSName('-hello.sui'), false);
      expect(isValidSuiNSName('hello-.sui'), false);
      expect(isValidSuiNSName('-hello-.sui'), false);
      expect(isValidSuiNSName('hello--world.sui'), false);
      expect(isValidSuiNSName(String.fromCharCodes(List<int>.filled(64, 48)) + ".sui"), false);
      expect(isValidSuiNSName('hello.sui'), true);
      expect(isValidSuiNSName('hello-world.sui'), true);
      expect(isValidSuiNSName(String.fromCharCodes(List<int>.filled(1, 48)) + ".sui"), true);
      expect(isValidSuiNSName(String.fromCharCodes(List<int>.filled(2, 48)) + ".sui"), true);
      expect(isValidSuiNSName(String.fromCharCodes(List<int>.filled(3, 48)) + ".sui"), true);
      expect(isValidSuiNSName(String.fromCharCodes(List<int>.filled(63, 48)) + ".sui"), true);

      expect(isValidSuiNSName('example.sui'), true);
      expect(isValidSuiNSName('test.example.sui'), true);
      expect(isValidSuiNSName('valid-domain.sui'), true);
      expect(isValidSuiNSName('another.valid-domain.sui'), true);
      expect(isValidSuiNSName('hello.sui'), true);
      expect(isValidSuiNSName('1.example.sui'), true);
      expect(isValidSuiNSName('a.sui'), true);
      expect(isValidSuiNSName('he-llo.sui'), true);
      expect(isValidSuiNSName('helloworld.sui'), true);
      expect(isValidSuiNSName('hel-lo.wor-ld.sui'), true);

      expect(isValidSuiNSName('invalid_domain.sui'), false);
      expect(isValidSuiNSName('invalid-.sui'), false);
      expect(isValidSuiNSName('hello-.sui'), false);
      expect(isValidSuiNSName('toolongpartofthedomainnamethatshouldnotmatchthisexpressionbecauseitislongerthansixtytwocharacters.sui'), false);
      expect(isValidSuiNSName('1-.sui'), false);
      expect(isValidSuiNSName('hello--world.sui'), false);
      expect(isValidSuiNSName('-hello.sui'), false);
      expect(isValidSuiNSName('hello-.sui'), false);
      expect(isValidSuiNSName('hello..sui'), false);
      expect(isValidSuiNSName('hel..lo.sui'), false);
      expect(isValidSuiNSName('hello world.sui'), false);
      expect(isValidSuiNSName('hello@world.sui'), false);
      expect(isValidSuiNSName('hello#world.sui'), false);
      expect(isValidSuiNSName('sui'), false);
      expect(isValidSuiNSName('hello-.world.sui'), false);
      expect(isValidSuiNSName('hello.-world.sui'), false);
      expect(isValidSuiNSName('hello.world.sui-'), false);


      expect(isValidSuiNSName('example@sui'), true);
      expect(isValidSuiNSName('test.example@sui'), true);
      expect(isValidSuiNSName('valid-domain@sui'), true);
      expect(isValidSuiNSName('another.valid-domain@sui'), true);
      expect(isValidSuiNSName('hello@sui'), true);
      expect(isValidSuiNSName('1.example@sui'), true);
      expect(isValidSuiNSName('a@sui'), true);
      expect(isValidSuiNSName('he-llo@sui'), true);
      expect(isValidSuiNSName('helloworld@sui'), true);
      expect(isValidSuiNSName('hel-lo.wor-ld@sui'), true);

      expect(isValidSuiNSName('invalid_domain@sui'), false);
      expect(isValidSuiNSName('invalid-@sui'), false);
      expect(isValidSuiNSName('hello-@sui'), false);
      expect(isValidSuiNSName('toolongpartofthedomainnamethatshouldnotmatchthisexpressionbecauseitislongerthansixtytwocharacters@sui'), false);
      expect(isValidSuiNSName('1-@sui'), false);
      expect(isValidSuiNSName('hello--world@sui'), false);
      expect(isValidSuiNSName('-hello@sui'), false);
      expect(isValidSuiNSName('hello-@sui'), false);
      expect(isValidSuiNSName('hello.@sui'), false);
      expect(isValidSuiNSName('hel..lo@sui'), false);
      expect(isValidSuiNSName('hello world@sui'), false);
      expect(isValidSuiNSName('hello@world@sui'), false);
      expect(isValidSuiNSName('hello#world@sui'), false);
      expect(isValidSuiNSName('sui'), false);
      expect(isValidSuiNSName('hello-.world@sui'), false);
      expect(isValidSuiNSName('hello.-world@sui'), false);
      expect(isValidSuiNSName('hello.world@sui-'), false);
    });
  });

  group('normalizeSuiNSName', () {

    Matcher throwError(String message) {
      return throwsA((predicate((e) => e is ArgumentError && e.message == message)));
    }

    test('normalize SuiNS names', ()  {
      expect(normalizeSuiNSName('example.sui'),'@example');
      expect(normalizeSuiNSName('EXAMPLE.sui'),'@example');
      expect(normalizeSuiNSName('@example'),'@example');
      expect(normalizeSuiNSName('1.example.sui'),'1@example');
      expect(normalizeSuiNSName('1@example'),'1@example');
      expect(normalizeSuiNSName('a.b.c.example.sui'),'a.b.c@example');
      expect(normalizeSuiNSName('A.B.c.123@Example'),'a.b.c.123@example');
      expect(normalizeSuiNSName('1-a@1-b'),'1-a@1-b');
      expect(normalizeSuiNSName('1-a.1-b.sui'),'1-a@1-b');

      expect(normalizeSuiNSName('example.sui', SuiNSType.dot),'example.sui');
      expect(normalizeSuiNSName('EXAMPLE.sui', SuiNSType.dot),'example.sui');
      expect(normalizeSuiNSName('@example', SuiNSType.dot),'example.sui');
      expect(normalizeSuiNSName('1.example.sui', SuiNSType.dot),'1.example.sui');
      expect(normalizeSuiNSName('1@example', SuiNSType.dot),'1.example.sui');
      expect(normalizeSuiNSName('a.b.c.example.sui', SuiNSType.dot),'a.b.c.example.sui');
      expect(normalizeSuiNSName('A.B.c.123@Example', SuiNSType.dot),'a.b.c.123.example.sui');
      expect(normalizeSuiNSName('1-a@1-b', SuiNSType.dot),'1-a.1-b.sui');
      expect(normalizeSuiNSName('1-a.1-b.sui', SuiNSType.dot),'1-a.1-b.sui');

      expect(() => normalizeSuiNSName('-@test'), throwError('Invalid SuiNS name -@test'));
      expect(() => normalizeSuiNSName('-1@test'), throwError('Invalid SuiNS name -1@test'));
      expect(() => normalizeSuiNSName('test@-'), throwError('Invalid SuiNS name test@-'));
      expect(() => normalizeSuiNSName('test@-1'), throwError('Invalid SuiNS name test@-1'));
      expect(() => normalizeSuiNSName('test@-a'), throwError('Invalid SuiNS name test@-a'));
      expect(() => normalizeSuiNSName('test.sui2'), throwError('Invalid SuiNS name test.sui2'));
      expect(() => normalizeSuiNSName('.sui2'), throwError('Invalid SuiNS name .sui2'));
      expect(() => normalizeSuiNSName('test@'), throwError('Invalid SuiNS name test@'));
      expect(() => normalizeSuiNSName('@@'), throwError('Invalid SuiNS name @@'));
      expect(() => normalizeSuiNSName('@@test'), throwError('Invalid SuiNS name @@test'));
      expect(() => normalizeSuiNSName('test@test.test'), throwError(
        'Invalid SuiNS name test@test.test',
      ));
      expect(() => normalizeSuiNSName('@test.test'), throwError('Invalid SuiNS name @test.test'));
      expect(() => normalizeSuiNSName('#@test'), throwError('Invalid SuiNS name #@test'));
      expect(() => normalizeSuiNSName('test@#'), throwError('Invalid SuiNS name test@#'));
      expect(() => normalizeSuiNSName('test.#.sui'), throwError('Invalid SuiNS name test.#.sui'));
      expect(() => normalizeSuiNSName('#.sui'), throwError('Invalid SuiNS name #.sui'));
      expect(() => normalizeSuiNSName('@.test.sue'), throwError('Invalid SuiNS name @.test.sue'));
      
    });
  });

}
