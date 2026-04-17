// @dart=3.8

part of '_json_serializable_test_input.dart';

@ShouldGenerate(r'''
SuperSimpleSealedClass _$SuperSimpleSealedClassFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'SubOneSimpleSealedClass' => _$SubOneSimpleSealedClassFromJson(json),
  'SubTwoSimpleSealedClass' => _$SubTwoSimpleSealedClassFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperSimpleSealedClass,
    json,
  ),
};

Map<String, dynamic> _$SuperSimpleSealedClassToJson(
  SuperSimpleSealedClass instance,
) => switch (instance) {
  final SubOneSimpleSealedClass instance => {
    'type': 'SubOneSimpleSealedClass',
    ..._$SubOneSimpleSealedClassToJson(instance),
  },
  final SubTwoSimpleSealedClass instance => {
    'type': 'SubTwoSimpleSealedClass',
    ..._$SubTwoSimpleSealedClassToJson(instance),
  },
};
''')
@JsonSerializable()
sealed class SuperSimpleSealedClass {
  const SuperSimpleSealedClass();
}

@ShouldGenerate(r'''
SubOneSimpleSealedClass _$SubOneSimpleSealedClassFromJson(
  Map<String, dynamic> json,
) => SubOneSimpleSealedClass(someField: json['someField'] as String);

Map<String, dynamic> _$SubOneSimpleSealedClassToJson(
  SubOneSimpleSealedClass instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubOneSimpleSealedClass extends SuperSimpleSealedClass {
  final String someField;

  SubOneSimpleSealedClass({required this.someField});
}

@ShouldGenerate(r'''
SubTwoSimpleSealedClass _$SubTwoSimpleSealedClassFromJson(
  Map<String, dynamic> json,
) => SubTwoSimpleSealedClass(someField: json['someField'] as String);

Map<String, dynamic> _$SubTwoSimpleSealedClassToJson(
  SubTwoSimpleSealedClass instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubTwoSimpleSealedClass extends SuperSimpleSealedClass {
  final String someField;

  SubTwoSimpleSealedClass({required this.someField});
}

@ShouldGenerate(r'''
SuperSimpleSealedClassWithChangedDiscriminator
_$SuperSimpleSealedClassWithChangedDiscriminatorFromJson(
  Map<String, dynamic> json,
) => switch (json['new_discriminator']) {
  'SubOneSimpleSealedClassWithChangedDiscriminator' =>
    _$SubOneSimpleSealedClassWithChangedDiscriminatorFromJson(json),
  'SubTwoSimpleSealedClassWithChangedDiscriminator' =>
    _$SubTwoSimpleSealedClassWithChangedDiscriminatorFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['new_discriminator']}',
    SuperSimpleSealedClassWithChangedDiscriminator,
    json,
  ),
};

Map<String, dynamic> _$SuperSimpleSealedClassWithChangedDiscriminatorToJson(
  SuperSimpleSealedClassWithChangedDiscriminator instance,
) => switch (instance) {
  final SubOneSimpleSealedClassWithChangedDiscriminator instance => {
    'new_discriminator': 'SubOneSimpleSealedClassWithChangedDiscriminator',
    ..._$SubOneSimpleSealedClassWithChangedDiscriminatorToJson(instance),
  },
  final SubTwoSimpleSealedClassWithChangedDiscriminator instance => {
    'new_discriminator': 'SubTwoSimpleSealedClassWithChangedDiscriminator',
    ..._$SubTwoSimpleSealedClassWithChangedDiscriminatorToJson(instance),
  },
};
''')
@JsonSerializable(unionDiscriminator: 'new_discriminator')
sealed class SuperSimpleSealedClassWithChangedDiscriminator {
  const SuperSimpleSealedClassWithChangedDiscriminator();
}

@ShouldGenerate(r'''
SubOneSimpleSealedClassWithChangedDiscriminator
_$SubOneSimpleSealedClassWithChangedDiscriminatorFromJson(
  Map<String, dynamic> json,
) => SubOneSimpleSealedClassWithChangedDiscriminator(
  someField: json['someField'] as String,
);

Map<String, dynamic> _$SubOneSimpleSealedClassWithChangedDiscriminatorToJson(
  SubOneSimpleSealedClassWithChangedDiscriminator instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubOneSimpleSealedClassWithChangedDiscriminator
    extends SuperSimpleSealedClassWithChangedDiscriminator {
  final String someField;

  SubOneSimpleSealedClassWithChangedDiscriminator({required this.someField});
}

@ShouldGenerate(r'''
SubTwoSimpleSealedClassWithChangedDiscriminator
_$SubTwoSimpleSealedClassWithChangedDiscriminatorFromJson(
  Map<String, dynamic> json,
) => SubTwoSimpleSealedClassWithChangedDiscriminator(
  someField: json['someField'] as String,
);

Map<String, dynamic> _$SubTwoSimpleSealedClassWithChangedDiscriminatorToJson(
  SubTwoSimpleSealedClassWithChangedDiscriminator instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubTwoSimpleSealedClassWithChangedDiscriminator
    extends SuperSimpleSealedClassWithChangedDiscriminator {
  final String someField;

  SubTwoSimpleSealedClassWithChangedDiscriminator({required this.someField});
}

@ShouldGenerate(r'''
SuperSimpleSealedClassWithChangedUnionRename
_$SuperSimpleSealedClassWithChangedUnionRenameFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'sub_one_simple_sealed_class_with_changed_union_rename' =>
    _$SubOneSimpleSealedClassWithChangedUnionRenameFromJson(json),
  'sub_two_simple_sealed_class_with_changed_union_rename' =>
    _$SubTwoSimpleSealedClassWithChangedUnionRenameFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperSimpleSealedClassWithChangedUnionRename,
    json,
  ),
};

Map<String, dynamic> _$SuperSimpleSealedClassWithChangedUnionRenameToJson(
  SuperSimpleSealedClassWithChangedUnionRename instance,
) => switch (instance) {
  final SubOneSimpleSealedClassWithChangedUnionRename instance => {
    'type': 'sub_one_simple_sealed_class_with_changed_union_rename',
    ..._$SubOneSimpleSealedClassWithChangedUnionRenameToJson(instance),
  },
  final SubTwoSimpleSealedClassWithChangedUnionRename instance => {
    'type': 'sub_two_simple_sealed_class_with_changed_union_rename',
    ..._$SubTwoSimpleSealedClassWithChangedUnionRenameToJson(instance),
  },
};
''')
@JsonSerializable(unionRename: FieldRename.snake)
sealed class SuperSimpleSealedClassWithChangedUnionRename {
  const SuperSimpleSealedClassWithChangedUnionRename();
}

@ShouldGenerate(r'''
SubOneSimpleSealedClassWithChangedUnionRename
_$SubOneSimpleSealedClassWithChangedUnionRenameFromJson(
  Map<String, dynamic> json,
) => SubOneSimpleSealedClassWithChangedUnionRename(
  someField: json['someField'] as String,
);

Map<String, dynamic> _$SubOneSimpleSealedClassWithChangedUnionRenameToJson(
  SubOneSimpleSealedClassWithChangedUnionRename instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubOneSimpleSealedClassWithChangedUnionRename
    extends SuperSimpleSealedClassWithChangedUnionRename {
  final String someField;

  SubOneSimpleSealedClassWithChangedUnionRename({required this.someField});
}

@ShouldGenerate(r'''
SubTwoSimpleSealedClassWithChangedUnionRename
_$SubTwoSimpleSealedClassWithChangedUnionRenameFromJson(
  Map<String, dynamic> json,
) => SubTwoSimpleSealedClassWithChangedUnionRename(
  someField: json['someField'] as String,
);

Map<String, dynamic> _$SubTwoSimpleSealedClassWithChangedUnionRenameToJson(
  SubTwoSimpleSealedClassWithChangedUnionRename instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubTwoSimpleSealedClassWithChangedUnionRename
    extends SuperSimpleSealedClassWithChangedUnionRename {
  final String someField;

  SubTwoSimpleSealedClassWithChangedUnionRename({required this.someField});
}

@ShouldGenerate(r'''
SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename
_$SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRenameFromJson(
  Map<String, dynamic> json,
) => switch (json['my_discriminator']) {
  'sub-one-simple-sealed-class-with-changed-discriminator-and-union-rename' =>
    _$SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRenameFromJson(
      json,
    ),
  'sub-two-simple-sealed-class-with-changed-discriminator-and-union-rename' =>
    _$SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRenameFromJson(
      json,
    ),
  _ => throw UnrecognizedUnionTypeException(
    '${json['my_discriminator']}',
    SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename,
    json,
  ),
};

Map<String, dynamic>
_$SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRenameToJson(
  SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename instance,
) => switch (instance) {
  final SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRename
  instance =>
    {
      'my_discriminator':
          'sub-one-simple-sealed-class-with-changed-discriminator-and-union-rename',
      ..._$SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRenameToJson(
        instance,
      ),
    },
  final SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRename
  instance =>
    {
      'my_discriminator':
          'sub-two-simple-sealed-class-with-changed-discriminator-and-union-rename',
      ..._$SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRenameToJson(
        instance,
      ),
    },
};
''')
@JsonSerializable(
  unionDiscriminator: 'my_discriminator',
  unionRename: FieldRename.kebab,
)
sealed class SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename {
  const SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename();
}

@ShouldGenerate(r'''
SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRename
_$SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRenameFromJson(
  Map<String, dynamic> json,
) => SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRename(
  someField: json['someField'] as String,
);

Map<String, dynamic>
_$SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRenameToJson(
  SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRename instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRename
    extends SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename {
  final String someField;

  SubOneSimpleSealedClassWithChangedDiscriminatorAndUnionRename({
    required this.someField,
  });
}

@ShouldGenerate(r'''
SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRename
_$SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRenameFromJson(
  Map<String, dynamic> json,
) => SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRename(
  someField: json['someField'] as String,
);

Map<String, dynamic>
_$SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRenameToJson(
  SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRename instance,
) => <String, dynamic>{'someField': instance.someField};
''')
@JsonSerializable()
class SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRename
    extends SuperSimpleSealedClassWithChangedDiscriminatorAndUnionRename {
  final String someField;

  SubTwoSimpleSealedClassWithChangedDiscriminatorAndUnionRename({
    required this.someField,
  });
}

@ShouldGenerate(r'''
SuperSimpleSealedClassWithoutToJson
_$SuperSimpleSealedClassWithoutToJsonFromJson(Map<String, dynamic> json) =>
    switch (json['type']) {
      _ => throw UnrecognizedUnionTypeException(
        '${json['type']}',
        SuperSimpleSealedClassWithoutToJson,
        json,
      ),
    };
''')
@JsonSerializable(createToJson: false)
sealed class SuperSimpleSealedClassWithoutToJson {}

@ShouldGenerate(r'''
SubSimpleSealedClassWithoutToJson _$SubSimpleSealedClassWithoutToJsonFromJson(
  Map<String, dynamic> json,
) => SubSimpleSealedClassWithoutToJson(someField: json['someField'] as String);
''')
@JsonSerializable(createToJson: false)
class SubSimpleSealedClassWithoutToJson {
  final String someField;

  SubSimpleSealedClassWithoutToJson({required this.someField});
}

@ShouldGenerate(r'''
SuperSuperSuperNested _$SuperSuperSuperNestedFromJson(
  Map<String, dynamic> json,
) => switch (json['super_super_super_type']) {
  'SuperSuperNestedOne' => _$SuperSuperNestedOneFromJson(json),
  'SuperSuperNestedTwo' => _$SuperSuperNestedTwoFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['super_super_super_type']}',
    SuperSuperSuperNested,
    json,
  ),
};

Map<String, dynamic> _$SuperSuperSuperNestedToJson(
  SuperSuperSuperNested instance,
) => switch (instance) {
  final SuperSuperNestedOne instance => {
    'super_super_super_type': 'SuperSuperNestedOne',
    ..._$SuperSuperNestedOneToJson(instance),
  },
  final SuperSuperNestedTwo instance => {
    'super_super_super_type': 'SuperSuperNestedTwo',
    ..._$SuperSuperNestedTwoToJson(instance),
  },
};
''')
@JsonSerializable(unionDiscriminator: 'super_super_super_type')
sealed class SuperSuperSuperNested {
  const SuperSuperSuperNested();
}

@ShouldGenerate(r'''
SuperSuperNestedOne _$SuperSuperNestedOneFromJson(Map<String, dynamic> json) =>
    switch (json['super_super_type']) {
      'SuperNestedOneOne' => _$SuperNestedOneOneFromJson(json),
      'SuperNestedOneTwo' => _$SuperNestedOneTwoFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['super_super_type']}',
        SuperSuperNestedOne,
        json,
      ),
    };

Map<String, dynamic> _$SuperSuperNestedOneToJson(
  SuperSuperNestedOne instance,
) => switch (instance) {
  final SuperNestedOneOne instance => {
    'super_super_type': 'SuperNestedOneOne',
    ..._$SuperNestedOneOneToJson(instance),
  },
  final SuperNestedOneTwo instance => {
    'super_super_type': 'SuperNestedOneTwo',
    ..._$SuperNestedOneTwoToJson(instance),
  },
};
''')
@JsonSerializable(unionDiscriminator: 'super_super_type')
sealed class SuperSuperNestedOne extends SuperSuperSuperNested {
  const SuperSuperNestedOne();
}

@ShouldGenerate(r'''
SuperSuperNestedTwo _$SuperSuperNestedTwoFromJson(Map<String, dynamic> json) =>
    switch (json['super_super_type']) {
      'SuperNestedTwoOne' => _$SuperNestedTwoOneFromJson(json),
      'SuperNestedTwoTwo' => _$SuperNestedTwoTwoFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['super_super_type']}',
        SuperSuperNestedTwo,
        json,
      ),
    };

Map<String, dynamic> _$SuperSuperNestedTwoToJson(
  SuperSuperNestedTwo instance,
) => switch (instance) {
  final SuperNestedTwoOne instance => {
    'super_super_type': 'SuperNestedTwoOne',
    ..._$SuperNestedTwoOneToJson(instance),
  },
  final SuperNestedTwoTwo instance => {
    'super_super_type': 'SuperNestedTwoTwo',
    ..._$SuperNestedTwoTwoToJson(instance),
  },
};
''')
@JsonSerializable(unionDiscriminator: 'super_super_type')
sealed class SuperSuperNestedTwo extends SuperSuperSuperNested {
  const SuperSuperNestedTwo();
}

@ShouldGenerate(r'''
SuperNestedOneOne _$SuperNestedOneOneFromJson(Map<String, dynamic> json) =>
    switch (json['super_type']) {
      'SubNestedOneOne' => _$SubNestedOneOneFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['super_type']}',
        SuperNestedOneOne,
        json,
      ),
    };

