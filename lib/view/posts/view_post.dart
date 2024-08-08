import '../../exports.dart';

class ViewArticlePage extends StatelessWidget {
  final Post post;

  ViewArticlePage({Key? key, required this.post}) : super(key: key);
  final PostController postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(26, 53, 75, 217),
        centerTitle: true,
        title: const Text(
          'Blog',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImage(context),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCategory(),
                  const SizedBox(height: 10),
                  _buildTitle(),
                  const SizedBox(height: 15),
                  _buildContent(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(context),
      child: Hero(
        tag: 'articleImage${post.id}',
        child: Image.network(
          post.images.isNotEmpty ? post.images.first : 'https://via.placeholder.com/400x200',
          fit: BoxFit.cover,
          height: 200,
          width: double.infinity,
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: post.category.map((category) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            category,
            style: TextStyle(
              color: Colors.blue[700],
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTitle() {
    return Text(
      post.title ?? 'Untitled',
      style: const TextStyle(
        color: Color(0xFF101828),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildContent() {
    return Text(
      post.description ?? 'No content available.',
      style: const TextStyle(fontSize: 16, height: 1.6),
    );
  }

  void _showFullScreenImage(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Scaffold(
        body: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Center(
            child: Hero(
              tag: 'articleImage${post.id}',
              child: PhotoView(
                imageProvider: NetworkImage(post.images.isNotEmpty ? post.images.first : 'https://via.placeholder.com/400x200'),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
              ),
            ),
          ),
        ),
      ),
    ));
  }
}