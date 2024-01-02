import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@freezed
class TodoDomain with _$TodoDomain {
  const factory TodoDomain({
    @Default('') String id,
    required String title,
    // required DateTime date,
  }) = _TodoDomain;

  factory TodoDomain.fromDoc(DocumentSnapshot doc) {
    final data = doc.data();
    final json =
        data == null ? <String, dynamic>{} : data as Map<String, dynamic>;
    return TodoDomain.fromJson(json).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDoc() => toJson()..remove('id');

  factory TodoDomain.fromJson(Map<String, dynamic> json) =>
      _$TodoDomainFromJson(json);
}
