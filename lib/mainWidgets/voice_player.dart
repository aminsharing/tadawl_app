import 'dart:io';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

class VoicePlayer extends StatefulWidget {
  VoicePlayer({
    Key? key,
    this.voice,
    this.duration,
    this.isLocal,
  }) : super(key: key);
  final String? voice;
  final int? duration;
  final bool? isLocal;


  @override
  _VoicePlayerState createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer> {
  final AudioPlayer _player = AudioPlayer();
  bool _isLoading = false;

  Future<void> getVoicesFromUrl() async{

    // ignore: omit_local_variable_types
    Directory temp = await getTemporaryDirectory();
    // ignore: omit_local_variable_types
    Directory tempPath = Directory(temp.path + '/voiceChat');
    if(!await tempPath.exists()){
      await tempPath.create(recursive: true);
    }
    // ignore: omit_local_variable_types
    File file = File('${tempPath.path}/${widget.voice}');
    // ignore: omit_local_variable_types
    http.Response response = await http.get(Uri.parse('https://tadawl-store.com/API/assets/voices/${widget.voice}'));

    try{
      await file.writeAsBytes(response.bodyBytes);
    }catch(e){
      print('File write error: $e');
    }
  }
  
  Future<void> initVoice() async{
    // ignore: omit_local_variable_types
    Directory temp = await getTemporaryDirectory();
    // ignore: omit_local_variable_types
    Directory tempPath = Directory(temp.path + '/voiceChat');

    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          print('A stream error occurred: $e');
        });
    try {
      await _player.setFilePath('${tempPath.path}/${widget.voice}');
    } catch (e) {
      print('Error loading audio source: $e');
    }
  }

  @override
  void initState(){
    getVoicesFromUrl().then((value) {
      initVoice();
    });
    super.initState();
  }



  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest2<Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.durationStream,
              (position, duration) => PositionData(
              position, duration ?? Duration.zero));

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: 20.0,
      width: mediaQuery.size.width*.5,
      child: Align(
        alignment: Alignment.topLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StreamBuilder<PositionData>(
              stream: _positionDataStream,
              builder: (context, snapshot) {
                // ignore: omit_local_variable_types
                Duration _remaining = Duration.zero;
                if(snapshot.hasData){
                  _remaining = snapshot.data!.duration - snapshot.data!.position;
                }
                return _player.playing
                    ?
                  _remaining == Duration.zero
                    ?
                    Text('')
                    :
                Text(RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch('$_remaining')?.group(1) ?? '$_remaining')
                    :
                widget.duration == 0
                    ?
                Text('')
                    :
                Text(RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$').firstMatch('${Duration(seconds: widget.duration!)}')?.group(1) ?? '');
              }
            ),
            _isLoading
                ?
            Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(),
            )
                :
            _player.playing
                ?
            IconButton(
              icon: Icon(Icons.pause),
              padding: EdgeInsets.only(bottom: 10.0),
              onPressed: (){
                setState(() {
                  _player.pause();
                });
              },
            )
                :
            IconButton(
              icon: Icon(Icons.play_arrow),
              padding: EdgeInsets.only(bottom: 10.0),
              onPressed: () async{
                setState(() {
                  _isLoading = true;
                });
                // ignore: omit_local_variable_types
                Directory temp = await getTemporaryDirectory();
                // ignore: omit_local_variable_types
                String tempPath = Directory(temp.path + '/voiceChat/').path;
                await _player.setFilePath('$tempPath''${widget.voice}', preload: false).then((value) {
                  setState(() {
                    _isLoading = false;
                    if(_player.playing){
                      setState(() {
                        _player.stop();
                      });
                    }
                    _player.play().then((value) {
                      setState(() {
                        _player.stop();
                      });
                    });
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
class PositionData {
  PositionData(this.position, this.duration);

  final Duration position;
  final Duration duration;
}