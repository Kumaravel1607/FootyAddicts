Along with this set a date to expiry the video using the exact date we loaclly saved in db 

If the date and time we stored in db is matched correctly then only show a message of your video was expired text while the users go for play the video 





In this calulate the total timing of video while fully watched
If the total timing of video is reached multiples of 2 
It's means the user watched the video 2times only fully video watched
Then go for 3rd time block the user with warning message u have reached the watch limit message

When Totaal video is fully played then one count is completed


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
  int _totalWatchTime = 0;
  int _videoDuration = 0;
  int? _userId;
  int _viewCount = 0;

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
          });
          _showWatchedTimeMessage();
        })
        ..addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _handleVideoCompleted();
          }
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

  void _loadWatchData() async {
    if (_userId != null) {
      final watchData = await DatabaseHelper().getWatchData(_userId!, 'video.mp4');
      if (watchData != null) {
        _watchTime = watchData['watch_time'] as int;
        _totalWatchTime = watchData['total_watch_time'] as int;
        _viewCount = watchData['view_count'] as int;
        if (_viewCount < 2) {
          _controller.seekTo(Duration(milliseconds: _lastPosition));
          _controller.play();
        } else {
          _showWatchLimitReachedDialog();
        }
      } else {
        DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', 0, 0, 0);
      }
    }
  }

  void _saveWatchData() async {
    if (_userId != null) {
      await DatabaseHelper().updateWatchTime(_userId!, 'video.mp4', _watchTime);
    }
  }

  void _handleVideoCompleted() async {
    if (_userId != null) {
      _incrementViewCount();
      _updateTotalWatchTime(_videoDuration);
    }
  }

  void _incrementViewCount() async {
    if (_userId != null) {
      setState(() {
        _viewCount++;
      });
      await DatabaseHelper().incrementViewCount(_userId!, 'video.mp4');
    }
  }

  void _updateTotalWatchTime(int watchTime) async {
    if (_userId != null) {
      setState(() {
        _totalWatchTime += watchTime;
      });
      await DatabaseHelper().updateTotalWatchTime(_userId!, 'video.mp4', watchTime);
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
                _loadWatchData();
              },
              child: Text('Continue Watching'),
            ),
          ],
        ),
      );
    } else {
      _loadWatchData();
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
    _updateTotalWatchTime(_controller.value.position.inMilliseconds - _lastPosition);
    _saveWatchData();
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
              _updateTotalWatchTime(_controller.value.position.inMilliseconds - _lastPosition);
              _saveWatchData();
            } else {
              if (_viewCount < 2) {
                _controller.play();
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
      version: 2,
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
            total_watch_time INTEGER DEFAULT 0,
            view_count INTEGER DEFAULT 0,
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE watch_times
            ADD COLUMN total_watch_time INTEGER DEFAULT 0
          ''');
        }
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

  Future<void> insertWatchTime(int userId, String videoPath, int watchTime, int totalWatchTime, int viewCount) async {
    final db = await database;
    await db.insert(
      'watch_times',
      {'user_id': userId, 'video_path': videoPath, 'watch_time': watchTime, 'total_watch_time': totalWatchTime, 'view_count': viewCount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getWatchData(int userId, String videoPath) async {
    final db = await database;
    final result = await db.query(
      'watch_times',
      where: 'user_id = ? AND video_path = ?',
      whereArgs: [userId, videoPath],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> incrementViewCount(int userId, String videoPath) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET view_count = view_count + 1
      WHERE user_id = ? AND video_path = ?
    ''', [userId, videoPath]);
  }

  Future<void> updateTotalWatchTime(int userId, String videoPath, int watchTime) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET total_watch_time = total_watch_time + ?
      WHERE user_id = ? AND video_path = ?
    ''', [watchTime, userId, videoPath]);
  }

  Future<void> updateWatchTime(int userId, String videoPath, int watchTime) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET watch_time = ?
      WHERE user_id = ? AND video_path = ?
    ''', [watchTime, userId, videoPath]);
  }
}