Map<String, dynamic> _$SuperNestedOneOneToJson(SuperNestedOneOne instance) =>
    switch (instance) {
      final SubNestedOneOne instance => {
        'super_type': 'SubNestedOneOne',
        ..._$SubNestedOneOneToJson(instance),
      },
    };
''')
@JsonSerializable(unionDiscriminator: 'super_type')
sealed class SuperNestedOneOne extends SuperSuperNestedOne {
  const SuperNestedOneOne();
}

@ShouldGenerate(r'''
SuperNestedOneTwo _$SuperNestedOneTwoFromJson(Map<String, dynamic> json) =>
    switch (json['super_type']) {
      'SubNestedOneTwo' => _$SubNestedOneTwoFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['super_type']}',
        SuperNestedOneTwo,
        json,
      ),
    };

Map<String, dynamic> _$SuperNestedOneTwoToJson(SuperNestedOneTwo instance) =>
    switch (instance) {
      final SubNestedOneTwo instance => {
        'super_type': 'SubNestedOneTwo',
        ..._$SubNestedOneTwoToJson(instance),
      },
    };
''')
@JsonSerializable(unionDiscriminator: 'super_type')
sealed class SuperNestedOneTwo extends SuperSuperNestedOne {
  const SuperNestedOneTwo();
}

@ShouldGenerate(r'''
SuperNestedTwoOne _$SuperNestedTwoOneFromJson(Map<String, dynamic> json) =>
    switch (json['super_type']) {
      'SubNestedTwoOne' => _$SubNestedTwoOneFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['super_type']}',
        SuperNestedTwoOne,
        json,
      ),
    };

