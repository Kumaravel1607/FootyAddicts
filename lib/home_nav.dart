dependencies:
  flutter:
    sdk: flutter
  just_audio: ^0.9.18
  audio_service: ^0.18.0
  just_audio_background: ^0.0.7
  provider: ^6.0.3

dev_dependencies:
  flutter_test:
    sdk: flutter


import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'audio_player_service.dart';
import 'fm_player_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Just Audio Background for background playback and notification controls
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.yourcompany.yourapp.channel.audio',
    androidNotificationChannelName: 'FM Playback',
    androidNotificationOngoing: true,
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => AudioPlayerService(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FM Player',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FMPlayerScreen(),
    );
  }
}




import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

class FMChannel {
  final String name;
  final String url;
  final String thumbnail;

  FMChannel({required this.name, required this.url, required this.thumbnail});
}

class ChannelList {
  final String category;
  final List<FMChannel> channels;

  ChannelList({required this.category, required this.channels});
}

class AudioPlayerService extends ChangeNotifier {
  final AudioPlayer _player = AudioPlayer();
  List<FMChannel>? _currentChannelList;
  int _currentChannelIndex = 0;

  AudioPlayer get player => _player;

  Future<void> playChannelList(List<FMChannel> channels, int startIndex) async {
    _currentChannelList = channels;
    _currentChannelIndex = startIndex;

    final mediaItems = channels.map((channel) {
      return MediaItem(
        id: channel.url,
        album: "FM Playlist",
        title: channel.name,
        artUri: Uri.parse(channel.thumbnail),
      );
    }).toList();

    await _player.setAudioSource(
      ConcatenatingAudioSource(
        children: mediaItems.map((item) => AudioSource.uri(Uri.parse(item.id), tag: item)).toList(),
      ),
      initialIndex: startIndex,
    );

    _player.play();
  }

  Future<void> playNext() async {
    if (_currentChannelList != null && _currentChannelIndex < _currentChannelList!.length - 1) {
      _currentChannelIndex++;
      await _player.seek(Duration.zero, index: _currentChannelIndex);
    }
  }

