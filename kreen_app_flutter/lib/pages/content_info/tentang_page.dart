import 'package:flutter/material.dart';
import 'package:kreen_app_flutter/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TentangPage extends StatefulWidget {
  const TentangPage({super.key});

  @override
  State<TentangPage> createState() => _TentangPageState();
}

class _TentangPageState extends State<TentangPage> {
  late YoutubePlayerController _controller;

  String extractVideoId(String url) {
    try {
      return YoutubePlayer.convertUrlToId(url) ?? "";
    } catch (_) {
      return "";
    }
  }

  @override
  void initState() {
    super.initState();

    String link = 'https://www.youtube.com/watch?v=LUa0A8LmKmc';

    final videoId = extractVideoId(link);

    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Tentang Kami"),
        centerTitle: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: kGlobalPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              YoutubePlayer(
                controller: _controller,
                showVideoProgressIndicator: true,
              )
            ],
          ),
        ),
      ),
    );
  }

}