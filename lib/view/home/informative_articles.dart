import '../../../exports.dart';
import 'dart:math';

class InformativeArticles extends StatelessWidget {
  final List<Post> posts;

  const InformativeArticles({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final randomPosts = _getRandomPosts();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Informative Articles', onViewAll: () {
          Get.to(() => ListPostsPage());
        }),
        _buildArticleList(randomPosts),
      ],
    );
  }

  List<Post> _getRandomPosts() {
    final shuffledPosts = List<Post>.from(posts)..shuffle(Random());
    return shuffledPosts.take(3).toList(); // Display up to 3 random posts
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

  Widget _buildArticleList(List<Post> articles) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return _buildArticleCard(article);
      },
    );
  }

  Widget _buildArticleCard(Post article) {
    return GestureDetector(
      onTap: () {
        Get.to(() => ViewArticlePage(post: article));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.images.isNotEmpty)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  article.images[0],
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[300],
                      child: const Icon(Icons.article, size: 50),
                    );
                  },
                ),
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      article.category.isNotEmpty ? article.category[0] : 'Uncategorized',
                      style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title ?? 'Untitled Article',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.description ?? 'No description available',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}