import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'reward_screen.dart';

class AudioPlayerScreen extends StatefulWidget {
  final String songName;
  final int xpEarned;

  const AudioPlayerScreen({
    super.key,
    required this.songName,
    required this.xpEarned,
  });

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _player = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  double _volume = 0.7;

  @override
  void initState() {
    super.initState();

    _player.onDurationChanged.listen((d) {
      setState(() => _duration = d);
    });

    _player.onPositionChanged.listen((p) {
      setState(() => _position = p);
    });

    _player.onPlayerComplete.listen((event) {
      setState(() => _isPlaying = false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RewardScreen(
            questName: widget.songName,
            xpEarned: widget.xpEarned,
            totalXp: 250 + widget.xpEarned, // placeholder — replace with real running total later
          ),
        ),
      );
  });

    _loadAndPlay();
  }

  Future<void> _loadAndPlay() async {
    await _player.setSourceAsset("audio/success.mp3");
    await _player.resume();
    setState(() => _isPlaying = true);
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _player.pause();
    } else {
      await _player.resume();
    }
    setState(() => _isPlaying = !_isPlaying);
  }

  String _formatTime(Duration d) {
    final minutes = d.inMinutes.toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audio Playing"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // ---------- CENTER: waveform bars + circle ----------
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _waveBars(reverse: true),
                      const SizedBox(width: 12),

                      // big purple circle with music icon
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepPurple.shade50,
                        ),
                        child: Icon(
                          Icons.music_note,
                          size: 60,
                          color: Colors.deepPurple.shade400,
                        ),
                      ),

                      const SizedBox(width: 12),
                      _waveBars(reverse: false),
                    ],
                  ),
                ),
              ),

              // ---------- Song name ----------
              Text(
                widget.songName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "${_formatTime(_position)} / ${_formatTime(_duration)}",
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
              const SizedBox(height: 10),

              // ---------- Progress loader ----------
              Slider(
                value: _position.inSeconds.toDouble().clamp(
                  0,
                  _duration.inSeconds.toDouble() == 0 ? 1 : _duration.inSeconds.toDouble(),
                ),
                max: _duration.inSeconds.toDouble() == 0 ? 1 : _duration.inSeconds.toDouble(),
                activeColor: Colors.deepPurple,
                inactiveColor: Colors.deepPurple.shade50,
                onChanged: (value) async {
                  await _player.seek(Duration(seconds: value.toInt()));
                },
              ),

              const SizedBox(height: 10),

              // ---------- Controls: prev / play / next ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, color: Colors.deepPurple, size: 36),
                    onPressed: () {
                      // TODO: previous track logic
                    },
                  ),
                  const SizedBox(width: 20),
                  GestureDetector(
                    onTap: _togglePlay,
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.deepPurple,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.skip_next, color: Colors.deepPurple, size: 36),
                    onPressed: () {
                      // TODO: next track logic
                    },
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ---------- Volume slider ----------
              Row(
                children: [
                  const Icon(Icons.volume_off, color: Colors.grey, size: 20),
                  Expanded(
                    child: Slider(
                      value: _volume,
                      activeColor: Colors.deepPurple,
                      inactiveColor: Colors.deepPurple.shade50,
                      onChanged: (value) {
                        setState(() => _volume = value);
                        _player.setVolume(value);
                      },
                    ),
                  ),
                  const Icon(Icons.volume_up, color: Colors.deepPurple, size: 20),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // helper: builds the "l l l l" wave bars, growing toward the center circle
  Widget _waveBars({required bool reverse}) {
    final heights = [10.0, 20.0, 35.0, 50.0];
    final bars = heights.map((h) {
      return Container(
        width: 4,
        height: h,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: Colors.deepPurple.shade200,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }).toList();

    return Row(
      children: reverse ? bars.reversed.toList() : bars,
    );
  }
}