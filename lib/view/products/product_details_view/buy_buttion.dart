

import '../../../exports.dart';

class BuyNowButton extends StatelessWidget {
  final Product product;

  const BuyNowButton({Key? key, required this.product}) : super(key: key);

  Future<void> _launchWhatsApp(BuildContext context) async {
    String imageInfo = 'No image available';
    if (product.images?.isNotEmpty == true) {
      imageInfo = 'Image available at: ${product.images!.first}';
    }

    final String whatsappUrl = "https://wa.me/+2348126308488/?text=" +
        Uri.encodeComponent(
          "Product: ${product.name}\n\n"
              "Price: ₦${product.price}\n\n"
              "Details: ${product.details}\n\n"
              "Image: $imageInfo\n\n\n"
              "The above link is the image of the product.",
        );

    final Uri uri = Uri.parse(whatsappUrl);

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch WhatsApp';
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${e.toString()}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: MyButton(
        text: 'Buy Now',
        onTap: () => _launchWhatsApp(context),
      ),
    );
  }
}