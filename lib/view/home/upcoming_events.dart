import '../../../exports.dart';
import 'dart:math';

class UpcomingEvents extends StatelessWidget {
  final List<Post> events;

  const UpcomingEvents({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shuffledEventPosts = _getShuffledEventPosts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Upcoming Events', onViewAll: () {
          Get.to(() => ListPostsPage());
        }),
        _buildEventList(shuffledEventPosts),
      ],
    );
  }

  List<Post> _getShuffledEventPosts() {
    final eventPosts = events.where((post) => post.category.contains('Events')).toList();
    eventPosts.shuffle(Random());
    return eventPosts.take(3).toList(); // Display up to 3 random event posts
  }

  Widget _buildSectionTitle(String title, {required VoidCallback onViewAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          TextButton.icon(
            onPressed: onViewAll,
            label: const Text(
              'See all',
              style: TextStyle(color: Color.fromARGB(255, 99, 99, 99)),
            ),
            icon: const Icon(Icons.arrow_forward, size: 16),
            style: TextButton.styleFrom(
              iconColor: const Color.fromARGB(255, 99, 99, 99),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventList(List<Post> eventPosts) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: eventPosts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(eventPosts[index]);
      },
    );
  }

  Widget _buildPostCard(Post post) {
    return InkWell(
      onTap: () {
        Get.to(() => ViewArticlePage(post: post));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Events',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.title ?? 'Untitled',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    post.description ?? 'No description available',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: post.images.isNotEmpty
                  ? Image.network(
                post.images[0],
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.error, color: Colors.white),
                  );
                },
              )
                  : Container(
                width: 100,
                height: 100,
                color: Colors.grey[300],
                child: const Icon(Icons.image, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}