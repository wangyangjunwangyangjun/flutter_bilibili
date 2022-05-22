import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/extension/int_extension.dart';

class BilibiliFijkPanel extends StatefulWidget {
  final FijkPlayer player;
  final BuildContext buildContext;
  final Size viewSize;
  final Rect texturePos;

  const BilibiliFijkPanel(
      {required this.player,
      required this.buildContext,
      required this.viewSize,
      required this.texturePos});

  @override
  State<BilibiliFijkPanel> createState() => _BilibiliFijkPanelState();
}

String _duration2String(Duration duration) {
  if (duration.inMilliseconds < 0) return "-: negtive";

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  int inHours = duration.inHours;
  return inHours > 0
      ? "$inHours:$twoDigitMinutes:$twoDigitSeconds"
      : "$twoDigitMinutes:$twoDigitSeconds";
}

class _BilibiliFijkPanelState extends State<BilibiliFijkPanel> {
  FijkPlayer get player => widget.player;

  Duration _duration = Duration();
  Duration _currentPos = Duration();
  Duration _bufferPos = Duration();

  bool _playing = false;
  bool _prepared = false;
  String? _exception;

  double _seekPos = -1.0;

  StreamSubscription? _currentPosSubs;

  StreamSubscription? _bufferPosSubs;

  //StreamSubscription _bufferingSubs;

  Timer? _hideTimer;
  bool _hideStuff = true;

  double _volume = 1.0;

  final barHeight = 40.0;

  @override
  void initState() {
    super.initState();
    _duration = player.value.duration;
    _currentPos = player.currentPos;
    _bufferPos = player.bufferPos;
    _prepared = player.state.index >= FijkState.prepared.index;
    _playing = player.state == FijkState.started;
    _exception = player.value.exception.message;
    // _buffering = player.isBuffering;

    player.addListener(_playerValueChanged);

    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {
      setState(() {
        _currentPos = v;
      });
    });

    _bufferPosSubs = player.onBufferPosUpdate.listen((v) {
      setState(() {
        _bufferPos = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Rect rect = player.value.fullScreen
        ? Rect.fromLTWH(0, 0, widget.viewSize.width, widget.viewSize.height)
        : Rect.fromLTRB(
            max(0.0, widget.texturePos.left),
            max(0.0, widget.texturePos.top),
            min(widget.viewSize.width, widget.texturePos.right),
            min(widget.viewSize.height, widget.texturePos.bottom));
    return Positioned.fromRect(
      rect: rect,
      child: GestureDetector(
        onTap: _cancelAndRestartTimer,
        child: AbsorbPointer(
          absorbing: _hideStuff,
          child: Column(
            children: <Widget>[
              Container(height: barHeight),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _cancelAndRestartTimer();
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: double.infinity,
                    width: double.infinity,
                    child: Center(
                        child: _exception != null
                            ? Text(
                                _exception!,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.px,
                                ),
                              )
                            : (_prepared ||
                                    player.state == FijkState.initialized)
                                ? GestureDetector(
                                    child: Center(
                                      child: _playing
                                          ? const Center()
                                          : Image.asset(
                                              "assets/image/icon/play_video_custom.png",
                                              width: 40.px,
                                              height: 40.px,
                                            ),
                                    ),
                                    onTap: _playOrPause,
                                  )
                                : SizedBox(
                                    width: barHeight * 1.5,
                                    height: barHeight * 1.5,
                                    child: CircularProgressIndicator(
                                        valueColor: AlwaysStoppedAnimation(
                                            Colors.white)),
                                  )),
                  ),
                ),
              ),
              _buildBottomBar(context),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _hideTimer?.cancel();

    player.removeListener(_playerValueChanged);
    _currentPosSubs?.cancel();
    _bufferPosSubs?.cancel();
  }

  void _playerValueChanged() {
    FijkValue value = player.value;

    if (value.duration != _duration) {
      setState(() {
        _duration = value.duration;
      });
    }

    bool playing = (value.state == FijkState.started);

    bool prepared = value.prepared;
    String? exception = value.exception.message;
    if (playing != _playing ||
        prepared != _prepared ||
        exception != _exception) {
      setState(() {
        _playing = playing;
        _prepared = prepared;
        _exception = exception;
      });
    }
  }

  void _playOrPause() {
    if (_playing == true) {
      player.pause();
    } else {
      player.start();
    }
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _hideStuff = true;
      });
    });
  }

  void _cancelAndRestartTimer() {
    if (_hideStuff == true) {
      _startHideTimer();
    }
    setState(() {
      _hideStuff = !_hideStuff;
    });
  }

  AnimatedOpacity _buildBottomBar(BuildContext context) {
    double duration = _duration.inMilliseconds.toDouble();
    double currentValue =
        _seekPos > 0 ? _seekPos : _currentPos.inMilliseconds.toDouble();
    currentValue = min(currentValue, duration);
    currentValue = max(currentValue, 0);
    return AnimatedOpacity(
      opacity: _hideStuff ? 0.0 : 0.8,
      duration: Duration(milliseconds: 400),
      child: Container(
        height: barHeight,
        color: Colors.transparent,
        child: Row(
          children: <Widget>[
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(left: 8.px),
                child: Icon(
                  _playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                  color: Colors.white,
                  size: 40.px,
                ),
              ),
              onTap: _playOrPause,
            ),
            _duration.inMilliseconds == 0
                ? Expanded(child: Center())
                : Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 12.px, right: 8.px),
                      child: FijkSlider(
                        colors: FijkSliderColors(
                          playedColor: Color.fromRGBO(253, 105, 155, 1),
                          bufferedColor: Color.fromRGBO(209, 214, 214, 1),
                          baselineColor: Color.fromRGBO(141, 148, 156, 1),
                          cursorColor: Color.fromRGBO(253, 105, 155, 1),
                        ),
                        value: currentValue,
                        cacheValue: _bufferPos.inMilliseconds.toDouble(),
                        min: 0.0,
                        max: duration,
                        onChanged: (v) {
                          _startHideTimer();
                          setState(() {
                            _seekPos = v;
                          });
                        },
                        onChangeEnd: (v) {
                          setState(() {
                            player.seekTo(v.toInt());
                            _currentPos =
                                Duration(milliseconds: _seekPos.toInt());
                            _seekPos = -1;
                          });
                        },
                      ),
                    ),
                  ),

            // duration / position
            _duration.inMilliseconds == 0
                ? Container(child: const Text("LIVE"))
                : Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5.px),
                        child: Text(
                          '${_duration2String(_currentPos)}/',
                          style: TextStyle(fontSize: 14.0, color: Colors.white),
                        ),
                      ),
                      Text(
                        '${_duration2String(_duration)}',
                        style: TextStyle(fontSize: 14.0, color: Colors.white),
                      ),
                    ],
                  ),

            IconButton(
              icon: widget.player.value.fullScreen
                  ? Icon(
                      Icons.fullscreen_exit,
                      size: 25.px,
                    )
                  : Image.asset(
                      "assets/image/icon/full_custom.png",
                      width: 16.px,
                      height: 16.px,
                    ),
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
//              color: Colors.transparent,
              onPressed: () {
                widget.player.value.fullScreen
                    ? player.exitFullScreen()
                    : player.enterFullScreen();
              },
            )
            //
          ],
        ),
      ),
    );
  }
}
