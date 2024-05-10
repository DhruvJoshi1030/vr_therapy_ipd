import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class VideoPlayerItema extends StatefulWidget {
  final String videoUrl;

  VideoPlayerItema({required this.videoUrl});

  @override
  _VideoPlayerItemaState createState() => _VideoPlayerItemaState();
}

class _VideoPlayerItemaState extends State<VideoPlayerItema> {
  late YoutubePlayerController _controller;
  String arduinoData =
      ''; // Variable to store Arduino data received from the server

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    // Start fetching Arduino data periodically
    Timer.periodic(const Duration(seconds: 5), (timer) {
      startPulseMeter();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> startPulseMeter() async {
    try {
      // Make HTTP request to your Flask API endpoint
      final response =
          await http.get(Uri.parse('http://127.0.0.1:5000/api/serial_data'));
      if (response.statusCode == 200) {
        // Parse JSON response
        final data = jsonDecode(response.body);
        final newData = data['data'];
        // Update UI with Arduino data
        setState(() {
          arduinoData = newData
              .toString(); // Update the UI state with the received Arduino data
          print('Received Arduino data: $arduinoData');
        });
      } else {
        // Handle error if API request fails
        print('Failed to fetch Arduino data: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or other errors
      print('Error fetching Arduino data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    startPulseMeter();
                  },
                  child: Text('Play'),
                ),
                SizedBox(width: 16.0),
                Text(
                  'Arduino Data: $arduinoData', // Display Arduino data in the UI
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}