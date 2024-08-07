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
