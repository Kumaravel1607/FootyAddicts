import 'package:flutter/material.dart';
import 'package:footyaddicts/constant/sharedpreference.dart';
// import 'package:footyaddicts/provider/google_signin.dart';
import 'package:footyaddicts/splash.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
  await SharedPreference.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
        // ChangeNotifierProvider(
        //   create: (context) => GoogleSignInProvider(),
        //   child:
        MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.blueGrey,
        primarySwatch: Colors.blue,
        // fontFamily: 'Montserrat',
        textTheme: TextTheme(),
      ),
      home: SplashScreen(),
      // home: Location()
      // home: AddPage_02(),
      // home: LogScreen(),
      // ),
    );
  }
}






import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    String path = join(await getDatabasesPath(), 'video_watch.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id TEXT UNIQUE
          )
        ''');
        await db.execute('''
          CREATE TABLE watch_times(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            user_id INTEGER,
            video_path TEXT,
            watch_time INTEGER,
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
    );
  }

  Future<void> insertUser(String userId) async {
    final db = await database;
    await db.insert(
      'users',
      {'user_id': userId},
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int?> getUserId(String userId) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    if (result.isNotEmpty) {
      return result.first['id'] as int?;
    } else {
      return null;
    }
  }

  Future<void> insertWatchTime(int userId, String videoPath, int watchTime) async {
    final db = await database;
    await db.insert(
      'watch_times',
      {'user_id': userId, 'video_path': videoPath, 'watch_time': watchTime},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> getWatchTime(int userId, String videoPath) async {
    final db = await database;
    final result = await db.query(
      'watch_times',
      where: 'user_id = ? AND video_path = ?',
      whereArgs: [userId, videoPath],
    );
    if (result.isNotEmpty) {
      return result.first['watch_time'] as int;
    } else {
      return 0;
    }
  }
}





import 'package:flutter/material.dart';
import 'package:your_app/database_helper.dart';
import 'video_player_screen.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select User')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper().insertUser('user1');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(userId: 'user1'),
                  ),
                );
              },
              child: Text('User 1'),
            ),
            ElevatedButton(
              onPressed: () async {
                await DatabaseHelper().insertUser('user2');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VideoPlayerScreen(userId: 'user2'),
                  ),
                );
              },
              child: Text('User 2'),
            ),
          ],
        ),
      ),
    );
  }
}




import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:your_app/database_helper.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String userId;

  VideoPlayerScreen({required this.userId});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  int _lastPosition = 0;
  int _watchTime = 0;
  int _videoDuration = 0;
  int _maxWatchTime = 0;
  int? _userId;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() async {
    _userId = await DatabaseHelper().getUserId(widget.userId);
    if (_userId != null) {
      _loadLastPosition();
      _controller = VideoPlayerController.asset('assets/video.mp4')
        ..initialize().then((_) {
          setState(() {
            _videoDuration = _controller.value.duration.inMilliseconds;
            _maxWatchTime = _videoDuration * 2;
          });
          _showWatchedTimeMessage();
        });
    }
  }

  void _loadLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _lastPosition = prefs.getInt('${widget.userId}_lastPosition') ?? 0;
    });
  }

  void _saveLastPosition() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('${widget.userId}_lastPosition', _controller.value.position.inMilliseconds);
  }

  void _loadWatchTime() async {
    if (_userId != null) {
      _watchTime = await DatabaseHelper().getWatchTime(_userId!, 'video.mp4');
      if (_watchTime < _maxWatchTime) {
        _controller.seekTo(Duration(milliseconds: _lastPosition));
        _controller.play();
      } else {
        _showWatchLimitReachedDialog();
      }
    }
  }

  void _saveWatchTime() async {
    if (_userId != null) {
      await DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', _watchTime);
    }
  }

  void _showWatchLimitReachedDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Watch Limit Reached'),
        content: Text('You have reached the maximum watch limit for this video.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showWatchedTimeMessage() async {
    final prefs = await SharedPreferences.getInstance();
    final lastWatched = prefs.getInt('${widget.userId}_lastPosition') ?? 0;

    if (lastWatched > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Welcome Back'),
          content: Text('You have watched ${_formatDuration(Duration(milliseconds: lastWatched))} of ${_formatDuration(_controller.value.duration)}.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _loadWatchTime();
              },
              child: Text('Continue Watching'),
            ),
          ],
        ),
      );
    } else {
      _loadWatchTime();
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  void dispose() {
    _saveLastPosition();
    _saveWatchTime();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              )
            : CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              if (_watchTime < _maxWatchTime) {
                _controller.play();
                _watchTime += 1000; // Increment watch time by 1 second
              } else {
                _showWatchLimitReachedDialog();
              }
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }
}




//MainActivity.kt

package com.example.yourapp

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        window.setFlags(
            android.view.WindowManager.LayoutParams.FLAG_SECURE,
            android.view.WindowManager.LayoutParams.FLAG_SECURE
        )
    }
}


//MainActivity.java

package com.example.yourapp;

import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().setFlags(
            android.view.WindowManager.LayoutParams.FLAG_SECURE,
            android.view.WindowManager.LayoutParams.FLAG_SECURE
        );
    }
}