///2





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
      version: 2,
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
            total_watch_time INTEGER DEFAULT 0,
            view_count INTEGER DEFAULT 0,
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE watch_times
            ADD COLUMN total_watch_time INTEGER DEFAULT 0
          ''');
        }
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

  Future<void> insertWatchTime(int userId, String videoPath, int watchTime, int totalWatchTime, int viewCount) async {
    final db = await database;
    await db.insert(
      'watch_times',
      {'user_id': userId, 'video_path': videoPath, 'watch_time': watchTime, 'total_watch_time': totalWatchTime, 'view_count': viewCount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getWatchData(int userId, String videoPath) async {
    final db = await database;
    final result = await db.query(
      'watch_times',
      where: 'user_id = ? AND video_path = ?',
      whereArgs: [userId, videoPath],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> incrementViewCount(int userId, String videoPath) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET view_count = view_count + 1
      WHERE user_id = ? AND video_path = ?
    ''', [userId, videoPath]);
  }

  Future<void> updateTotalWatchTime(int userId, String videoPath, int watchTime) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET total_watch_time = total_watch_time + ?
      WHERE user_id = ? AND video_path = ?
    ''', [watchTime, userId, videoPath]);
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
  int _totalWatchTime = 0;
  int _videoDuration = 0;
  int? _userId;
  int _viewCount = 0;

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

  void _loadWatchData() async {
    if (_userId != null) {
      final watchData = await DatabaseHelper().getWatchData(_userId!, 'video.mp4');
      if (watchData != null) {
        _watchTime = watchData['watch_time'] as int;
        _totalWatchTime = watchData['total_watch_time'] as int;
        _viewCount = watchData['view_count'] as int;
        if (_totalWatchTime < _videoDuration * 2) {
          _controller.seekTo(Duration(milliseconds: _lastPosition));
          _controller.play();
        } else {
          _showWatchLimitReachedDialog();
        }
      } else {
        DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', 0, 0, 0);
      }
    }
  }

  void _saveWatchData() async {
    if (_userId != null) {
      await DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', _watchTime, _totalWatchTime, _viewCount);
    }
  }

  void _incrementViewCount() async {
    if (_userId != null) {
      _viewCount++;
      await DatabaseHelper().incrementViewCount(_userId!, 'video.mp4');
    }
  }

  void _updateTotalWatchTime() async {
    if (_userId != null) {
      await DatabaseHelper().updateTotalWatchTime(_userId!, 'video.mp4', _controller.value.position.inMilliseconds - _lastPosition);
      setState(() {
        _totalWatchTime += _controller.value.position.inMilliseconds - _lastPosition;
      });
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
                _loadWatchData();
              },
              child: Text('Continue Watching'),
            ),
          ],
        ),
      );
    } else {
      _loadWatchData();
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
    _updateTotalWatchTime();
    _saveWatchData();
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
              _updateTotalWatchTime();
            } else {
              if (_totalWatchTime < _videoDuration * 2) {
                _controller.play();
                if (_controller.value.position.inMilliseconds == 0) {
                  _incrementViewCount();
                }
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


///3

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
      version: 2,
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
            view_count INTEGER DEFAULT 0,
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE watch_times
            ADD COLUMN view_count INTEGER DEFAULT 0
          ''');
        }
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

  Future<void> insertWatchTime(int userId, String videoPath, int watchTime, int viewCount) async {
    final db = await database;
    await db.insert(
      'watch_times',
      {'user_id': userId, 'video_path': videoPath, 'watch_time': watchTime, 'view_count': viewCount},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getWatchData(int userId, String videoPath) async {
    final db = await database;
    final result = await db.query(
      'watch_times',
      where: 'user_id = ? AND video_path = ?',
      whereArgs: [userId, videoPath],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> incrementViewCount(int userId, String videoPath) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET view_count = view_count + 1
      WHERE user_id = ? AND video_path = ?
    ''', [userId, videoPath]);
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
  int _viewCount = 0;

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

  void _loadWatchData() async {
    if (_userId != null) {
      final watchData = await DatabaseHelper().getWatchData(_userId!, 'video.mp4');
      if (watchData != null) {
        _watchTime = watchData['watch_time'] as int;
        _viewCount = watchData['view_count'] as int;
        if (_watchTime < _maxWatchTime && _viewCount < 2) {
          _controller.seekTo(Duration(milliseconds: _lastPosition));
          _controller.play();
        } else {
          _showWatchLimitReachedDialog();
        }
      } else {
        DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', 0, 0);
      }
    }
  }

  void _saveWatchData() async {
    if (_userId != null) {
      await DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', _watchTime, _viewCount);
    }
  }

  void _incrementViewCount() async {
    if (_userId != null) {
      _viewCount++;
      await DatabaseHelper().incrementViewCount(_userId!, 'video.mp4');
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
                _loadWatchData();
              },
              child: Text('Continue Watching'),
            ),
          ],
        ),
      );
    } else {
      _loadWatchData();
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
    _saveWatchData();
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
              if (_watchTime < _maxWatchTime && _viewCount < 2) {
                _controller.play();
                _watchTime += 1000; // Increment watch time by 1 second
                if (_controller.value.position.inMilliseconds == 0) {
                  _incrementViewCount();
                }
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





///expiry


import 'package:flutter/material.dart';

class UserSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoPlayerScreen(userId: 'user1')),
                );
              },
              child: Text('User 1'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VideoPlayerScreen(userId: 'user2')),
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
  int _totalWatchTime = 0;
  int _videoDuration = 0;
  int? _userId;
  int _viewCount = 0;
  String _expiryDate = '';

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  void _initializeUser() async {
    _userId = await DatabaseHelper().getUserId(widget.userId);
    if (_userId != null) {
      _loadLastPosition();
      _loadWatchData();
      _controller = VideoPlayerController.asset('assets/video.mp4')
        ..initialize().then((_) {
          setState(() {
            _videoDuration = _controller.value.duration.inMilliseconds;
          });
          _showWatchedTimeMessage();
        })
        ..addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            _handleVideoCompleted();
          }
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

  void _loadWatchData() async {
    if (_userId != null) {
      final watchData = await DatabaseHelper().getWatchData(_userId!, 'video.mp4');
      if (watchData != null) {
        _watchTime = watchData['watch_time'] as int;
        _totalWatchTime = watchData['total_watch_time'] as int;
        _viewCount = watchData['view_count'] as int;
        _expiryDate = watchData['expiry_date'] as String? ?? '';
        if (_viewCount < 2) {
          if (_isVideoExpired()) {
            _showVideoExpiredMessage();
          } else {
            _controller.seekTo(Duration(milliseconds: _lastPosition));
            _controller.play();
          }
        } else {
          _showWatchLimitReachedDialog();
        }
      } else {
        DatabaseHelper().insertWatchTime(_userId!, 'video.mp4', 0, 0, 0, '');
      }
    }
  }

  bool _isVideoExpired() {
    if (_expiryDate.isNotEmpty) {
      DateTime expiryDateTime = DateTime.parse(_expiryDate);
      return DateTime.now().isAfter(expiryDateTime);
    }
    return false;
  }

  void _showVideoExpiredMessage() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Video Expired'),
        content: Text('This video has expired and is no longer available.'),
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

  void _saveWatchData() async {
    if (_userId != null) {
      await DatabaseHelper().updateWatchTime(_userId!, 'video.mp4', _watchTime);
    }
  }

  void _handleVideoCompleted() async {
    if (_userId != null) {
      _incrementViewCount();
      _updateTotalWatchTime(_videoDuration);
    }
  }

  void _incrementViewCount() async {
    if (_userId != null) {
      setState(() {
        _viewCount++;
      });
      await DatabaseHelper().incrementViewCount(_userId!, 'video.mp4');
    }
  }

  void _updateTotalWatchTime(int watchTime) async {
    if (_userId != null) {
      setState(() {
        _totalWatchTime += watchTime;
      });
      await DatabaseHelper().updateTotalWatchTime(_userId!, 'video.mp4', watchTime);
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
                _loadWatchData();
              },
              child: Text('Continue Watching'),
            ),
          ],
        ),
      );
    } else {
      _loadWatchData();
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
    _updateTotalWatchTime(_controller.value.position.inMilliseconds - _lastPosition);
    _saveWatchData();
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
              _updateTotalWatchTime(_controller.value.position.inMilliseconds - _lastPosition);
              _saveWatchData();
            } else {
              if (_viewCount < 2) {
                if (_isVideoExpired()) {
                  _showVideoExpiredMessage();
                } else {
                  _controller.play();
                }
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
      version: 2,
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
            total_watch_time INTEGER DEFAULT 0,
            view_count INTEGER DEFAULT 0,
            expiry_date TEXT, // New column for expiry date
            FOREIGN KEY (user_id) REFERENCES users (id)
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            ALTER TABLE watch_times
            ADD COLUMN total_watch_time INTEGER DEFAULT 0
          ''');
          await db.execute('''
            ALTER TABLE watch_times
            ADD COLUMN expiry_date TEXT
          ''');
        }
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

  Future<void> insertWatchTime(int userId, String videoPath, int watchTime, int totalWatchTime, int viewCount, String expiryDate) async {
    final db = await database;
    await db.insert(
      'watch_times',
      {'user_id': userId, 'video_path': videoPath, 'watch_time': watchTime, 'total_watch_time': totalWatchTime, 'view_count': viewCount, 'expiry_date': expiryDate},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getWatchData(int userId, String videoPath) async {
    final db = await database;
    final result = await db.query(
      'watch_times',
      where: 'user_id = ? AND video_path = ?',
      whereArgs: [userId, videoPath],
    );
    if (result.isNotEmpty) {
      return result.first;
    } else {
      return null;
    }
  }

  Future<void> incrementViewCount(int userId, String videoPath) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET view_count = view_count + 1
      WHERE user_id = ? AND video_path = ?
    ''', [userId, videoPath]);
  }

  Future<void> updateTotalWatchTime(int userId, String videoPath, int watchTime) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET total_watch_time = total_watch_time + ?
      WHERE user_id = ? AND video_path = ?
    ''', [watchTime, userId, videoPath]);
  }

  Future<void> updateWatchTime(int userId, String videoPath, int watchTime) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET watch_time = ?
      WHERE user_id = ? AND video_path = ?
    ''', [watchTime, userId, videoPath]);
  }

  Future<void> updateExpiryDate(int userId, String videoPath, String expiryDate) async {
    final db = await database;
    await db.rawUpdate('''
      UPDATE watch_times
      SET expiry_date = ?
      WHERE user_id = ? AND video_path = ?
    ''', [expiryDate, userId, videoPath]);
  }
}




















// import 'package:flutter/material.dart';
// import 'constant/color.dart';

// class HomePage extends StatefulWidget {
//   HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   // final titles = [
//   //   "Talkatora Indoor Stadium, New Delhi",
//   //   "Talkatora Indoor Stadium, New Delhi",
//   //   "Talkatora Indoor Stadium, New Delhi"
//   // ];
//   // final subtitles = [
//   //   "Here is list 1 subtitle",
//   //   "Here is list 2 subtitle",
//   //   "Here is list 3 subtitle"
//   // ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // appBar: AppBar(title: Text('data')),
//         body: CustomScrollView(slivers: [
//       SliverAppBar(
//         backgroundColor: white,
//         pinned: true,
//         leading: Padding(
//           padding: const EdgeInsets.only(left: 16),
//           child: Image.asset(
//             'assets/images/FootyConnect1.png',
//             width: 31,
//             height: 36,
//           ),
//         ),
//         titleSpacing: 2,
//         title: Padding(
//           padding: const EdgeInsets.only(left: 6),
//           child: Image.asset(
//             'assets/images/FootyConnect3.png',
//             height: 11,
//             width: 126,
//           ),
//         ),
//         actions: [
//           IconButton(
//               onPressed: () {},
//               icon: Image.asset(
//                 'assets/images/Notification.png',
//                 width: 18,
//                 height: 20,
//               ))
//         ],
//       ),
//       SliverToBoxAdapter(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 16, right: 16),
//           child: Container(
//             child: Padding(
//               padding: const EdgeInsets.only(top: 14),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: 274,
//                         height: 44,
//                         child: TextField(
//                           decoration: InputDecoration(
//                               fillColor: light,
//                               filled: true,
//                               enabledBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(
//                                       width: 3, color: Colors.transparent),
//                                   borderRadius: BorderRadius.circular(24)),
//                               focusedBorder: OutlineInputBorder(
//                                   borderSide: const BorderSide(color: grey),
//                                   borderRadius: BorderRadius.circular(24)),
//                               contentPadding: const EdgeInsets.only(left: 20),
//                               hintText: 'Search',
//                               hintStyle: const TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'NunitoSans',
//                                   fontWeight: FontWeight.w400,
//                                   fontStyle: FontStyle.normal)),
//                         ),
//                       ),
//                       Container(
//                         height: 44,
//                         width: 44,
//                         decoration: BoxDecoration(
//                           color: light,
//                           border:
//                               Border.all(width: 2, color: Colors.transparent),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(100),
//                           ),
//                         ),
//                         child: IconButton(
//                             onPressed: () {},
//                             icon: Image.asset(
//                               'assets/images/setting.png',
//                               width: 25,
//                               height: 20,
//                             )),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 18,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: const [
//                       Text(
//                         'Featured',
//                         style: TextStyle(
//                             color: black,
//                             fontFamily: 'IBMPlexSans',
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             fontStyle: FontStyle.normal),
//                       ),
//                       Text(
//                         "See all",
//                         style: TextStyle(
//                             color: red,
//                             fontFamily: 'NunitoSans',
//                             fontSize: 15,
//                             fontWeight: FontWeight.w500,
//                             fontStyle: FontStyle.normal),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   Stack(
//                     children: [
//                       Container(
//                         height: 130,
//                         width: 360,
//                         decoration: BoxDecoration(
//                           gradient: const LinearGradient(colors: [
//                             black,
//                             Colors.transparent,
//                           ]),
//                           image: DecorationImage(
//                               image: const AssetImage(
//                                 'assets/images/stadium1.jpeg',
//                               ),
//                               colorFilter: ColorFilter.mode(
//                                   black.withOpacity(0.3), BlendMode.darken),
//                               fit: BoxFit.cover),
//                           border:
//                               Border.all(width: 2, color: Colors.transparent),
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(20),
//                           ),
//                         ),
//                         // child: Image.asset(name),
//                       ),
//                       const Positioned(
//                         top: 25,
//                         left: 16,
//                         child: Text(
//                           'We going ',
//                           style: TextStyle(
//                               color: white,
//                               fontFamily: 'IBMPlexSans',
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                               fontStyle: FontStyle.normal),
//                         ),
//                       ),
//                       const Positioned(
//                         // top: 35,
//                         left: 16,
//                         bottom: 52,
//                         child: Text(
//                           'International!',
//                           style: TextStyle(
//                               color: white,
//                               fontFamily: 'IBMPlexSans',
//                               fontSize: 22,
//                               fontWeight: FontWeight.w500,
//                               fontStyle: FontStyle.normal),
//                         ),
//                       ),
//                       const Positioned(
//                         bottom: 27,
//                         left: 16,
//                         child: Text(
//                           'Kick to know more :)',
//                           style: TextStyle(
//                               color: white,
//                               fontFamily: 'IBMPlexSans',
//                               fontSize: 10,
//                               fontWeight: FontWeight.w500,
//                               fontStyle: FontStyle.normal),
//                         ),
//                       )
//                     ],
//                   ),
//                   const SizedBox(
//                     height: 20,
//                   ),
//                   // SingleChildScrollView(
//                   //   child: Container(
//                   //       child: ListView.builder(
//                   //           shrinkWrap: true,
//                   //           scrollDirection: Axis.horizontal,
//                   //           // itemCount: ,
//                   //           itemBuilder: (context, index) {
//                   //             return Card(
//                   //               child: Text('data'),
//                   //             );
//                   //           })),
//                   // )
//                   SizedBox(
//                     height: 70,
//                     width: MediaQuery.of(context).size.width,
//                     child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         physics: const ClampingScrollPhysics(),
//                         shrinkWrap: false,
//                         itemCount: 7,
//                         itemBuilder: (BuildContext context, int index) {
//                           return Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               width: 50,
//                               height: 50,
//                               decoration: BoxDecoration(
//                                 border: Border.all(width: 2, color: light),
//                                 borderRadius:
//                                     const BorderRadius.all(Radius.circular(8)),
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: const EdgeInsets.only(
//                                         left: 9, top: 5, right: 5),
//                                     child: Column(
//                                       children: const [
//                                         Text(
//                                           'Date',
//                                           style: TextStyle(
//                                               color: grey,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w400,
//                                               fontFamily: 'NunitoSans'),
//                                         ),
//                                         Text(
//                                           '24',
//                                           style: TextStyle(
//                                               color: black,
//                                               fontSize: 16,
//                                               fontWeight: FontWeight.w600,
//                                               fontFamily: 'NunitoSans'),
//                                         )
//                                       ],
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                           );
//                         }),
//                   ),

//                   ListView.builder(
//                       physics: const ClampingScrollPhysics(),
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       itemCount: 5,
//                       itemBuilder: (BuildContext context, int index) {
//                         return Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: ClipRRect(
//                               borderRadius: const BorderRadius.only(
//                                   topLeft: Radius.circular(25),
//                                   topRight: Radius.circular(25)),
//                               // bottomLeft: Radius.circular(20),
//                               // bottomRight: Radius.circular(20)),
//                               child: Container(
//                                   height: 240,
//                                   // height: 210,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(width: 2, color: grey),
//                                     borderRadius: const BorderRadius.all(
//                                         Radius.circular(20)),
//                                   ),

//                                   // child: ClipRRect(
//                                   //     borderRadius: BorderRadius.circular(6),
//                                   // child: Card(
//                                   //     semanticContainer: true,
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Image.asset(
//                                         'assets/images/stadium2.webp',
//                                         height: 172,
//                                         width: 373,
//                                         color: black.withOpacity(0.9),
//                                         fit: BoxFit.fill,
//                                         colorBlendMode: BlendMode.dstATop,
//                                       ),
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(left: 14, top: 12),
//                                         child: Text(
//                                           'Talkatora Indoor Stadium, New Delhi',
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       ),
//                                       const Padding(
//                                         padding:
//                                             EdgeInsets.only(left: 14, top: 5),
//                                         child: Text(
//                                             '5A Side : Open : Max 10 Players by ranjeet1137'),
//                                       )
//                                     ],
//                                   ))),
//                           // )
//                           // )
//                         );
//                       }),
//                   // ListView.builder(
//                   //     itemBuilder: (BuildContext context, int index) {
//                   //   return ClipRRect(
//                   //     child: Container(
//                   //         height: 240,
//                   //         child: Column(
//                   //           children: [
//                   //             Image.asset('assets/images/stadium2.webp'),
//                   //             Text(
//                   //               'Talkatora Indoor Stadium, New Delhi',
//                   //               style: TextStyle(
//                   //                   fontSize: 14, fontWeight: FontWeight.w600),
//                   //             ),
//                   //           ],
//                   //         )),
//                   //   );
//                   // })
//                   // Spacer(
//                   //   flex: 1,
//                   // ),

//                   // ListView.builder(
//                   //     physics: const ClampingScrollPhysics(),
//                   //     shrinkWrap: true,
//                   //     scrollDirection: Axis.vertical,
//                   //     itemCount: 5,
//                   //     itemBuilder: (BuildContext context, int index) {
//                   //       return Padding(
//                   //         padding: const EdgeInsets.all(8.0),
//                   //         child: ClipRRect(
//                   //             borderRadius: const BorderRadius.only(
//                   //                 topLeft: Radius.circular(25),
//                   //                 topRight: Radius.circular(25)),
//                   //             // bottomLeft: Radius.circular(20),
//                   //             // bottomRight: Radius.circular(20)),
//                   //             child: Container(
//                   //                 height: 240,
//                   //                 // height: 210,
//                   //                 decoration: BoxDecoration(
//                   //                   border: Border.all(width: 2, color: grey),
//                   //                   borderRadius: const BorderRadius.all(
//                   //                       Radius.circular(20)),
//                   //                 ),

//                   //                 // child: ClipRRect(
//                   //                 //     borderRadius: BorderRadius.circular(6),
//                   //                 // child: Card(
//                   //                 //     semanticContainer: true,
//                   //                 child: Column(
//                   //                   crossAxisAlignment:
//                   //                       CrossAxisAlignment.start,
//                   //                   children: [
//                   //                     Image.asset(
//                   //                       'assets/images/stadium2.webp',
//                   //                       height: 172,
//                   //                       width: 373,
//                   //                       color: black.withOpacity(0.9),
//                   //                       fit: BoxFit.fill,
//                   //                       colorBlendMode: BlendMode.dstATop,
//                   //                     ),
//                   //                     const Padding(
//                   //                       padding:
//                   //                           EdgeInsets.only(left: 14, top: 12),
//                   //                       child: Text(
//                   //                         'Talkatora Indoor Stadium, New Delhi',
//                   //                         style: TextStyle(
//                   //                             fontSize: 14,
//                   //                             fontWeight: FontWeight.w600),
//                   //                       ),
//                   //                     ),
//                   //                     const Padding(
//                   //                       padding:
//                   //                           EdgeInsets.only(left: 14, top: 5),
//                   //                       child: Text(
//                   //                           '5A Side : Open : Max 10 Players by ranjeet1137'),
//                   //                     )
//                   //                   ],
//                   //                 ))),
//                   //         // )
//                   //         // )
//                   //       );
//                   //     }),

//                   // SizedBox(
//                   //   height: 20,
//                   // ),

//                   // Container(
//                   //   width: MediaQuery.of(context).size.width,
//                   //   height: MediaQuery.of(context).size.height,
//                   //   child: ListView.builder(
//                   //       // itemCount: product.length,
//                   //       itemBuilder: ((context, index) => Container(
//                   //             height: 100,
//                   //             color: black,
//                   //             child: Padding(
//                   //               padding: const EdgeInsets.only(
//                   //                   left: 20, right: 20, top: 20),
//                   //               child: Card(
//                   //                   // margin: const EdgeInsets.all(10),
//                   //                   shape: RoundedRectangleBorder(
//                   //                       side: BorderSide(width: 1),
//                   //                       borderRadius: BorderRadius.circular(10)),
//                   //                   child: ListTile(
//                   //                       // tileColor: Colors.grey,
//                   //                       // leading: Text('da',
//                   //                       //   // product[index],
//                   //                       //   style: TextStyle(
//                   //                       //       fontSize: 18, fontWeight: FontWeight.w500),
//                   //                       // ),
//                   //                       // title: Text(
//                   //                       //   date[index],
//                   //                       //   textAlign: TextAlign.center,
//                   //                       //   style: TextStyle(
//                   //                       //     fontSize: 18,
//                   //                       //     fontWeight: FontWeight.w500,
//                   //                       //   ),
//                   //                       // ),
//                   //                       // trailing: Text(
//                   //                       //   earn[index],
//                   //                       //   style: TextStyle(
//                   //                       //       fontSize: 18, fontWeight: FontWeight.w500),
//                   //                       // ),
//                   //                       )),
//                   //             ),
//                   //           ))),
//                   // )
//                 ],
//               ),
//             ),
//           ),
//         ),
//       )
//     ]));
//   }
// }
//       // child: Container(

//       // height: MediaQuery.of(context).size.height,
//       // width: MediaQuery.of(context).size.width,
//       // child: Expanded(
//       //   child: ListView.builder(
//       //       physics: ClampingScrollPhysics(),
//       //       shrinkWrap: true,
//       //       scrollDirection: Axis.vertical,
//       //       itemCount: 10,
//       //       itemBuilder: (BuildContext context, int index) {
//       //         return Padding(
//       //           padding: const EdgeInsets.all(8.0),
//       //           child: ClipRRect(
//       //               borderRadius: BorderRadius.only(
//       //                   topLeft: Radius.circular(25),
//       //                   topRight: Radius.circular(25)),
//       //               // bottomLeft: Radius.circular(20),
//       //               // bottomRight: Radius.circular(20)),
//       //               child: Container(
//       //                   height: 240,
//       //                   // height: 210,
//       //                   decoration: BoxDecoration(
//       //                     border: Border.all(width: 2, color: grey),
//       //                     borderRadius:
//       //                         BorderRadius.all(Radius.circular(20)),
//       //                   ),

//       //                   // child: ClipRRect(
//       //                   //     borderRadius: BorderRadius.circular(6),
//       //                   // child: Card(
//       //                   //     semanticContainer: true,
//       //                   child: Column(
//       //                     crossAxisAlignment: CrossAxisAlignment.start,
//       //                     children: [
//       //                       Image.asset(
//       //                         'assets/images/stadium2.webp',
//       //                         height: 172,
//       //                         width: 373,
//       //                         color: black.withOpacity(0.9),
//       //                         fit: BoxFit.fill,
//       //                         colorBlendMode: BlendMode.dstATop,
//       //                       ),
//       //                       Padding(
//       //                         padding:
//       //                             const EdgeInsets.only(left: 14, top: 12),
//       //                         child: Text(
//       //                           'Talkatora Indoor Stadium, New Delhi',
//       //                           style: TextStyle(
//       //                               fontSize: 14,
//       //                               fontWeight: FontWeight.w600),
//       //                         ),
//       //                       ),
//       //                       Padding(
//       //                         padding:
//       //                             const EdgeInsets.only(left: 14, top: 5),
//       //                         child: Text(
//       //                             'Talkatora Indoor Stadium, New Delhi'),
//       //                       )
//       //                     ],
//       //                   ))),
//       //           // )
//       //           // )
//       //         );
//       //       }),
//       // ),
//       // )
