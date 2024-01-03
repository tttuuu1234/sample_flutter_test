import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return const TodoRepository();
});

class TodoRepository {
  const TodoRepository();

  Stream<QuerySnapshot<TodoDomain>> streamList() {
    return FirebaseFirestore.instance
        .collection('todos')
        .withConverter<TodoDomain>(
          fromFirestore: (snapshot, _) => TodoDomain.fromDoc(snapshot),
          toFirestore: (value, _) => value.toJson()..remove('id'),
        )
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> add({required String title}) async {
    await FirebaseFirestore.instance.collection('todos').add({
      'title': title,
      'date': DateTime.now(),
    });
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }
}
