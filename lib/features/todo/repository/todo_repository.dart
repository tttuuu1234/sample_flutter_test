import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sample_flutter_test/features/todo/domain/todo.dart';
import 'package:sample_flutter_test/utils/provider.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository(ref.read(firestoreProvider));
});

class TodoRepository {
  const TodoRepository(this._firebaseFirestore);

  final FirebaseFirestore _firebaseFirestore;

  Stream<QuerySnapshot<TodoDomain>> streamList() {
    return _firebaseFirestore
        .collection('todos')
        .withConverter<TodoDomain>(
          fromFirestore: (snapshot, _) => TodoDomain.fromDoc(snapshot),
          toFirestore: (value, _) => value.toJson()..remove('id'),
        )
        .orderBy('date', descending: true)
        .snapshots();
  }

  Future<void> add({required String title}) async {
    await _firebaseFirestore.collection('todos').add({
      'title': title,
      'date': DateTime.now(),
    });
  }

  Future<void> delete(String id) async {
    await FirebaseFirestore.instance.collection('todos').doc(id).delete();
  }
}
