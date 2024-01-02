import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class TodoDomain with _$TodoDomain {
  const factory TodoDomain({
    required String title,
    // required DateTime date,
  }) = _Person;

  factory TodoDomain.fromJson(Map<String, dynamic> json) =>
      _$TodoDomainFromJson(json);
}
