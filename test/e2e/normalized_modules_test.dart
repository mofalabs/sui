import 'package:flutter_test/flutter_test.dart';
import 'package:sui/sui_urls.dart';
import 'package:sui/sui_client.dart';

void main() {
  const defaultPackage = '0x2';
  const defaultModule = 'coin';
  const defaultFunction = 'balance';
  const defaultStruct = 'Coin';

  test('test getMoveFunctionArgTypes', () async {
    final client = SuiClient(SuiUrls.devnet);
    final functionArgTypes = await client.getMoveFunctionArgTypes(
      packageId: defaultPackage,
      moduleName: defaultModule,
      functionName: defaultFunction,
    );
    expect(functionArgTypes[0]['Object'] == 'ByImmutableReference', true);
  });

  test('test getNormalizedMoveModulesByPackage', () async {
    final client = SuiClient(SuiUrls.devnet);
    final moveModules =
        await client.getNormalizedMoveModulesByPackage(defaultPackage);
    expect(moveModules.keys.contains(defaultModule), true);
    expect(moveModules.keys.isNotEmpty, true);
  });

  test('test getNormalizedMoveModule', () async {
    final client = SuiClient(SuiUrls.devnet);
    final moveModule =
        await client.getNormalizedMoveModule(defaultPackage, defaultModule);
    expect(moveModule.exposedFunctions.containsKey(defaultFunction), true);
  });

  test('test getNormalizedMoveFunction', () async {
    final client = SuiClient(SuiUrls.devnet);
    final moveFunction = await client.getNormalizedMoveFunction(
      defaultPackage,
      defaultModule,
      defaultFunction,
    );
    expect(moveFunction.isEntry == false, true);
  });

  test('test getNormalizedMoveStruct', () async {
    final client = SuiClient(SuiUrls.devnet);
    final moveStruct = await client.getNormalizedMoveStruct(
      defaultPackage,
      defaultModule,
      defaultStruct,
    );
    expect(moveStruct.fields.length > 1, true);
  });
}
