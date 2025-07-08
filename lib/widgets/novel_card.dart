import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // for formatting createdDate

class NovelCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> genres;
  final String coverImage;       // ✅ added
  final DateTime createdDate;    // ✅ added
  final VoidCallback onTap;

  const NovelCard({
    super.key,
    required this.title,
    required this.description,
    required this.genres,
    required this.coverImage,    // ✅ added
    required this.createdDate,   // ✅ added
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).colorScheme.surface;
    final textColor = Theme.of(context).colorScheme.onBackground;

    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Optional Cover Image Preview
            if (coverImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  coverImage,
                  height: 180,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 180,
                    color: Colors.grey.withOpacity(0.2),
                    child: const Center(child: Icon(Icons.image_not_supported)),
                  ),
                ),
              ),
            if (coverImage.isNotEmpty) const SizedBox(height: 12),

            // Title
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14,
                color: textColor.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 12),

            // Genre Chips
            if (genres.isNotEmpty)
              SizedBox(
                height: 32,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: genres.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return Chip(
                      label: Text(
                        genres[index],
                        style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                        ),
                      ),
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),

            // Created Date Display
            Text(
              'Created on ${DateFormat.yMMMd().format(createdDate)}',
              style: TextStyle(
                fontSize: 12,
                color: textColor.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
