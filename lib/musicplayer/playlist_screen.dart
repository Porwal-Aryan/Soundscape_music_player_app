import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:soundscape/musicplayer/effects_screen.dart';

class PlaylistScreen extends StatefulWidget {
  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final _player = AudioPlayer();
  List<dynamic> _songs = [];
  bool _isPlaying = false;
  bool _isLooping = false;
  int? _currentSongIndex;
  Duration _songDuration = Duration.zero;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();

    _fetchSongs();

    // Listen to changes in the player's position and duration
    _player.positionStream.listen((position) {
      setState(() {
        _currentPosition = position;
      });
    });

    _player.durationStream.listen((duration) {
      setState(() {
        _songDuration = duration ?? Duration.zero;
      });
    });

    // Update the current song index when the player changes the song
    _player.currentIndexStream.listen((index) {
      setState(() {
        _currentSongIndex = index;
      });
    });
  }

  Future<void> _fetchSongs() async {
    final response = await http.get(Uri.parse(
        'http://soundscape.boostproductivity.online/api/getSongs/tired'));
    if (response.statusCode == 200) {
      setState(() {
        _songs = json.decode(response.body)['data'];
      });
    } else {
      throw Exception('Failed to load songs');
    }
  }

  void _playAll() {
    final audioSources = _songs
        .map((song) => AudioSource.uri(
              Uri.parse(song['assetPath']),
              tag: MediaItem(
                id: song['assetPath'],
                album: "Tired Playlist",
                title: song['name'],
                artist: "Unknown Artist",
                artUri: Uri.parse('images/top_image.png'),
              ),
            ))
        .toList();

    _player.setAudioSource(ConcatenatingAudioSource(children: audioSources));
    _player.setLoopMode(LoopMode.all);
    _player.play();
    setState(() {
      _isPlaying = true;
      _currentSongIndex = 0;
    });
  }

  void _shuffle() {
    _songs.shuffle();
    _playAll();
  }

  void _toggleLoop() {
    setState(() {
      _isLooping = !_isLooping;
    });
    _player.setLoopMode(_isLooping ? LoopMode.one : LoopMode.all);
  }

  void _playPause() {
    if (_player.playing) {
      _player.pause();
    } else {
      _player.play();
    }
    setState(() {
      _isPlaying = _player.playing;
    });
  }

  void _playSong(int index) {
    final song = _songs[index];
    _player
        .setAudioSource(
          AudioSource.uri(
            Uri.parse(song['assetPath']),
            tag: MediaItem(
              id: song['assetPath'],
              album: "Tired Playlist",
              title: song['name'],
            ),
          ),
        )
        .then((_) => _player.play());
    setState(() {
      _isPlaying = true;
      _currentSongIndex = index;
    });
  }

  void _seekToPrevious() {
    if (_currentSongIndex != null && _currentSongIndex! > 0) {
      _playSong(_currentSongIndex! - 1);
    }
  }

  void _seekToNext() {
    if (_currentSongIndex != null && _currentSongIndex! < _songs.length - 1) {
      _playSong(_currentSongIndex! + 1);
    }
  }

  void _seekToPosition(Duration position) {
    _player.seek(position);
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
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.transparent,
              ),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'finalPage');
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Image.asset(
            'images/top_image.png',
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.black54,
                  ),
                  onPressed: _playAll,
                  child: Row(
                    children: [
                      Icon(Icons.play_arrow, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Play all',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.white),
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    backgroundColor: Colors.black54,
                  ),
                  onPressed: _shuffle,
                  child: Row(
                    children: [
                      Icon(Icons.shuffle, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Shuffle',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_songs[index]['name'],
                      style: TextStyle(color: Colors.white)),
                  onTap: () => _playSong(index),
                );
              },
            ),
          ),
          Container(
            color: Colors.black54,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _currentSongIndex != null
                                ? _songs[_currentSongIndex!]['name']
                                : '-----',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          Text(
                            'Tired playlist',
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.skip_previous, color: Colors.white),
                          onPressed: _seekToPrevious,
                        ),
                        IconButton(
                          icon: Icon(
                              _isPlaying ? Icons.pause : Icons.play_arrow,
                              color: Colors.white),
                          onPressed: _playPause,
                        ),
                        IconButton(
                          icon: Icon(Icons.skip_next, color: Colors.white),
                          onPressed: _seekToNext,
                        ),
                        IconButton(
                          icon: Icon(Icons.repeat,
                              color: _isLooping ? Colors.blue : Colors.white),
                          onPressed: _toggleLoop,
                        ),
                        IconButton(
                          icon: Image.asset(
                              'images/arcticons_soothing-noise-player.png'), // Custom icon
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EffectsScreen()));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                Slider(
                  value: _currentPosition.inSeconds.toDouble(),
                  min: 0,
                  max: _songDuration.inSeconds.toDouble(),
                  onChanged: (value) {
                    _seekToPosition(Duration(seconds: value.toInt()));
                  },
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
