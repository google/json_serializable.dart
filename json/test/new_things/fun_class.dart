// ignore_for_file: annotate_overrides
import 'package:json_annotation/json_annotation.dart';

part 'fun_class.g.dart';

@JsonSerializable(includeIfNull: false)
class Fun extends Object with _$FunSerializerMixin {
  final int a;
  final String b;
  final bool c;
  final Fun child;
  final List<Fun> innerFun;
  final List<DateTime> dates;

  Fun({this.a, this.b, this.c, this.innerFun, this.dates, this.child});

  factory Fun.fromJson(Map<String, dynamic> json) => _$FunFromJson(json);
}
