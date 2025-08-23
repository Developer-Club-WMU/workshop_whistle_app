import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class Stage2Multiple extends StatefulWidget {
  const Stage2Multiple({super.key});

  @override
  State<Stage2Multiple> createState() => _Stage2MultipleState();
}

class _Stage2MultipleState extends State<Stage2Multiple> {
  final _player = AudioPlayer();

  // The sounds and colors are seperated to allow them to be switched out when needed
  String currentSound = "sounds/referee_whistle.mp3";
  Color currentColor = Colors.lightGreenAccent;

  final List<Map<String, dynamic>> sounds = [
    {
      "label": "Whistle",
      "asset": "sounds/referee_whistle.mp3",
      "color": Colors.lightGreenAccent,
    },
    {
      "label": "Buzzer",
      "asset": "sounds/buzzer.mp3",
      "color": Colors.lightBlueAccent,
    },
    {
      "label": "Funny Cat Sound",
      "asset": "sounds/funny_cat_sound.mp3",
      "color": Colors.orangeAccent,
    },
  ];

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Same as stage 1
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
            "My Sounds", // Changed to represent the ability to play multiple sounds
            style: TextStyle(color: Colors.white), 
          )
      ),        

      body: Center(
        // Put contents into a column to stack the main button and the sound selection row
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            
            ElevatedButton(
              onPressed: playSound, 
              style: ElevatedButton.styleFrom( 
                shape: const CircleBorder(), 
                padding: const EdgeInsets.all(48), 
                backgroundColor: currentColor // Changed to dynamically change background based on the sound
              ),
              child: const Icon(Icons.volume_up, size: 100, color: Colors.black,), 
            ),

            SizedBox(height: 64), // Adds an invisible box between the main button and selection buttons for visual sake

            // Used to create and display each sound selection button in a single scrollable row
            SizedBox( 
              height: 128, // Give the ListView a set height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16), // Give space between the edge of the screen and the buttons

                itemCount: sounds.length,
                itemBuilder: (context, index) {
                  final item = sounds[index];    
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 12), // Add Space between the buttons

                    child: ChangeSoundButton(
                      label: item["label"],
                      color: item["color"],
                      onTap: () => selectSound(
                        item["asset"],
                        item["color"]
                      )
                    ),
                  );  
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> playSound() async { // Changed to playSound since multiple sounds can be played now
    await _player.stop();
    await _player.setVolume(1);
    await _player.play(AssetSource(currentSound)); // Changed to play the currently selected sound
  }

  void selectSound(String asset, Color color) {
    setState(() {
      currentSound = asset;
      currentColor = color;
    });
  }
}

// Used to create reuseable sound selection buttons by only passing the information that would change between them
class ChangeSoundButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onTap;

  const ChangeSoundButton({
    super.key,
    required this.label,
    required this.color,
    required this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128, //make each button square by making the width set the same as the height

      child: ElevatedButton(
        onPressed: onTap, 

        style: ElevatedButton.styleFrom( 
          shape:  BeveledRectangleBorder( // To make the button square
            side: BorderSide(color: Colors.black26, width: 2) // To add the dark edges to the buttons
          ), 
          padding: EdgeInsets.all(4), // To give the text in the button as much room as possible while looking decent
          backgroundColor: color
        ),

        child: Text(
          label, 
          style: TextStyle(fontSize: 20, color: Colors.black, overflow: TextOverflow.ellipsis),
          ), 
      ),
    );
  }
}