  Future<void> playPrevious() async {
    if (_currentChannelList != null && _currentChannelIndex > 0) {
      _currentChannelIndex--;
      await _player.seek(Duration.zero, index: _currentChannelIndex);
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }
}




import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'audio_player_service.dart';

class FMPlayerScreen extends StatelessWidget {
  final List<ChannelList> channelCategories = [
    ChannelList(
      category: "Popular Channels",
      channels: [
        FMChannel(name: "Popular 1", url: "http://example.com/stream1", thumbnail: "https://example.com/image1.jpg"),
        FMChannel(name: "Popular 2", url: "http://example.com/stream2", thumbnail: "https://example.com/image2.jpg"),
        FMChannel(name: "Popular 3", url: "http://example.com/stream3", thumbnail: "https://example.com/image3.jpg"),
        FMChannel(name: "Popular 4", url: "http://example.com/stream4", thumbnail: "https://example.com/image4.jpg"),
        FMChannel(name: "Popular 5", url: "http://example.com/stream5", thumbnail: "https://example.com/image5.jpg"),
      ],
    ),
    ChannelList(
      category: "Devotional Channels",
      channels: [
        FMChannel(name: "Devotional 1", url: "http://example.com/stream6", thumbnail: "https://example.com/image6.jpg"),
        FMChannel(name: "Devotional 2", url: "http://example.com/stream7", thumbnail: "https://example.com/image7.jpg"),
        FMChannel(name: "Devotional 3", url: "http://example.com/stream8", thumbnail: "https://example.com/image8.jpg"),
        FMChannel(name: "Devotional 4", url: "http://example.com/stream9", thumbnail: "https://example.com/image9.jpg"),
        FMChannel(name: "Devotional 5", url: "http://example.com/stream10", thumbnail: "https://example.com/image10.jpg"),
      ],
    ),
    ChannelList(
      category: "Tamil Channels",
      channels: [
        FMChannel(name: "Tamil 1", url: "http://example.com/stream11", thumbnail: "https://example.com/image11.jpg"),
        FMChannel(name: "Tamil 2", url: "http://example.com/stream12", thumbnail: "https://example.com/image12.jpg"),
        FMChannel(name: "Tamil 3", url: "http://example.com/stream13", thumbnail: "https://example.com/image13.jpg"),
        FMChannel(name: "Tamil 4", url: "http://example.com/stream14", thumbnail: "https://example.com/image14.jpg"),
        FMChannel(name: "Tamil 5", url: "http://example.com/stream15", thumbnail: "https://example.com/image15.jpg"),
      ],
    ),
    ChannelList(
      category: "Kannada Channels",
      channels: [
        FMChannel(name: "Kannada 1", url: "http://example.com/stream16", thumbnail: "https://example.com/image16.jpg"),
        FMChannel(name: "Kannada 2", url: "http://example.com/stream17", thumbnail: "https://example.com/image17.jpg"),
        FMChannel(name: "Kannada 3", url: "http://example.com/stream18", thumbnail: "https://example.com/image18.jpg"),
        FMChannel(name: "Kannada 4", url: "http://example.com/stream19", thumbnail: "https://example.com/image19.jpg"),
        FMChannel(name: "Kannada 5", url: "http://example.com/stream20", thumbnail: "https://example.com/image20.jpg"),
      ],
    ),
    ChannelList(
      category: "Malayalam Channels",
      channels: [
        FMChannel(name: "Malayalam 1", url: "http://example.com/stream21", thumbnail: "https://example.com/image21.jpg"),
        FMChannel(name: "Malayalam 2", url: "http://example.com/stream22", thumbnail: "https://example.com/image22.jpg"),
        FMChannel(name: "Malayalam 3", url: "http://example.com/stream23", thumbnail: "https://example.com/image23.jpg"),
        FMChannel(name: "Malayalam 4", url: "http://example.com/stream24", thumbnail: "https://example.com/image24.jpg"),
        FMChannel(name: "Malayalam 5", url: "http://example.com/stream25", thumbnail: "https://example.com/image25.jpg"),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final audioPlayerService = Provider.of<AudioPlayerService>(context);

    return Scaffold(
      appBar: AppBar(title: Text("FM Player")),
      body: ListView.builder(
        itemCount: channelCategories.length,
        itemBuilder: (context, categoryIndex) {
          final category = channelCategories[categoryIndex];
          return ExpansionTile(
            title: Text(category.category),
            children: category.channels.map((channel) {
              return ListTile(
                leading: Image.network(channel.thumbnail),
                title: Text(channel.name),
                onTap: () {
                  audioPlayerService.playChannelList(category.channels, category.channels.indexOf(channel));
                },
              );
            }).toList(),
          );
        },
      ),
      bottomNavigationBar: _buildBottomPlayer(context, audioPlayerService),
    );
  }

  Widget _buildBottomPlayer(BuildContext context, AudioPlayerService audioPlayerService) {
    return BottomAppBar(
      child: Container(
        height: 70,
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
             
              icon: Icon(Icons.skip_previous),
              onPressed: () => audioPlayerService.playPrevious(),
            ),
            IconButton(
              icon: Icon(
                audioPlayerService.player.playing ? Icons.pause : Icons.play_arrow,
              ),
              onPressed: () {
                if (audioPlayerService.player.playing) {
                  audioPlayerService.player.pause();
                } else {
                  audioPlayerService.player.play();
                }
              },
            ),
            IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () => audioPlayerService.playNext(),
            ),
          ],
        ),
      ),
    );
  }
}













///

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';

class UserDetails {
  final int id;
  final String name;
  final String referralNumber;
  final int earningPoints;
  final int referredCount;

  UserDetails({
    required this.id,
    required this.name,
    required this.referralNumber,
    required this.earningPoints,
    required this.referredCount,
  });
}

String generateReferralCode() {
  const length = 8;
  const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  Random random = Random();

  return String.fromCharCodes(
    Iterable.generate(
      length,
      (_) => characters.codeUnitAt(random.nextInt(characters.length)),
    ),
  );
}