Map<String, dynamic> _$SuperNestedTwoOneToJson(SuperNestedTwoOne instance) =>
    switch (instance) {
      final SubNestedTwoOne instance => {
        'super_type': 'SubNestedTwoOne',
        ..._$SubNestedTwoOneToJson(instance),
      },
    };
''')
@JsonSerializable(unionDiscriminator: 'super_type')
sealed class SuperNestedTwoOne extends SuperSuperNestedTwo {
  const SuperNestedTwoOne();
}

@ShouldGenerate(r'''
SuperNestedTwoTwo _$SuperNestedTwoTwoFromJson(Map<String, dynamic> json) =>
    switch (json['super_type']) {
      'SubNestedTwoTwo' => _$SubNestedTwoTwoFromJson(json),
      _ => throw UnrecognizedUnionTypeException(
        '${json['super_type']}',
        SuperNestedTwoTwo,
        json,
      ),
    };

Map<String, dynamic> _$SuperNestedTwoTwoToJson(SuperNestedTwoTwo instance) =>
    switch (instance) {
      final SubNestedTwoTwo instance => {
        'super_type': 'SubNestedTwoTwo',
        ..._$SubNestedTwoTwoToJson(instance),
      },
    };
''')
@JsonSerializable(unionDiscriminator: 'super_type')
sealed class SuperNestedTwoTwo extends SuperSuperNestedTwo {
  const SuperNestedTwoTwo();
}

@ShouldGenerate(r'''
SubNestedOneOne _$SubNestedOneOneFromJson(Map<String, dynamic> json) =>
    SubNestedOneOne(oneOneField: json['oneOneField'] as String);

