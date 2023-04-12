typedef SuiMoveFunctionArgTypesResponse = List<SuiMoveFunctionArgType>;
/// String or SuiMoveFunctionArgTypeObject
typedef SuiMoveFunctionArgType = dynamic;

typedef SuiMoveFunctionArgTypes = List<SuiMoveFunctionArgType>;

typedef SuiMoveNormalizedModules = Map<String, SuiMoveNormalizedModule>;

class SuiMoveFunctionArgTypeObject {
  String object;

  SuiMoveFunctionArgTypeObject(this.object);

  factory SuiMoveFunctionArgTypeObject.fromJson(dynamic data) {
    return SuiMoveFunctionArgTypeObject(data['Object']);
  }
}

class SuiMoveNormalizedModule {
  int file_format_version;
  String address;
  String name;
  List<SuiMoveModuleId> friends;
  Map<String, SuiMoveNormalizedStruct> structs;
  Map<String, SuiMoveNormalizedFunction> exposedFunctions;

  SuiMoveNormalizedModule(this.file_format_version, this.address, this.name,
      this.friends, this.structs, this.exposedFunctions);

  factory SuiMoveNormalizedModule.fromJson(dynamic data) {
    final friends = data['friends'];
    List<SuiMoveModuleId> friendsList = [];
    if (friends != null) {
      for (var friend in friends) {
        friendsList.add(SuiMoveModuleId.fromJson(friend));
      }
    }

    final structs = data['structs'];
    final structsMap = <String, SuiMoveNormalizedStruct>{};
    if (structs != null && structs is Map) {
      for (var key in structs.keys) {
        structsMap[key] = SuiMoveNormalizedStruct.fromJson(structs[key]);
      }
    }

    final exposedFunctions = data['exposedFunctions'];
    final exposedFunctionsMap = <String, SuiMoveNormalizedFunction>{};
    if (exposedFunctions != null && exposedFunctions is Map) {
      for (var key in structs.keys) {
        exposedFunctionsMap[key] =
            SuiMoveNormalizedFunction.fromJson(structs[key]);
      }
    }

    return SuiMoveNormalizedModule(
      data['file_format_version'],
      data['address'],
      data['name'],
      friendsList,
      structsMap,
      exposedFunctions,
    );
  }
}

class SuiMoveModuleId {
  String address;
  String name;

  SuiMoveModuleId(this.address, this.name);

  factory SuiMoveModuleId.fromJson(dynamic data) {
    return SuiMoveModuleId(
      data['address'],
      data['name'],
    );
  }
}


class SuiMoveNormalizedStruct {
  SuiMoveAbilitySet abilities;
  List<SuiMoveStructTypeParameter> typeParameters;
  List<SuiMoveNormalizedField> fields;

  SuiMoveNormalizedStruct(this.abilities, this.typeParameters, this.fields);

  factory SuiMoveNormalizedStruct.fromJson(dynamic data) {
    final paramsList = (data['type_parameters'] as List).map((x) =>
        SuiMoveStructTypeParameter.fromJson(x)).toList();
    final fieldsList = (data['fields'] as List).map((x) =>
        SuiMoveNormalizedField.fromJson(x)).toList();
    return SuiMoveNormalizedStruct(
        SuiMoveAbilitySet.fromJson(data['abilities']),
        paramsList,
        fieldsList
    );
  }
}

class SuiMoveStructTypeParameter {
  SuiMoveAbilitySet constraints;
  bool isPhantom;

  SuiMoveStructTypeParameter(this.constraints, this.isPhantom);

  factory SuiMoveStructTypeParameter.fromJson(dynamic data) {
    return SuiMoveStructTypeParameter(data['constraints'], data['is_phantom']);
  }
}

class SuiMoveNormalizedField {
  String name;
  SuiMoveNormalizedType type;

  SuiMoveNormalizedField(this.name, this.type);

  factory SuiMoveNormalizedField.fromJson(dynamic data) {
    return SuiMoveNormalizedField(data['name'], data['type_']);
  }
}

class SuiMoveNormalizedFunction {
  SuiMoveVisibility visibility;
  bool isEntry;
  List<SuiMoveAbilitySet> typeParameters;
  List<SuiMoveNormalizedType> parameters;
  List<SuiMoveNormalizedType> returns;

  SuiMoveNormalizedFunction(this.visibility,
      this.isEntry,
      this.typeParameters,
      this.parameters,
      this.returns);

  factory SuiMoveNormalizedFunction.fromJson(dynamic data) {
    return SuiMoveNormalizedFunction(
        data['visibility'],
        data['is_entry'],
        data['type_parameters'],
        data['parameters'],
        data['return_']
    );
  }
}

enum SuiMoveVisibility {
  Private,
  Public,
  Friend
}

typedef SuiMoveTypeParameterIndex = int;

class SuiMoveAbilitySet {
  List<String> abilities;

  SuiMoveAbilitySet(this.abilities);

  factory SuiMoveAbilitySet.fromJson(dynamic data) {
    return SuiMoveAbilitySet((data['abilities'] as List).cast<String>());
  }
}

typedef SuiMoveNormalizedType = dynamic;



// export type SuiMoveNormalizedType =
//   | string
//   | SuiMoveNormalizedTypeParameterType
//   | { Reference: SuiMoveNormalizedType }
//   | { MutableReference: SuiMoveNormalizedType }
//   | { Vector: SuiMoveNormalizedType }
//   | SuiMoveNormalizedStructType;

class SuiMoveNormalizedTypeParameterType {
  SuiMoveTypeParameterIndex TypeParameter;

  SuiMoveNormalizedTypeParameterType(this.TypeParameter);
}

class SuiStruct {
  String address;
  String module;
  String name;
  List<SuiMoveNormalizedType> type_arguments;

  SuiStruct(this.address, this.module, this.name, this.type_arguments);
}

class SuiMoveNormalizedStructType {
  SuiStruct Struct;

  SuiMoveNormalizedStructType(this.Struct);
}


SuiMoveNormalizedType? extractMutableReference(
    SuiMoveNormalizedType normalizedType) {
  if (normalizedType is Map && normalizedType.containsKey('MutableReference')) {
    return normalizedType['MutableReference'];
  }
  return null;
}

SuiMoveNormalizedType? extractReference(SuiMoveNormalizedType normalizedType) {
  if (normalizedType is Map && normalizedType.containsKey('Reference')) {
    return normalizedType['Reference'];
  }
  return null;
}

SuiMoveNormalizedStructType? extractStructTag(
    SuiMoveNormalizedType normalizedType) {
  if (normalizedType is Map && normalizedType.containsKey('Struct')) {
    return normalizedType['Struct'];
  }

  final ref = extractReference(normalizedType);
  final mutRef = extractMutableReference(normalizedType);

  if (ref is SuiMoveNormalizedStructType) {
    return ref;
  }

  if (mutRef is SuiMoveNormalizedStructType) {
    return mutRef;
  }

  return null;
}
