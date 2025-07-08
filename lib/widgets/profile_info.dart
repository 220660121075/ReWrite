import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final VoidCallback onTopUp;

  const ProfileInfo({
    super.key,
    required this.onTopUp,
  });

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    final cardColor = Theme.of(context).colorScheme.surface;

    final User? user = FirebaseAuth.instance.currentUser;
    final String name = user?.displayName ?? 'Sign In';
    final String? photoURL = user?.photoURL;
    final ImageProvider profileImage = photoURL != null
        ? NetworkImage(photoURL)
        : const AssetImage('assets/default_profile.png');

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundImage: profileImage,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
                ),
              ),
              ElevatedButton(
                onPressed: onTopUp,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                child: const Text('TOP UP'),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _StatItem(title: 'Power', value: '--'),
              _StatItem(title: 'Energy', value: '--'),
              _StatItem(title: 'Spirit', value: '--'),
            ],
          )
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String title;
  final String value;
  const _StatItem({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).colorScheme.onBackground;
    return Column(
      children: [
        Text(value, style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold)),
        Text(title, style: TextStyle(color: textColor.withOpacity(0.6)))
      ],
    );
  }
}
