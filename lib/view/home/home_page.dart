import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:physio_digital/view/home/upcoming_events.dart';
import '../../../exports.dart';
import 'clinic_near_you.dart';
import 'informative_articles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final HomeController homeController = Get.find();
  final PostController postController = Get.find<PostController>();
  final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);
  final TextEditingController _searchController = TextEditingController();
  final RxString _searchTerm = ''.obs;

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    await postController.fetchPosts();
    setState(() {});
  }

  void _onSearchChanged() {
    _searchTerm.value = _searchController.text.toLowerCase();
  }

  List<Post> _getFilteredPosts() {
    return postController.posts.where((post) {
      return post.title!.toLowerCase().contains(_searchTerm.value) ||
          post.description!.toLowerCase().contains(_searchTerm.value) ||
          post.category.any((cat) => cat.toLowerCase().contains(_searchTerm.value));
    }).toList();
  }

  void _onTap(int index) {
    _currentIndex.value = index;
    switch (index) {
      case 0:
        Get.toNamed('/');
        break;
      case 1:
        Get.toNamed('/marketplace');
        break;
      case 2:
        Get.toNamed('/clinic');
        break;
      case 3:
        Get.toNamed('/blog');
        break;
      case 4:
        Get.toNamed('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildSearchBar(context),
            SliverPadding(
              padding: const EdgeInsets.all(13.0),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  ClinicNearYou(),
                  Obx(() {
                    final filteredPosts = _getFilteredPosts();
                    final eventPosts = filteredPosts.where((post) => post.category.contains('Events')).toList();
                    return UpcomingEvents(events: eventPosts);
                  }),
                  const SizedBox(height: 20),
                  Obx(() {
                    final filteredPosts = _getFilteredPosts();
                    return InformativeArticles(posts: filteredPosts);
                  }),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: _currentIndex,
        builder: (context, currentIndex, _) {
          return CustomBottomNavigationBar(
            currentIndex: currentIndex,
            onTap: _onTap,
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for events or articles',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _searchController.clear();
                      _onSearchChanged();
                    },
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                cursorColor: const Color.fromARGB(255, 128, 128, 128),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}