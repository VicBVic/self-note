import 'package:cloud_firestore/cloud_firestore.dart';

class Robertstore {
  void Add_entry_good_paper(String uid,String date,String thing1,String thing2,String thing3,int happiness)
  {
    FirebaseFirestore.instance.collection(uid).doc(date).set
      (
        {
          'thing1':thing1,
          'thing2':thing2,
          'thing3':thing3,
          'happiness':happiness
        }
      );
  }
  Future<int> Get_user_count() async
  {
    int toreturn = 0;
    await FirebaseFirestore.instance
    .collection("general")
    .doc("users")
    .get()
    .then((value){
      var d = value.data()!;
      toreturn = d["count"];
    });
    return toreturn;
  }
  void Update_user_count(int delta) async
  {
    Map<String,dynamic>? d;
    await FirebaseFirestore.instance
    .collection("general")
    .doc("users")
    .get()
    .then((value){
      d = value.data()!;
    });

    if(d!=null)
    {
      d!["count"]+=delta;
      await FirebaseFirestore.instance.collection("general").doc("users").set(d!);
    }
  }
}