Map<String, dynamic> _$SubNestedOneOneToJson(SubNestedOneOne instance) =>
    <String, dynamic>{'oneOneField': instance.oneOneField};
''')
@JsonSerializable()
class SubNestedOneOne extends SuperNestedOneOne {
  final String oneOneField;

  SubNestedOneOne({required this.oneOneField});
}

@ShouldGenerate(r'''
SubNestedOneTwo _$SubNestedOneTwoFromJson(Map<String, dynamic> json) =>
    SubNestedOneTwo(oneTwoField: json['oneTwoField'] as String);

Map<String, dynamic> _$SubNestedOneTwoToJson(SubNestedOneTwo instance) =>
    <String, dynamic>{'oneTwoField': instance.oneTwoField};
''')
@JsonSerializable()
class SubNestedOneTwo extends SuperNestedOneTwo {
  final String oneTwoField;

  SubNestedOneTwo({required this.oneTwoField});
}

@ShouldGenerate(r'''
SubNestedTwoOne _$SubNestedTwoOneFromJson(Map<String, dynamic> json) =>
    SubNestedTwoOne(twoOneField: json['twoOneField'] as String);

Map<String, dynamic> _$SubNestedTwoOneToJson(SubNestedTwoOne instance) =>
    <String, dynamic>{'twoOneField': instance.twoOneField};
