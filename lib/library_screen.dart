import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  String _selectedFilter = 'Playlists';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/user_profile.jpg'),
            ),
            const SizedBox(width: 8),
            const Text('Your Library'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildFilterChips(),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.swap_vert, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Recents',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(Icons.grid_view, color: Colors.white),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: libraryItems.length,
              itemBuilder: (context, index) {
                final item = libraryItems[index];
                if (_selectedFilter == 'All' || item['type'] == _selectedFilter) {
                  return _buildLibraryItem(item);
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          _buildFilterChip('Playlists'),
          const SizedBox(width: 8),
          _buildFilterChip('Artists'),
          const SizedBox(width: 8),
          _buildFilterChip('Albums'),
          const SizedBox(width: 8),
          _buildFilterChip('All'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLibraryItem(Map<String, dynamic> item) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(item['type'] == 'Artists' ? 50 : 4),
        child: CachedNetworkImage(
          imageUrl: item['image'],
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          placeholder: (context, url) => Container(
            color: Colors.grey[800],
            width: 50,
            height: 50,
          ),
        ),
      ),
      title: Text(
        item['title'],
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        item['subtitle'],
        style: TextStyle(
          color: Colors.grey[400],
        ),
      ),
      trailing: IconButton(
        icon: const Icon(Icons.more_vert, color: Colors.grey),
        onPressed: () {},
      ),
    );
  }
}

// Mock data for library
final List<Map<String, dynamic>> libraryItems = [
  {
    'title': 'Liked Songs',
    'subtitle': 'Playlist • 300 songs',
    'image': 'https://misc.scdn.co/liked-songs/liked-songs-300.jpg',
    'type': 'Playlists'
  },
  {
    'title': 'Imagine Dragons',
    'subtitle': 'Artist',
    'image': 'https://resources.tidal.com/images/b5fc9952/f318/48ee/94f7/1d1f390f2871/750x750.jpg',
    'type': 'Artists'
  },
  {
    'title': 'enemy',
    'subtitle': 'Album •  imagine dragons',
    'image': 'https://i1.sndcdn.com/artworks-drGxwtqRBEImBAnj-jPsEEg-t500x500.jpg',
    'type': 'Albums'
  },
  {
    'title': 'Bollywood Songs',
    'subtitle': 'Playlist • Ishaan',
    'image': 'https://i.scdn.co/image/ab67616d0000b2733c528c581a6b3f940a24cb5f',
    'type': 'Playlists'
  },
  {
    'title': 'Dua Lipa',
    'subtitle': 'Artist',
    'image': 'https://www.instyle.com/thmb/iZ_O9n7esXD8DjLRLpwQ6qJ_IWU=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1908165923-291115737cbe4782bdf5b171b4389f5e.jpg',
    'type': 'Artists'
  },
  {
    'title': 'levitating',
    'subtitle': 'Album • Dua Lipa',
    'image': 'https://i.scdn.co/image/ab67616d0000b2734bc66095f8a70bc4e6593f4f',
    'type': 'Albums'
  },
  {
    'title': 'Your Top Songs 2024',
    'subtitle': 'Playlist • Spotify',
    'image': 'https://pickasso.spotifycdn.com/image/ab67c0de0000deef/dt/v1/img/wrapped/yts/en',
    'type': 'Playlists'
  },
  {
    'title': 'KK',
    'subtitle': 'Artist',
    'image': 'https://upload.wikimedia.org/wikipedia/commons/0/09/KK_%28125%29.jpg',
    'type': 'Artists'
  },
  {
    'title': 'Jo tu mila',
    'subtitle': 'Album • KK',
    'image': 'https://i.scdn.co/image/ab67616d0000b273e7f1ff44b74df429307f4164',
    'type': 'Albums'
  },
];
