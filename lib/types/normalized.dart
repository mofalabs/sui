typedef SuiMoveFunctionArgType = dynamic;

typedef SuiMoveNormalizedModules = Map<String, SuiMoveNormalizedModule>;

class SuiMoveNormalizedModule {
  int fileFormatVersion;
  String address;
  String name;
  List<SuiMoveModuleId> friends;
  Map<String, SuiMoveNormalizedStruct> structs;
  Map<String, SuiMoveNormalizedFunction> exposedFunctions;

  SuiMoveNormalizedModule(this.fileFormatVersion, this.address, this.name,
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
      for (var key in exposedFunctions.keys) {
        var d = exposedFunctions[key];
        exposedFunctionsMap[key] = SuiMoveNormalizedFunction.fromJson(d);
      }
    }

    return SuiMoveNormalizedModule(
      data['fileFormatVersion'],
      data['address'],
      data['name'],
      friendsList,
      structsMap,
      exposedFunctionsMap,
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
    final paramsList = (data['typeParameters'] as List)
        .map((x) => SuiMoveStructTypeParameter.fromJson(x))
        .toList();
    final fieldsList = (data['fields'] as List)
        .map((x) => SuiMoveNormalizedField.fromJson(x))
        .toList();
    return SuiMoveNormalizedStruct(
        SuiMoveAbilitySet.fromJson(data['abilities']), paramsList, fieldsList);
  }
}

class SuiMoveStructTypeParameter {
  SuiMoveAbilitySet constraints;
  bool? isPhantom;

  SuiMoveStructTypeParameter(this.constraints, this.isPhantom);

  factory SuiMoveStructTypeParameter.fromJson(dynamic data) {
    return SuiMoveStructTypeParameter(
      SuiMoveAbilitySet.fromJson(data['constraints']),
      data['is_phantom'],
    );
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
  bool? isEntry;
  List<SuiMoveAbilitySet> typeParameters;
  List<SuiMoveNormalizedType> parameters;
  List<SuiMoveNormalizedType> returns;

  SuiMoveNormalizedFunction(this.visibility, this.isEntry, this.typeParameters,
      this.parameters, this.returns);

  factory SuiMoveNormalizedFunction.fromJson(dynamic data) {
    SuiMoveVisibility visibility;
    if (data['visibility'].toString().toLowerCase() == 'public') {
      visibility = SuiMoveVisibility.Public;
    } else if (data['visibility'].toString().toLowerCase() == 'private') {
      visibility = SuiMoveVisibility.Private;
    } else {
      visibility = SuiMoveVisibility.Friend;
    }

    List<SuiMoveAbilitySet> typeParameters = [];
    for (var type in data['typeParameters']) {
      typeParameters.add(SuiMoveAbilitySet.fromJson(type));
    }

    List<SuiMoveNormalizedType> parameters = [];

    for (var type in data['parameters']) {
      parameters.add(type);
    }

    List<SuiMoveNormalizedType> returns = [];
    for (var type in data['return']) {
      parameters.add(type);
    }

    return SuiMoveNormalizedFunction(
        visibility, data['isEntry'], typeParameters, parameters, returns);
  }
}

enum SuiMoveVisibility { Private, Public, Friend }

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

dynamic extractStructTag(
    SuiMoveNormalizedType normalizedType) {
  if (normalizedType is Map && normalizedType.containsKey('Struct')) {
    return normalizedType['Struct'];
  }

  final ref = extractReference(normalizedType);
  final mutRef = extractMutableReference(normalizedType);

  if (ref != null && ref["Struct"] != null) {
    return ref;
  }

  if (mutRef != null && mutRef["Struct"] != null) {
    return mutRef;
  }

  return null;
}