''')
@JsonSerializable()
class SubNestedTwoOne extends SuperNestedTwoOne {
  final String twoOneField;

  SubNestedTwoOne({required this.twoOneField});
}

@ShouldGenerate(r'''
SubNestedTwoTwo _$SubNestedTwoTwoFromJson(Map<String, dynamic> json) =>
    SubNestedTwoTwo(twoTwoField: json['twoTwoField'] as String);

Map<String, dynamic> _$SubNestedTwoTwoToJson(SubNestedTwoTwo instance) =>
    <String, dynamic>{'twoTwoField': instance.twoTwoField};
''')
@JsonSerializable()
class SubNestedTwoTwo extends SuperNestedTwoTwo {
  final String twoTwoField;

  SubNestedTwoTwo({required this.twoTwoField});
}

@ShouldGenerate(r'''
SuperMultipleImplOne _$SuperMultipleImplOneFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'SubOneMultipleImpl' => _$SubOneMultipleImplFromJson(json),
  'SubThreeMultipleImpl' => _$SubThreeMultipleImplFromJson(json),
  'SubFourMultipleImpl' => _$SubFourMultipleImplFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperMultipleImplOne,
    json,
  ),
};

Map<String, dynamic> _$SuperMultipleImplOneToJson(
  SuperMultipleImplOne instance,
) => switch (instance) {
  final SubOneMultipleImpl instance => {
    'type': 'SubOneMultipleImpl',
    ..._$SubOneMultipleImplToJson(instance),
  },
  final SubThreeMultipleImpl instance => {
    'type': 'SubThreeMultipleImpl',
    ..._$SubThreeMultipleImplToJson(instance),
  },
  final SubFourMultipleImpl instance => {
    'type': 'SubFourMultipleImpl',
    ..._$SubFourMultipleImplToJson(instance),
  },
};
''')
@JsonSerializable()
sealed class SuperMultipleImplOne {}

@ShouldGenerate(r'''
SuperMultipleImplTwo _$SuperMultipleImplTwoFromJson(
  Map<String, dynamic> json,
) => switch (json['type']) {
  'SubTwoMultipleImpl' => _$SubTwoMultipleImplFromJson(json),
  'SubThreeMultipleImpl' => _$SubThreeMultipleImplFromJson(json),
  'SubFourMultipleImpl' => _$SubFourMultipleImplFromJson(json),
  _ => throw UnrecognizedUnionTypeException(
    '${json['type']}',
    SuperMultipleImplTwo,
    json,
  ),
};

