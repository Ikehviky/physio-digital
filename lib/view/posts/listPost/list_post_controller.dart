import 'package:physio_digital/model/post/post.dart';
import 'package:physio_digital/repository/post_repository.dart';
import 'dart:io';
import '../../../exports.dart';

class PostController extends GetxController {
  final PostRepository postRepository;
  final RxList<Post> posts = <Post>[].obs;
  final RxBool isLoading = false.obs;
  final RxInt hoveredIndex = RxInt(-1);

  PostController({required this.postRepository});

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    try {
      isLoading.value = true;
      posts.value = await postRepository.getAllPost();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch posts: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> removePost(String postId) async {
    try {
      await postRepository.removePost(postId);
      await fetchPosts();
      Get.snackbar('Success', 'Post removed successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error', 'Failed to remove post: $e');
    }
  }

  Future<String> uploadImage(File image) async {
    try {
      return await postRepository.uploadImage(image);
    } catch (e) {
      Get.snackbar('Error', 'Failed to upload image: $e');
      rethrow;
    }
  }

  void setHoveredIndex(int index) {
    hoveredIndex.value = index;
  }

  Future<void> addPost(Post post) async {
    try {
      await postRepository.addPost(post);
      posts.add(post);
      Get.snackbar('Success', 'Post added successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to add post: $e');
    }
  }

  Future<void> updatePost(Post post) async {
    try {
      await postRepository.updatePost(post);
      final index = posts.indexWhere((p) => p.id == post.id);
      if (index != -1) {
        posts[index] = post;
      }
      Get.snackbar('Success', 'Post updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update post: $e');
    }
  }

}