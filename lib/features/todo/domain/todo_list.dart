import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';

part 'todo_list.freezed.dart';
part 'todo_list.g.dart';

@freezed
class TodoListDomain with _$TodoListDomain {
  const factory TodoListDomain({
    required List<TodoDomain> list
  }) = _Person;

  factory TodoListDomain.fromJson(Map<String, dynamic> json) =>
      _$TodoListDomainFromJson(json);
}