List<UserDetails> generateUsers(int startId, int count) {
  return List<UserDetails>.generate(
    count,
    (index) => UserDetails(
      id: startId + index,
      name: 'User ${startId + index}',
      referralNumber: generateReferralCode(),
      earningPoints: (startId + index) * 10,
      referredCount: (startId + index) % 5,
    ),
  );
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  void _login() {
    if (_referralController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InfiniteListScreen(referralNumber: _referralController.text)),
      );
    } else {
      // Show error message if referral number is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Referral number is required'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _referralController,
              decoration: InputDecoration(labelText: 'Referral Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

class InfiniteListScreen extends StatefulWidget {
  final String? previousItemName;
  final String referralNumber;

  InfiniteListScreen({this.previousItemName, required this.referralNumber});

  @override
  _InfiniteListScreenState createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends State<InfiniteListScreen> {
  List<UserDetails> items = [];
  int page = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoading) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    List<UserDetails> newItems = generateUsers(page * 10, 10);

    setState(() {
      items.addAll(newItems);
      page++;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _copyReferralCode(String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Referral code copied to clipboard')));
  }

  void _shareReferralCode(String code) {
    Share.share('Here is my referral code: $code');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.previousItemName ?? 'Infinite List'),
            Text(
              'Referral: ${widget.referralNumber}',
              style: TextStyle(fontSize: 14.0),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.copy),
            onPressed: () => _copyReferralCode(widget.referralNumber),
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => _shareReferralCode(widget.referralNumber),
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildLoadingIndicator();
          }
          return ListTile(
            title: Text(items[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Points: ${items[index].earningPoints}'),
                Text('Referred Count: ${items[index].referredCount}'),
                Text('Referral: ${items[index].referralNumber}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfiniteListScreen(
                    referralNumber: items[index].referralNumber,
                    previousItemName: items[index].name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite List View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}





// class 

class UserDetails {
  final int id;
  final String name;
  final String referralNumber;
  final int earningPoints;
  final int referredCount;

  UserDetails({
    required this.id,
    required this.name,
    required this.referralNumber,
    required this.earningPoints,
    required this.referredCount,
  });
}

List<UserDetails> generateUsers(String referralNumber, int startId, int count) {
  return List<UserDetails>.generate(
    count,
    (index) => UserDetails(
      id: startId + index,
      name: 'User ${startId + index}',
      referralNumber: referralNumber,
      earningPoints: (startId + index) * 10,
      referredCount: (startId + index) % 5,
    ),
  );
}


///login

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();

  void _login() {
    if (_referralController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => InfiniteListScreen(referralNumber: _referralController.text)),
      );
    } else {
      // Show error message if referral number is empty
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Referral number is required'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _referralController,
              decoration: InputDecoration(labelText: 'Referral Number'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}


/// userscreen list

import 'package:flutter/material.dart';

class InfiniteListScreen extends StatefulWidget {
  final String? previousItemName;
  final String referralNumber;

  InfiniteListScreen({this.previousItemName, required this.referralNumber});

  @override
  _InfiniteListScreenState createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends State<InfiniteListScreen> {
  List<UserDetails> items = [];
  int page = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoading) {
        _loadMoreItems();
      }
    });
  }

  void _loadMoreItems() async {
    setState(() {
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 1)); // Simulate network delay

    List<UserDetails> newItems = generateUsers(widget.referralNumber, page * 10, 10);

    setState(() {
      items.addAll(newItems);
      page++;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.previousItemName != null ? 'Selected: ${widget.previousItemName}' : 'Infinite List'),
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: items.length + (isLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == items.length) {
            return _buildLoadingIndicator();
          }
          return ListTile(
            title: Text(items[index].name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Points: ${items[index].earningPoints}'),
                Text('Referred Count: ${items[index].referredCount}'),
                Text('Referral: ${items[index].referralNumber}'),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InfiniteListScreen(
                    referralNumber: items[index].referralNumber,
                    previousItemName: items[index].name,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}


///main 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite List View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}











// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:footyaddicts/Navigation.dart';
// import 'package:footyaddicts/Signin.dart';

// class Nav_home extends StatefulWidget {
//   Nav_home({Key? key}) : super(key: key);

//   @override
//   State<Nav_home> createState() => _Nav_homeState();
// }

// class _Nav_homeState extends State<Nav_home> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasData) {
//             return Navigation();
//           } else if (snapshot.hasError) {
//             return Center(child: Text("Something went Wrong!"));
//           } else {
//             return LoginScreen();
//           }
//         });
//   }
// }
