import 'package:flutter/material.dart';
import 'package:physio_digital/model/product/product.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue.shade50,
            Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection(context, 'Details', product.details, Icons.info_outline),
          const Divider(height: 1, thickness: 1, color: Colors.blue),
          _buildSection(context, 'Features', product.features, Icons.star_outline),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, String? content, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.blue, size: 28),
              const SizedBox(width: 12),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.blue.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content ?? 'Unknown',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: 16,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}