import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Robertstore {
  static final Robertstore instance = Robertstore._init();

  factory Robertstore() {
    return instance;
  }

  Robertstore._init();

  void Add_entry_good_paper(String uid, String date, String thing1,
      String thing2, String thing3, int happiness) async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .collection("Memories")
        .doc(date)
        .set({
      'thing1': thing1,
      'thing2': thing2,
      'thing3': thing3,
      'happiness': happiness
    });
    await FirebaseFirestore.instance
        .collection("Memories")
        .doc(date)
        .set({"count": FieldValue.increment(1)}, SetOptions(merge: true));
  }

  Future<int> getWrites() async {
    int res = 0;
    String date = DateTime.now().toString().substring(0, 10);

    await FirebaseFirestore.instance
        .collection("Memories")
        .doc(date)
        .get()
        .then((value) {
      res = value.data() != null ? value.data()!["count"] : 0;
    });

    return res;
  }

  Future<int> getUserCount() async {
    int res = 0;
    await FirebaseFirestore.instance.collection("Users").get().then((value) {
      res = value.docs.length;
    });
    return res;
  }

  Future<String?> getName(String uid) async {
    String? res;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(uid)
        .get()
        .then((value) {
      res = value.data()!["Last name"] + " " + value.data()!["First name"];
    });
    return res;
  }

  Future<void> createUser(String uid, String fname, String lname) async {
    await FirebaseFirestore.instance.collection("Users").doc(uid).set({
      "Last name": lname,
      "First name": fname,
    });
  }

  Future<List<Map<String, dynamic>>> fetchMemories() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference collection = FirebaseFirestore.instance
          .collection("Users")
          .doc(user.uid)
          .collection("Memories");
      var snapshot = await collection.get();
      List<Map<String, dynamic>> allData = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      //print("aici e allData");
      //print(allData);
      return allData;
    }
    return [
      {
        "thing1": "There was an error",
        "thing2": "because you are not",
        "thing3": "registered.",
        "happiness": 1
      }
    ];
  }

  Future<int> getTotalWrites() async {
    int res = 0;
    await FirebaseFirestore.instance.collection("Memories").get().then((value) {
      for (var doc in value.docs) {
        res += doc.data()["count"] as int;
      }
    });
    return res;
  }
}
