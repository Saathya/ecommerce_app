import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/screens/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginUI extends StatelessWidget {
  const LoginUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 768) {
          return ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            children: const [Menu(), Body()],
          );
        } else if (constraints.maxWidth < 767) {
          return ListView(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            children: const [
              Menu(),
              Body(),
            ],
          );
        }
        return ListView(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 8),
          children: const [Menu(), Body()],
        );
      }),
    );
  }
}

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Row(
          mainAxisAlignment: (screenWidth < 425)
              ? MainAxisAlignment.start
              : MainAxisAlignment.start,
          children: [
           
          ],
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 30,
          ),
          if (screenWidth < 480)
            Column(
              children: [
                const Text(
                  'Sign In to My Application',
                  style: TextStyle(
                      fontSize: 28, // Adjust the font size for smaller screens
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center, // Center the text
                ),
                const SizedBox(
                  height: 20, // Reduce the spacing
                ),
                Image.asset(
                  'assets/images/illustration-1.png',
                  height: screenWidth * .6,
                  width: screenWidth *
                      0.8, // Adjust the image width based on screen width
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: screenWidth *
                      0.8, // Adjust the form width based on screen width
                  child: _formLogin(context),
                ),
              ],
            )
          else if (screenWidth <= 768)
            Column(
              children: [
                const Text(
                  'Sign In to My Application',
                  style: TextStyle(
                      fontSize: 28, // Adjust the font size for smaller screens
                      fontWeight: FontWeight.bold,
                      color: Colors.black),

                  textAlign: TextAlign.center, // Center the text
                ),
                const SizedBox(
                  height: 20, // Reduce the spacing
                ),
                Image.asset(
                  'assets/images/illustration-1.png',
                  height: screenWidth * .6,
                  width: screenWidth *
                      0.8, // Adjust the image width based on screen width
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: screenWidth *
                      0.8, // Adjust the form width based on screen width
                  child: _formLogin(context),
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 360,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Sign In to \nMy Application',
                        style: TextStyle(
                            fontSize: 45,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        'assets/images/illustration-2.png',
                        width: 300,
                      ),
                    ],
                  ),
                ),
                MediaQuery.of(context).size.width >= 1300 //Responsive
                    ? Image.asset(
                        'assets/images/illustration-1.png',
                        width: 300,
                      )
                    : const SizedBox(),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height / 6),
                  child: SizedBox(
                    width: 320,
                    child: _formLogin(
                      context,
                    ),
                  ),
                )
              ],
            )
        ],
      ),
    );
  }

  Widget _formLogin(
    context,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // // ignore: prefer_typing_uninitialized_variables
    final FirebaseAuth auth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();

    Future<void> updateUserData(User user) async {
      final usersRef = FirebaseFirestore.instance.collection('users');
      final doc = await usersRef.doc(user.uid).get();

      if (!doc.exists) {
        // Document doesn't exist, create a new one
        await usersRef.doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'profile': user.photoURL,
          'uid':user.uid
        });
      }

      
    
    }

   Future<User?> signInWithGoogle() async {
  try {
    EasyLoading.show(status: 'Signing in...',maskType: EasyLoadingMaskType.black); // Show loading indicator

    // Trigger the Google Authentication flow
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    if (googleUser == null) return null; // User cancelled the sign-in flow

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final UserCredential userCredential =
        await auth.signInWithCredential(credential);

    // Check if user exists in Firestore
    await updateUserData(userCredential.user!);

    // Dismiss EasyLoading before navigation
    EasyLoading.dismiss();

    // Navigate to main home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainHomePage()),
    );

    return userCredential.user;
  } catch (e) {
    if (kDebugMode) {
      print("Error signing in with Google: $e");
    }
    EasyLoading.dismiss(); // Dismiss loading indicator on error
    return null;
  }
}


    if (screenWidth < 480) {
      return Column(children: [
        const SizedBox(height: 20),
        Row(children: [
          Expanded(
            child: Divider(
              color: Colors.grey[300],
              height: 50,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Login with",
              style: TextStyle(color: Colors.black),
            ),
          ),
          Expanded(
            child: Divider(
              color: Colors.grey.shade400,
              height: 50,
            ),
          ),
        ]),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
                onTap: () async {
                  User? user = await signInWithGoogle();
                  if (user != null) {
                    // User signed in successfully, navigate to the 'login' screen
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainHomePage()));
                  }

                  // Dismiss loading indicator
                },
                child: _loginWithButton(
                    image: 'assets/images/google.png', isActive: true)),
          ],
        ),
        const SizedBox(height: 20),
      ]);
    } else if (screenWidth <= 768) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                height: 50,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Login with",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade400,
                height: 50,
              ),
            ),
          ]),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    User? user = await signInWithGoogle();
                    if (user != null) {
                      // User signed in successfully, now store data in Firestore
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainHomePage()));
                      // Proceed to the next screen or perform other actions.
                    }
                  },
                  child: _loginWithButton(
                      image: 'assets/images/google.png', isActive: true)),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                height: 50,
              ),
            ),
          ]),
        ],
      );
    } else {
      return Column(
        children: [
          const SizedBox(height: 40),
          Row(children: [
            Expanded(
              child: Divider(
                color: Colors.grey[300],
                height: 50,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Login with",
                style: TextStyle(color: Colors.black),
              ),
            ),
            Expanded(
              child: Divider(
                color: Colors.grey.shade400,
                height: 50,
              ),
            ),
          ]),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () async {
                    User? user = await signInWithGoogle();
                    if (user != null) {
                      // User signed in successfully, now store data in Firestore
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainHomePage()));

                      // Proceed to the next screen or perform other actions.
                    }
                  },
                  child: _loginWithButton(
                      image: 'assets/images/google.png', isActive: true)),
            ],
          ),
          const SizedBox(height: 40),
        ],
      );
    }
  }

  // void signIn(String email, String password, BuildContext context) async {
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: email,
  //       password: password,
  //     );
  //     EasyLoading.show(
  //         status: 'Please wait...', maskType: EasyLoadingMaskType.black);
  //     if (userCredential.user != null) {
  //       DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userCredential.user!.uid)
  //           .get();

  //       if (documentSnapshot.exists) {
  //         bool isApproved = documentSnapshot.get('approved') ?? false;

  //         if (isApproved) {
  //           // User is approved, navigate to the appropriate dashboard based on roles
  //           List<dynamic> userRoles = documentSnapshot.get('roles');
  //           if (userRoles.contains("User")) {
  //             Navigator.pushNamed(context, '/');
  //           }
  //           EasyLoading.dismiss();
  //         } else {
  //           EasyLoading.dismiss();
  //           showDialog(
  //             context: context,
  //             builder: (context) {
  //               return AlertDialog(
  //                 title: Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     // Title text in the top center
  //                     const Text(
  //                       "You are not authorized to log in.",
  //                       style: TextStyle(
  //                           fontSize: 20, fontWeight: FontWeight.bold),
  //                     ),
  //                     const SizedBox(
  //                       width: 25,
  //                     ),
  //                     // Close icon in the top-right corner
  //                     Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         InkWell(
  //                           onTap: () {
  //                             Navigator.of(context).pop(); // Close the dialog
  //                           },
  //                           child: const Padding(
  //                             padding: EdgeInsets.all(12.0),
  //                             child: Icon(
  //                               Icons.close,
  //                               size: 30,
  //                               color: Colors.black,
  //                             ),
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ],
  //                 ),
  //                 content: const Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //                     // Display member ID and password
  //                   ],
  //                 ),
  //                 // Close icon
  //               );
  //             },
  //           );
  //           // User is not authorized, show a message and do not proceed with login

  //           EasyLoading.dismiss();
  //           // Sign out the user to prevent further access
  //           await FirebaseAuth.instance.signOut();
  //         }
  //       } else {
  //         EasyLoading.dismiss();
  //         // Document does not exist in the database
  //         showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Row(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   // Title text in the top center
  //                   const Text(
  //                     "You are not registered as user!",
  //                     style:
  //                         TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                   const SizedBox(
  //                     width: 25,
  //                   ),
  //                   // Close icon in the top-right corner
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.end,
  //                     children: [
  //                       InkWell(
  //                         onTap: () {
  //                           Navigator.of(context).pop(); // Close the dialog
  //                         },
  //                         child: const Padding(
  //                           padding: EdgeInsets.all(12.0),
  //                           child: Icon(
  //                             Icons.close,
  //                             size: 30,
  //                             color: Colors.black,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //               content: const Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   // Display member ID and password
  //                 ],
  //               ),
  //               // Close icon
  //             );
  //           },
  //         );
  //         await FirebaseAuth.instance.signOut();

  //         Navigator.pushNamed(context, '/');
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // Title text in the top center
  //                 const Text(
  //                   "No user found for that email.",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(
  //                   width: 25,
  //                 ),
  //                 // Close icon in the top-right corner
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     InkWell(
  //                       onTap: () {
  //                         Navigator.of(context).pop(); // Close the dialog
  //                       },
  //                       child: const Padding(
  //                         padding: EdgeInsets.all(12.0),
  //                         child: Icon(
  //                           Icons.close,
  //                           size: 30,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             content: const Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Display member ID and password
  //               ],
  //             ),
  //             // Close icon
  //           );
  //         },
  //       );
  //       if (kDebugMode) {
  //         print('No user found for that email.');
  //       }
  //     } else if (e.code == 'wrong-password') {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // Title text in the top center
  //                 const Text(
  //                   "Wrong password provided by the user.",
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(
  //                   width: 25,
  //                 ),
  //                 // Close icon in the top-right corner
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     InkWell(
  //                       onTap: () {
  //                         Navigator.of(context).pop(); // Close the dialog
  //                       },
  //                       child: const Padding(
  //                         padding: EdgeInsets.all(12.0),
  //                         child: Icon(
  //                           Icons.close,
  //                           size: 30,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             content: const Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Display member ID and password
  //               ],
  //             ),
  //             // Close icon
  //           );
  //         },
  //       );
  //       if (kDebugMode) {
  //         print('Wrong password provided by the user.');
  //       }
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Row(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // Title text in the top center
  //                 Text(
  //                   "Sign-in failed: $e",
  //                   style: const TextStyle(
  //                       fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 const SizedBox(
  //                   width: 25,
  //                 ),
  //                 // Close icon in the top-right corner
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     InkWell(
  //                       onTap: () {
  //                         Navigator.of(context).pop(); // Close the dialog
  //                       },
  //                       child: const Padding(
  //                         padding: EdgeInsets.all(12.0),
  //                         child: Icon(
  //                           Icons.close,
  //                           size: 30,
  //                           color: Colors.black,
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             content: const Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 // Display member ID and password
  //               ],
  //             ),
  //             // Close icon
  //           );
  //         },
  //       );
  //       if (kDebugMode) {
  //         print('Sign-in failed: $e');
  //       }
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               // Title text in the top center
  //               Text(
  //                 "Sign-in failed: $e",
  //                 style: const TextStyle(
  //                     fontSize: 20, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(
  //                 width: 25,
  //               ),
  //               // Close icon in the top-right corner
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   InkWell(
  //                     onTap: () {
  //                       Navigator.of(context).pop(); // Close the dialog
  //                     },
  //                     child: const Padding(
  //                       padding: EdgeInsets.all(12.0),
  //                       child: Icon(
  //                         Icons.close,
  //                         size: 30,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //           content: const Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               // Display member ID and password
  //             ],
  //           ),
  //           // Close icon
  //         );
  //       },
  //     );
  //     if (kDebugMode) {
  //       print('Sign-in failed: $e');
  //     }
  //   }
  // }

  Widget _loginWithButton({String? image, bool isActive = false}) {
    return Container(
      width: 90,
      height: 70,
      decoration: isActive
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 10,
                  blurRadius: 30,
                )
              ],
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade400),
            ),
      child: Center(
          child: Container(
        decoration: isActive
            ? BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 2,
                    blurRadius: 15,
                  )
                ],
              )
            : const BoxDecoration(),
        child: Image.asset(
          image!,
          width: 35,
        ),
      )),
    );
  }
}

// suffixIcon: IconButton(
//               onPressed: () async {
//                 // myauth.setConfig(
//                 //     appEmail: "me@rohitchouhan.com",
//                 //     appName: "Email OTP",
//                 //     userEmail: authservice.emailcontroller.text,
//                 //     otpLength: 4,
//                 //     otpType: OTPType.digitsOnly);
//                 // if (await myauth.sendOTP() == true) {
//                 //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 //     content: Text("OTP has been sent"),
//                 //   ));
//                 // } else {
//                 //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//                 //     content: Text("Oops, OTP send failed"),
//                 //   ));
//                 // }
//               },
//               icon: const Text(
//                 'Send OTP',
//                 textAlign: TextAlign.center,
//                 textWidthBasis: TextWidthBasis.parent,
//                 textDirection: TextDirection.ltr,
//                 style: TextStyle(
//                   fontSize: 10,
//                   fontStyle: FontStyle.normal,
//                   color: Colors.purple,
//                 ),
//               ),
//             ),