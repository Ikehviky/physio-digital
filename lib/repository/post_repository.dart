import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/post/post.dart';

abstract class PostRepository {
  Future<void> addPost(Post post);
  Future<void> updatePost(Post postId);
  Future<void> removePost(String postId);
  Future<List<Post>> getAllPost();
  Future<Post?> getPost(String postId);
  Future<String> uploadImage(File image);
}
class PostRepositoryImpl implements PostRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  PostRepositoryImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instanceFor(bucket: 'gs://physio-digital-8d7b6.appspot.com');

  @override
  Future<void> addPost(Post post) async {
    DocumentReference doc = _firestore.collection('posts').doc();
    await doc.set(post.toJson()..addAll({'id': doc.id}));
  }

  @override
  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update(post.toJson());
  }

  @override
  Future<void> removePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  @override
  Future<List<Post>> getAllPost() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('posts').get();
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        // Handle 'image' field that could be either a string or a list
        if (data['image'] is String) {
          data['image'] = [data['image']];
        } else if (data['image'] is! List) {
          data['image'] = [];
        }

        // Convert other fields
        data['id'] = data['id']?.toString();
        data['title'] = data['title']?.toString();
        data['description'] = data['description']?.toString();
        data['category'] = (data['category'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [];

        return Post.fromJson(data);
      }).toList();
    } catch (e) {
      print('Error in getAllPost: $e');
      rethrow;
    }
  }

  @override
  Future<Post?> getPost(String postId) async {
    DocumentSnapshot doc = await _firestore.collection('posts').doc(postId).get();
    if (doc.exists) {
      return Post.fromJson(doc.data() as Map<String, dynamic>);
    }
    return null;
  }

  @override
  Future<String> uploadImage(File image) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = _storage.ref().child('post_images/$fileName');
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    return await taskSnapshot.ref.getDownloadURL();
  }
}