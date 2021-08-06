import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class VoicePlayer extends StatefulWidget {
  const VoicePlayer({Key key, this.voice, this.player}) : super(key: key);
  final String voice;
  final AudioPlayer player;

  @override
  _VoicePlayerState createState() => _VoicePlayerState();
}

class _VoicePlayerState extends State<VoicePlayer> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    widget.player.setUrl('https://tadawl-store.com/API/assets/voices/${widget.voice}', preload: false);
  }

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
            widget.player.duration != null
                ?
            widget.player.duration.inSeconds < 10 ?
            widget.player.duration.inMinutes < 10 ?
            Text('0${widget.player.duration.inMinutes}:0${widget.player.duration.inSeconds}') :
            Text('${widget.player.duration.inMinutes}:${widget.player.duration.inSeconds}') :
            Text('0${widget.player.duration.inMinutes}:${widget.player.duration.inSeconds}')
                :
            Text(''),
            _isLoading
                ?
            Container(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(),
            )
                :
            widget.player.playing
                ?
            IconButton(
              icon: Icon(Icons.pause),
              padding: EdgeInsets.only(bottom: 10.0),
              onPressed: (){
                setState(() {
                  widget.player.pause();
                });
              },
            )
                :
            IconButton(
              icon: Icon(Icons.play_arrow),
              padding: EdgeInsets.only(bottom: 10.0),
              onPressed: (){
                setState(() {
                  _isLoading = true;
                });
                widget.player.setUrl('https://tadawl-store.com/API/assets/voices/${widget.voice}', preload: false).then((value) {
                  setState(() {
                    _isLoading = false;
                    widget.player.play().then((value) {
                      setState(() {
                        widget.player.stop();
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
