import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hackkorea2022/app/data/models/user_model.dart';

import '../../../constants.dart';

class UserProvider {
  CollectionReference<UserModel> userRef = FirebaseFirestore.instance
      .collection(FirestoreConstants.user)
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
    toFirestore: (UserModel, _) => UserModel.toJson(),
  );


  Future<UserModel?> checkUserExist(String uid)async{
    DocumentSnapshot<UserModel> k = await userRef.doc(uid).get();
      if(k.exists)return k.data();
      return null;
  }

  // Stream<UserModel> getStateStream()async *{
  //   Stream<DocumentSnapshot<CurrentStateModel>> stream =  currentStateRef.doc(FirestoreConstants.currentState).snapshots();
  //   CurrentStateModel emptymodel =  CurrentStateModel(forceUpdate: false,updateTriggeredAt: Timestamp.now(),lastUpdatedAt: Timestamp.now(),isLightOn: true);
  //   await for (var value in stream){
  //     yield value.data()??emptymodel;
  //   }
  // }
  //
  //
  // //todo : potentially rewrite current state with old data but solved within 30min
  // Future<bool> enrollForcedUpdate() async {
  //   DocumentSnapshot<CurrentStateModel> stateDoc = await currentStateRef.doc(FirestoreConstants.currentState).get();
  //   CurrentStateModel state = stateDoc.data()!;
  //   state.forceUpdate = true;
  //   state.updateTriggeredAt = Timestamp.now();
  //   await currentStateRef.doc(FirestoreConstants.currentState).set(state);
  //   return true;
  // }

}