Map<String, dynamic> _$SuperMultipleImplTwoToJson(
  SuperMultipleImplTwo instance,
) => switch (instance) {
  final SubTwoMultipleImpl instance => {
    'type': 'SubTwoMultipleImpl',
    ..._$SubTwoMultipleImplToJson(instance),
  },
  final SubThreeMultipleImpl instance => {
    'type': 'SubThreeMultipleImpl',
    ..._$SubThreeMultipleImplToJson(instance),
  },
  final SubFourMultipleImpl instance => {
    'type': 'SubFourMultipleImpl',
    ..._$SubFourMultipleImplToJson(instance),
  },
};
''')
@JsonSerializable()
sealed class SuperMultipleImplTwo {}

@ShouldGenerate(r'''
SubOneMultipleImpl _$SubOneMultipleImplFromJson(Map<String, dynamic> json) =>
    SubOneMultipleImpl(json['subOneField'] as String);

Map<String, dynamic> _$SubOneMultipleImplToJson(SubOneMultipleImpl instance) =>
    <String, dynamic>{'subOneField': instance.subOneField};
''')
@JsonSerializable()
class SubOneMultipleImpl implements SuperMultipleImplOne {
  final String subOneField;

  SubOneMultipleImpl(this.subOneField);
}

@ShouldGenerate(r'''
SubTwoMultipleImpl _$SubTwoMultipleImplFromJson(Map<String, dynamic> json) =>
    SubTwoMultipleImpl(json['subTwoField'] as String);

Map<String, dynamic> _$SubTwoMultipleImplToJson(SubTwoMultipleImpl instance) =>
    <String, dynamic>{'subTwoField': instance.subTwoField};
''')
@JsonSerializable()
class SubTwoMultipleImpl implements SuperMultipleImplTwo {
  final String subTwoField;

  SubTwoMultipleImpl(this.subTwoField);
}

@ShouldGenerate(r'''
SubThreeMultipleImpl _$SubThreeMultipleImplFromJson(
  Map<String, dynamic> json,
) => SubThreeMultipleImpl(json['subThreeField'] as String);

Map<String, dynamic> _$SubThreeMultipleImplToJson(
  SubThreeMultipleImpl instance,
) => <String, dynamic>{'subThreeField': instance.subThreeField};
''')
@JsonSerializable()
class SubThreeMultipleImpl
    implements SuperMultipleImplOne, SuperMultipleImplTwo {
  final String subThreeField;

  SubThreeMultipleImpl(this.subThreeField);
}

@ShouldGenerate(r'''
SubFourMultipleImpl _$SubFourMultipleImplFromJson(Map<String, dynamic> json) =>
    SubFourMultipleImpl(json['subFourField'] as String);

Map<String, dynamic> _$SubFourMultipleImplToJson(
  SubFourMultipleImpl instance,
) => <String, dynamic>{'subFourField': instance.subFourField};
''')
@JsonSerializable()
class SubFourMultipleImpl
    implements SuperMultipleImplOne, SuperMultipleImplTwo {
  final String subFourField;

  SubFourMultipleImpl(this.subFourField);
}
