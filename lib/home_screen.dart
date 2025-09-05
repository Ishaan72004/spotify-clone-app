import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Good evening'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuickAccessSection(),
            const SizedBox(height: 24),
            _buildCarouselSection('Recently played', recentlyPlayed),
            const SizedBox(height: 30),
            _buildTopMixesSection(),
            const SizedBox(height: 24),
            _buildCarouselSection('Made for you', madeForYou),
            const SizedBox(height: 24),
            _buildCarouselSection('Popular artists', popularArtists),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAccessSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          // User profile image
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/user_profile.jpg'),
          ),
          const SizedBox(width: 8),
          // Scrollable list of filter chips
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildQuickAccessChip('All', isSelected: true),
                  _buildQuickAccessChip('Music'),
                  _buildQuickAccessChip('Podcasts'),
                  _buildQuickAccessChip('Live Events'),
                  _buildQuickAccessChip('Made for You'),
                  _buildQuickAccessChip('New Releases'),
                  _buildQuickAccessChip('Charts'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessChip(String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Colors.green[500] : Colors.grey[800],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.black : Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildCarouselSection(String title, List<Map<String, String>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildCarouselItem(items[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopMixesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Your top mixes',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: topMixes.length,
            itemBuilder: (context, index) {
              return _buildMixCard(topMixes[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(Map<String, String> item) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: item['image']!.startsWith('assets/')
                ? Image.asset(
              item['image']!,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
            )
                : CachedNetworkImage(
              imageUrl: item['image']!,
              width: 140,
              height: 140,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                color: Colors.grey[800],
                width: 140,
                height: 140,
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[800],
                width: 140,
                height: 140,
                child: const Icon(Icons.music_note, color: Colors.grey),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            item['title']!,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildMixCard(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: 160,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Remove the Stack and 'MIX' badge
          Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[800],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: (item['image'] as String).startsWith('assets/')
                  ? Image.asset(
                item['image'] as String,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              )
                  : CachedNetworkImage(
                imageUrl: item['image'] as String,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey[800],
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey[800],
                  child:
                  const Icon(Icons.music_note, color: Colors.grey, size: 40),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Title
          Text(
            item['title'] as String,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          // Genre label
          Text(
            item['genre'] as String,
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 12,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// Updated mock data with genres - FIXED TYPE
final List<Map<String, String>> recentlyPlayed = [
  {
    'title': 'Daily Mix 2',
    'image': 'assets/images/Daily Mix 2.jpg',
  },
  {
    'title': 'Release Radar',
    'image': 'assets/images/Spotify-Release-Radar.jpg',
  },
  {
    'title': 'Discover Weekly',
    'image': 'assets/images/Discover Weekly.jpg',
  },
  {
    'title': 'Time Capsule',
    'image': 'assets/images/Time Capsule.jpg',
  },
  {
    'title': 'Chill Mix',
    'image': 'assets/images/Chill Mix.jpg',
  },
];

final List<Map<String, dynamic>> topMixes = [
  {
    'title': 'Top Mix: Pop Rock',
    'image': 'assets/images/pop rock.jpg',
    'genre': 'Rock',
  },
  {
    'title': 'Top Mix: Mega Pop Hits',
    'image': 'assets/images/mega pop mix.jpg',
    'genre': 'Pop',
  },
  {
    'title': 'Top Mix: Hip Hop',
    'image': 'assets/images/hiphop mix.jpg',
    'genre': 'Hip Hop',
  },
  {
    'title': 'Top Mix: Electronic',
    'image': 'assets/images/electronic mix.jpg',
    'genre': 'Electronic',
  },
];

final List<Map<String, String>> madeForYou = [
  {
    'title': 'Daily Drive',
    'image': 'assets/images/Daily Drive.jpg',
  },
  {
    'title': 'Mood Booster',
    'image': 'assets/images/Mood Booster.jpg',
  },
  {
    'title': 'Peaceful Piano',
    'image': 'assets/images/Peaceful Piano.jpg',
  },
  {
    'title': 'Energy Boost',
    'image': 'assets/images/Energy Boost.jpg',
  },
];

final List<Map<String, String>> popularArtists = [
  {
    'title': 'The Weeknd',
    'image': 'assets/images/theweeknd.jpg',
  },
  {
    'title': 'Arijit Singh',
    'image': 'assets/images/arijit singh.jpg',
  },
  {
    'title': 'Alan Walker',
    'image': 'assets/images/alan walker.jpg',
  },
  {
    'title': 'Selena Gomez',
    'image': 'assets/images/selena gomez.jpg',
  },
];