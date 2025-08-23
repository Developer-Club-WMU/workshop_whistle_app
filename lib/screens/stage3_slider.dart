import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class Stage3Slider extends StatefulWidget {
  const Stage3Slider({super.key});

  @override
  State<Stage3Slider> createState() => _Stage3SliderState();
}

class _Stage3SliderState extends State<Stage3Slider> {
  final _player = AudioPlayer();

  String currentSound = "sounds/referee_whistle.mp3";
  Color currentColor = Colors.lightGreenAccent;
  // Used to change the volume
  double volume = 1.0;

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
      // Same as stage 2
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
            "My Sounds", 
            style: TextStyle(color: Colors.white), 
          )
      ),        

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            
            // Same as stage 2
            ElevatedButton(
              onPressed: playSound, 
              style: ElevatedButton.styleFrom( 
                shape: const CircleBorder(), 
                padding: const EdgeInsets.all(48), 
                backgroundColor: currentColor 
              ),
              child: const Icon(Icons.volume_up, size: 100, color: Colors.black,), 
            ),

            SizedBox(height: 12),

            // Used to change the volume of the played sound
            Slider(
              value: volume,             
              min: 0.0,                    
              max: 1.0,                  
              divisions: 10, // Sets the amount of steps the volume can increment by  
              activeColor: Colors.black,

              label: (volume * 100).round().toString(), // Shows the percentage of teh current volume
              onChanged: (newValue) {
                setState(() {
                  volume = newValue;
                  _player.setVolume(newValue); // Change the volume while the sound is playing
                });
              }
            ),
            // To label the volume bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("0", style: TextStyle(fontSize: 20, color: Colors.black),),
                  const Text("Volume", style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold ),),
                  const Text("100", style: TextStyle(fontSize: 20, color: Colors.black),),
                ],
              ),
            ),
            
            SizedBox(height: 64),

            // Same as stage 2
            SizedBox( 
              height: 128, 
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16), 

                itemCount: sounds.length,
                itemBuilder: (context, index) {
                  final item = sounds[index];    
                  
                  return Padding(
                    padding: const EdgeInsets.only(right: 12), 

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

  Future<void> playSound() async {
    await _player.stop();
    await _player.setVolume(volume); // Changed to play the set volume determined by the slider
    await _player.play(AssetSource(currentSound)); 
  }

  // Same as stage 2
  void selectSound(String asset, Color color) {
    setState(() {
      currentSound = asset;
      currentColor = color;
    });
  }
}

// Same as stage 2
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
      width: 128, 

      child: ElevatedButton(
        onPressed: onTap, 

        style: ElevatedButton.styleFrom( 
          shape:  BeveledRectangleBorder( 
            side: BorderSide(color: Colors.black26, width: 2)
          ), 
          padding: EdgeInsets.all(4),
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