import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart' as ap;

class EffectsScreen extends StatefulWidget {
  @override
  _EffectsScreenState createState() => _EffectsScreenState();
}

class _EffectsScreenState extends State<EffectsScreen> {
  final _effectsPlayer = ap.AudioPlayer(playerId: '12345');
  Map<String, List<dynamic>> _soundEffects = {
    'Nature': [],
    'Instrumental': [],
    'ASMR': [],
  };
  Map<String, String> _filteredEffects = {
    'Nature': 'fire,rain,thunder,waves,birds,forest',
    'Instrumental': 'guitar,piano',
    'Asmr': 'vacuum, fan, cafe',
  };
  Map<String, String> _assetPaths = {
    'fire': 'images/fire.png',
    'rain': 'images/rain.png',
    'thunder': 'images/thunder.png',
    'waves': 'images/waves.png',
    'birds': 'images/birds.png',
    'forest': 'images/forest.png',
    'guitar': 'images/guitar.png',
    'piano': 'images/piano.png',
    'vacuum': 'images/vacuum.png',
    'cafe': 'images/cafe.png',
    'fan': 'images/fan.png',
  };

  String? _playingEffect;

  @override
  void initState() {
    super.initState();
    _fetchSoundEffects();
    _effectsPlayer.setVolume(0.3);
    _effectsPlayer.setReleaseMode(ReleaseMode.loop);
  }

  Future<void> _fetchSoundEffects() async {
    final natureResponse = await http.get(Uri.parse(
        'http://soundscape.boostproductivity.online/api/getSongs/SENature'));
    final instrumentalResponse = await http.get(Uri.parse(
        'http://soundscape.boostproductivity.online/api/getSongs/SEInstrumental'));
    final asmrResponse = await http.get(Uri.parse(
        'http://soundscape.boostproductivity.online/api/getSongs/SEAsmr'));

    setState(() {
      _soundEffects['Nature'] =
          _filterEffects(json.decode(natureResponse.body)['data'], 'Nature');
      _soundEffects['Instrumental'] = _filterEffects(
          json.decode(instrumentalResponse.body)['data'], 'Instrumental');
      _soundEffects['ASMR'] =
          (json.decode(asmrResponse.body)['data'] as List<dynamic>)
              .where((item) => item != null)
              .toList();
    });
  }

  List<dynamic> _filterEffects(List<dynamic> effects, String category) {
    List<String> filters = _filteredEffects[category]!.split(',');
    return effects
        .where((effect) => filters.contains(effect['name'].toLowerCase()))
        .toList();
  }

  void _playEffect(String url, String name) async {
    await _effectsPlayer.play(ap.UrlSource(url));
    setState(() {
      _playingEffect = name;
    });
  }

  void _stopEffect() async {
    await _effectsPlayer.stop();
    setState(() {
      _playingEffect = null;
    });
  }

  Widget _buildSoundEffectButton(String label, String url, String assetPath) {
    return GestureDetector(
      onTap: () => _playEffect(url, label),
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            assetPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSoundEffectSection(String title, List<dynamic> effects) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child:
              Text(title, style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
          children: effects.map<Widget>((effect) {
            String name = effect['name'] ?? 'Unknown';
            String assetPath = _assetPaths[name.toLowerCase()] ?? '';
            return _buildSoundEffectButton(
                name, effect['assetPath'], assetPath);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPlayingEffectWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text('Now Playing',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        ),
        _playingEffect != null
            ? Container(
                child: Column(
                  children: [
                    Image.asset(_assetPaths[_playingEffect!.toLowerCase()]!,
                        fit: BoxFit.cover),
                    IconButton(
                      icon: Icon(Icons.stop, color: Colors.white),
                      onPressed: _stopEffect,
                    ),
                  ],
                ),
              )
            : Container(
                margin: EdgeInsets.all(8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Icon(Icons.music_note, color: Colors.white, size: 50),
                    SizedBox(height: 8),
                    Text('No sound playing',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
      ],
    );
  }

  // @override
  // void dispose() {
  //   _effectsPlayer.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sound Effects')),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPlayingEffectWidget(),
            Expanded(
              child: ListView(
                children: [
                  _buildSoundEffectSection('Nature', _soundEffects['Nature']!),
                  _buildSoundEffectSection(
                      'Instrumental', _soundEffects['Instrumental']!),
                  _buildSoundEffectSection('ASMR', _soundEffects['ASMR']!),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
