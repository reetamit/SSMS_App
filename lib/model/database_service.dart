import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  //Create (update)
  Future<void> create({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    //String jsonData = jsonEncode(data);
    //final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    //await ref.set(data);
    // 1. Get a reference to the path.
    final DatabaseReference parentRef = _firebaseDatabase.ref().child(path);
    // 2. Call push() on the parent reference to get a new unique key.
    final DatabaseReference newChildRef = parentRef.push();
    // 3. Set the data on the new child reference.
    await newChildRef.set(data);
  }

  // Read
  Future<DataSnapshot?> read({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    final DataSnapshot snapshot = await ref.get();
    return snapshot.exists ? snapshot : null;
  }

  // Update
  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.update(data);
  }

  // Delete
  Future<void> delete({required String path}) async {
    final DatabaseReference ref = _firebaseDatabase.ref().child(path);
    await ref.remove();
  }
}
