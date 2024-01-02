import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';
import 'package:sample_flutter_test/features/todo/repository/todo.dart';

final todoListStreamProvider = StreamProvider<QuerySnapshot<TodoDomain>>((ref) {
  return ref.read(todoRepositoryProvider).streamList();
});
