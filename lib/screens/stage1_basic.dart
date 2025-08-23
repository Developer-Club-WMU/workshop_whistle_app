import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class Stage1Basic extends StatefulWidget {
  const Stage1Basic({super.key});

  @override
  State<Stage1Basic> createState() => _Stage1BasicState();
}

class _Stage1BasicState extends State<Stage1Basic> {
  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
            "My Whistle", 
            style: TextStyle(color: Colors.white), // Needed to style text however desired
          )
      ),        

      body: Center(
        child: ElevatedButton(
          onPressed: _playWhistle, // Runs the _playWhistle function to play the whistle sound
          style: ElevatedButton.styleFrom( //To style the button however desired
            shape: const CircleBorder(), // Makes the button a circle
            padding: const EdgeInsets.all(48), // controls circle size
            backgroundColor: Colors.lightGreenAccent
          ),
          child: const Icon(Icons.volume_up, size: 100, color: Colors.black,), // To place an icon image in the button
        ),
      ),
    );
  }

  Future<void> _playWhistle() async {
    await _player.stop(); // Stops any already playing sounds
    await _player.setVolume(1);
    await _player.play(AssetSource("sounds/referee_whistle.mp3"));
  }
}