import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class VideoListScreen extends StatelessWidget {
  final List<String> videoUrls = [
    'https://www.youtube.com/watch?v=Qvd-I7lTecI',
    'https://www.youtube.com/watch?v=0NFxcNheoLc',
    // Add more video URLs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF7EBE1),
      appBar: AppBar(
        title: Text('YouTube Video List'),
      ),
      body: ListView.builder(
        itemCount: videoUrls.length,
        itemBuilder: (context, index) {
          return VideoPlayerItem(videoUrl: videoUrls[index]);
        },
      ),
    );
  }
}

class VideoPlayerItem extends StatelessWidget {
  final String videoUrl;

  VideoPlayerItem({required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(videoUrl) ?? '',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          YoutubePlayer(
            controller: _controller,
            showVideoProgressIndicator: true,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Video Title Here', 
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
