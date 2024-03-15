import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:educoy_app/core/services/injection_container.dart';
import 'package:educoy_app/features/auth/data/models/local_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeUtils {
  const HomeUtils._();

  static Stream<LocalUserModel> get userDataStream =>
      serviceLocator<FirebaseFirestore>()
          .collection('users')
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .snapshots()
          .map((event) => LocalUserModel.fromMap(event.data()!));
}
