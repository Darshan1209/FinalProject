import 'package:apt3065/src/utils/firebase_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final CurrentUserDataProvider =
    FutureProvider<Map<String, dynamic>?>((ref) async {
  try {
    // QuerySnapshot<Map<String, dynamic>> docsnap = await firebaseFireStore
    //     .collection('userProfile')
    //     .where('', isEqualTo: DateFormat('yMd').format())
    //     .limit(1)
    //     .get();
    DocumentSnapshot<Map<String, dynamic>> currentUserProfile =
        await FirebaseFirestore.instance
            .collection('userProfile')
            .doc(firebaseAuth.currentUser?.uid)
            .get();
    return currentUserProfile.data();
  } catch (e) {
    print(e);
  }
  throw 0;
});

final HomePageSubjectsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  try {
    // QuerySnapshot<Map<String, dynamic>> docsnap = await firebaseFireStore
    //     .collection('userProfile')
    //     .where('', isEqualTo: DateFormat('yMd').format())
    //     .limit(1)
    //     .get();
    QuerySnapshot<Map<String, dynamic>> currentUserProfile =
        await FirebaseFirestore.instance.collection('Subjects').get();
    final subjectNames =
        currentUserProfile.docs.map((e) => {e.id: e.data()}).toList();
    return subjectNames;
  } catch (e) {
    print(e);
  }
  throw 0;
});

final TrendingTopicsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  try {
    // QuerySnapshot<Map<String, dynamic>> docsnap = await firebaseFireStore
    //     .collection('userProfile')
    //     .where('', isEqualTo: DateFormat('yMd').format())
    //     .limit(1)
    //     .get();
    QuerySnapshot<Map<String, dynamic>> topicData =
        await FirebaseFirestore.instance.collectionGroup('Topics').get();
    final subjectNames = topicData.docs.map((e) => {e.id: e.data()}).toList();
    return subjectNames;
  } catch (e) {
    print(e);
  }
  throw 0;
});

final topicNotesReaderProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
        (ref, topicName) async {
  String subjectName = '';
  if (topicName == 'Diffusion' || topicName == 'Cells') {
    subjectName = 'Biology';
  } else if (topicName == "Waves" || topicName == "Pendulum") {
    subjectName = 'Physics';
  } else if (topicName == "AcidBaseReaction" || topicName == "Titration") {
    subjectName = 'Chemistry';
  }
  try {
    // Define a function to recursively fetch documents from a collection and its subcollections
    Future<List<Map<String, dynamic>>> fetchCollectionAndSubcollections(
        CollectionReference collectionRef) async {
      List<Map<String, dynamic>> dataList = [];
      // Fetch documents from the current collection
      QuerySnapshot<Object?> snapshot = await collectionRef.get();
      // Add documents to dataList
      dataList.addAll(
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>));

      // Fetch documents from subcollections
      List<QuerySnapshot<Map<String, dynamic>>> subcollectionSnapshots =
          await Future.wait(snapshot.docs.map((doc) {
        return doc.reference.collection('Topics').get();
      }));

      // Recursively fetch documents from subcollections
      for (var subcollectionSnapshot in subcollectionSnapshots) {
        dataList.addAll(subcollectionSnapshot.docs.map((doc) => doc.data()));
      }
      return dataList;
    }

    // Fetch documents from the main collection and its subcollections
    CollectionReference Notesref = FirebaseFirestore.instance
        .collection('Subjects')
        .doc(subjectName)
        .collection('Topics')
        .doc(topicName)
        .collection('Notes');

    List<Map<String, dynamic>> topicData =
        await fetchCollectionAndSubcollections(Notesref);

    // Return the combined data
    print(topicData);
    return topicData;
  } catch (e) {
    print(e);
    throw e; // Re-throw the error to handle it outside
  }
});

final topicVideosReaderProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
        (ref, topicName) async {
  String subjectName = '';
  if (topicName == 'Diffusion' || topicName == 'Cells') {
    subjectName = 'Biology';
  } else if (topicName == "Waves" || topicName == "Pendulum") {
    subjectName = 'Physics';
  } else if (topicName == "AcidBaseReaction" || topicName == "Titration") {
    subjectName = 'Chemistry';
  }
  try {
    // Define a function to recursively fetch documents from a collection and its subcollections
    Future<List<Map<String, dynamic>>> fetchCollectionAndSubcollections(
        CollectionReference collectionRef) async {
      List<Map<String, dynamic>> dataList = [];
      // Fetch documents from the current collection
      QuerySnapshot<Object?> snapshot = await collectionRef.get();
      // Add documents to dataList
      dataList.addAll(
          snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>));

      // Fetch documents from subcollections
      List<QuerySnapshot<Map<String, dynamic>>> subcollectionSnapshots =
          await Future.wait(snapshot.docs.map((doc) {
        return doc.reference.collection('Topics').get();
      }));

      // Recursively fetch documents from subcollections
      for (var subcollectionSnapshot in subcollectionSnapshots) {
        dataList.addAll(subcollectionSnapshot.docs.map((doc) => doc.data()));
      }
      return dataList;
    }

    // Fetch documents from the main collection and its subcollections
    CollectionReference Notesref = FirebaseFirestore.instance
        .collection('Subjects')
        .doc(subjectName)
        .collection('Topics')
        .doc(topicName)
        .collection('Videos');

    List<Map<String, dynamic>> topicData =
        await fetchCollectionAndSubcollections(Notesref);

    // Return the combined data
    return topicData;
  } catch (e) {
    print(e);
    throw e; // Re-throw the error to handle it outside
  }
});

final TopicsFinderProvider =
    FutureProvider.family<List<Map<String, dynamic>>, String>(
  (ref, subjectName) async {
    try {
      QuerySnapshot<Map<String, dynamic>> currentSubjectTopics =
          await FirebaseFirestore.instance
              .collection('Subjects')
              .doc(subjectName)
              .collection('Topics')
              .get();
      final subjectNames =
          currentSubjectTopics.docs.map((e) => {e.id: e.data()}).toList();
      print(subjectNames);
      return subjectNames;
    } catch (e) {
      print(e);
    }
    return [{}];
  },
);

final ProfileDataProvider = FutureProvider<Map<String, dynamic>>(
  (ref) async {
    try {
      QuerySnapshot<Map<String, dynamic>> currentSubjectTopics =
          await FirebaseFirestore.instance.collection('userProfile').get();
      final subjectNames =
          currentSubjectTopics.docs.map((e) => {e.id: e.data()}).toList();
      print(subjectNames);
    } catch (e) {
      print(e);
    }
    return {};
  },
);
