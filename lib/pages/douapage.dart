import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:audio_session/audio_session.dart'; // For managing audio focus and interruptions
import 'package:yaqeen/model/prayer.dart'; // Adjust the import path accordingly

class PrayerDetailPage extends StatefulWidget {
  final Prayer prayer;

  const PrayerDetailPage({super.key, required this.prayer});

  @override
  PrayerDetailPageState createState() => PrayerDetailPageState();
}

class PrayerDetailPageState extends State<PrayerDetailPage> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _setupAudio();
  }

  Future<void> _setupAudio() async {
    _audioPlayer = AudioPlayer();

    // Initialize the audio session
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());

    // Handle interruptions and focus changes
    session.becomingNoisyEventStream.listen((_) {
      if (isPlaying) {
        _togglePlayPause();
      }
    });

    // Listen to duration and position changes
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });

    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _togglePlayPause() async {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      await _audioPlayer.setUrl(widget.prayer.audioUrl);
      await _audioPlayer.play();
    } else {
      await _audioPlayer.pause();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffffBDA),
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            widget.prayer.title,
            style: const TextStyle(
              fontSize: 20,
              fontFamily: "ReadexPro",
              color: Color(0xFFFFD90E),
            ),
          ),
        ),
        backgroundColor: const Color(0xFF4F6A42),
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Slider(
                            thumbColor: const Color(0xFF4F6A42),
                            min: 0.0,
                            max: _duration.inSeconds.toDouble(),
                            value: _position.inSeconds <= _duration.inSeconds
                                ? _position.inSeconds.toDouble()
                                : 0.0,
                            onChanged: (value) async {
                              final newPosition =
                                  Duration(seconds: value.toInt());
                              await _audioPlayer.seek(newPosition);
                              setState(() {
                                _position = newPosition;
                              });
                            },
                            activeColor: const Color(0xFF4F6A42),
                            inactiveColor: const Color(0xFFD3D3D3),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDuration(_position),
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontFamily: "ReadexPro",
                                  color: Color(0xFF4F6A42),
                                ),
                              ),
                              Text(
                                _formatDuration(_duration),
                                style: const TextStyle(
                                  fontSize: 9,
                                  fontFamily: "ReadexPro",
                                  color: Color(0xFF4F6A42),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 4),
                    IconButton(
                      onPressed: _togglePlayPause,
                      icon: Icon(
                        isPlaying ? Icons.pause : Icons.play_arrow,
                        color: const Color(0xFF4F6A42),
                        size: 40.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(
                  color: Color(0xFF4F6A42),
                  thickness: 2.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.person,
                      color: Color(0xFFFFD90E),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.prayer.speaker,
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "ReadexPro",
                        color: Color(0xFF4F6A42),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Color(0xFF4F6A42),
                  thickness: 2.0,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.prayer.description,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: "ReadexPro",
                    color: Color(0xFF4F6A42),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
