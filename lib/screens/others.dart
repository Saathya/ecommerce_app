import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/chat_tile.dart';
import 'package:ecommerce_app/screens/chatui.dart';
import 'package:ecommerce_app/screens/detailpage.dart';
import 'package:ecommerce_app/screens/login.dart';
import 'package:ecommerce_app/screens/mainpage.dart';
import 'package:ecommerce_app/screens/message.dart';
import 'package:ecommerce_app/screens/pallete.dart';
import 'package:ecommerce_app/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 18, right: 10),
              child: Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: 250,
                    child: TextField(
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.black,
                          ),
                          hintText: 'Search..',
                          hintStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Badge(
                    label: Text('0'),
                    child: Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(
                          'assets/icons/img.png',
                        )),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Badge(
                    label: Text('9+'),
                    child: Image(
                        height: 30,
                        width: 30,
                        image: AssetImage(
                          'assets/icons/chat.png',
                        )),
                  ),
                ],
              ),
            ),
            Container(
                height: 180,
                width: 400,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                    'assets/images/main.png',
                  )),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Container(
                      height: 130,
                      width: 390,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 1.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.grid_view_outlined,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'Category',
                                    style: TextStyle(fontSize: 14),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Icon(
                                      Icons.flight,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  const Text('Flight',
                                      style: TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.receipt_long,
                                      size: 22,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'bill',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.data_exploration_outlined,
                                      size: 22,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'Data Plan',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 53,
                                    width: 53,
                                    decoration: BoxDecoration(
                                        color: const Color(0xffF6F6F6),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                        child: const Icon(
                                      Icons.upcoming_outlined,
                                      size: 22,
                                    )),
                                  ),
                                  const SizedBox(
                                    height: 14,
                                  ),
                                  const Text(
                                    'TopUp',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 18.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Best Sale Product',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'See more',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff2A977D),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPage()));
                },
                child: Row(
                  children: [
                    Container(
                      height: 248,
                      width: 160,
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 114,
                            image: AssetImage('assets/images/shirt1.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shirt',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$12.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 248,
                      width: 160,
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 124,
                            image: AssetImage('assets/images/shirt4.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shirt',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$12.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 8, right: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPage()));
                },
                child: Row(
                  children: [
                    Container(
                      height: 248,
                      width: 160,
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 118,
                            image: AssetImage('assets/images/shirt1.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shirt',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$12.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 248,
                      width: 160,
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 124,
                            image: AssetImage('assets/images/shirt4.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shirt',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$12.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DetailPage()));
                },
                child: Row(
                  children: [
                    Container(
                      height: 248,
                      width: 160,
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 118,
                            image: AssetImage('assets/images/shirt3.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shirt',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$12.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      height: 248,
                      width: 160,
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image(
                            height: 124,
                            image: AssetImage('assets/images/shirt2.png'),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shirt',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Essential Men's Short-\nSleeve Crewneck T-Shirt",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orange,
                                    ),
                                    Text(
                                      '4.9 | 2336',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      '\$12.00',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: Color(0xff2A977D)),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ],
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseServices service = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
      ),
      body: chatList(),
    );
  }

  Widget chatList() {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      // Handle case where user is not authenticated
      return const Center(child: Text('User not authenticated'));
    }

    return StreamBuilder(
      stream: service.getUsersProfiles(currentUser.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching users'));
        }

        if (snapshot.hasData && snapshot.data != null) {
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemBuilder: (BuildContext context, index) {
              UserProfile user = users[index].data();
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ChatTile(
                  user: user,
                  onTap: () async {
                    final chatExists = await service.checkChatExists(
                        currentUser.uid, user.uid);

                    if (!chatExists) {
                      await service.createNewChat(currentUser.uid, user.uid);
                    }

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChatUI(chatUser: user)));
                  },
                ),
              );
            },
            itemCount: users.length,
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
      ),
      body: const Center(
        child: Text('Wallet Screen Content'),
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const MainHomePage()));
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              isDark ? Icons.wb_sunny : Icons.nightlight_round,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: user == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _buildUserProfile(),
    );
  }

  Widget _buildUserProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your user data fields here
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 130.0,
              width: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: user!.photoURL != null
                      ? NetworkImage(user!.photoURL!) as ImageProvider<Object>
                      : const NetworkImage(
                          'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=2000'),
                  fit: BoxFit.cover,
                ),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black, width: 1.0),
              ),
            ),

            Text(
              'Name: ${user!.displayName}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              'Email: ${user!.email}',
              style: const TextStyle(fontSize: 18),
            ),
            // Add more user data fields as needed
            const SizedBox(height: 20),

            // Edit Profile Button
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  // Handle edit profile button press here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  side: BorderSide.none,
                  shape: const StadiumBorder(),
                ),
                child: const Text(
                  'Edit Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Divider
            const Divider(),
            const SizedBox(height: 10),

            // Profile Menu Items
            // Replace with your ProfileMenuWidget items
            ProfileMenuWidget(
              title: "Settings",
              icon: Icons.settings,
              onPress: () {
                // Handle Settings menu item press here
              },
            ),
            ProfileMenuWidget(
              title: "Billing Details",
              icon: Icons.payment,
              onPress: () {
                // Handle Billing Details menu item press here
              },
            ),
            // ProfileMenuWidget(
            //   title: "Admin Login",
            //   icon: Icons.supervised_user_circle,
            //   onPress: () {
            //     // Handle User Management menu item press here
            //     Navigator.pushReplacement(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const SuperAdminLanding()));
            //   },
            // ),

            // Divider
            const Divider(),
            const SizedBox(height: 10),

            // Information and Logout Menu Items
            ProfileMenuWidget(
              title: "Information",
              icon: Icons.info,
              onPress: () {
                // Handle Information menu item press here
              },
            ),
            ProfileMenuWidget(
              title: "Logout",
              icon: Icons.logout,
              textColor: Colors.red,
              endIcon: false,
              onPress: () {
                logout(context);

                // Handle Logout menu item press here
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut().then(
          (value) => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginUI(),
              )),
        );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    var iconColor = isDark ? Pallete.gradient1 : Pallete.gradient2;

    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: iconColor.withOpacity(0.1),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyLarge?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: const Icon(Icons.abc, size: 18.0, color: Colors.grey))
          : null,
    );
  }
}
