import 'package:firebase_database/firebase_database.dart';
import 'package:temple_app/localization/words.dart';

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

  Future<List<Map<String, dynamic>>> getVolunteerRecordbyEmailPh({
    required String path,
    required String email,
    required String phone,
  }) async {
    try {
      // Use your existing read function
      final snapshot = await DatabaseService().read(path: path);

      List<Map<String, dynamic>> matchedData = [];

      if (snapshot != null && snapshot.value != null) {
        final data = snapshot.value as Map<dynamic, dynamic>;

        for (var entry in data.entries) {
          if (entry.value is Map<dynamic, dynamic>) {
            final record = Map<String, dynamic>.from(entry.value);

            // Match all three fields
            final bool emailMatch = record[Words.vhouremail] == email;
            final bool phoneMatch = record[Words.vhourphone] == phone;

            if (emailMatch && phoneMatch) {
              matchedData.add(record);
            }
          }
        }
      }

      return matchedData; // ✅ return all matches
    } catch (e) {
      print("Error retrieving data: $e");
      return [];
    }
  }
}
