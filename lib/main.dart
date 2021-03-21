import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lesson10/second_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp()));
}

class MyApp extends StatelessWidget {
  var email = '';
  var password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'e-mail'
                      ),
                      onChanged: (v){
                        email = v;
                      },
                    ),
                    SizedBox(height: 15,),
                    TextField(
                      decoration: InputDecoration(
                          hintText: 'password'
                      ),
                      onChanged: (v){
                        password = v;
                      },
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print('Successful registration');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Registration'),
                    ),
                    SizedBox(height: 15,),
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email,
                            password: password,
                          );
                          print('Successful login');
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            print('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            print('Wrong password provided for that user.');
                          }
                        }
                      },
                      child: Text('Login'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context){
                                  return SecondPage();
                                }));
                      },
                      child: Text('Go to remote config'),
                    ),
                    SizedBox(height: 15,),
                  ],
                ),
              ),
            )
        )
    );
  }
}

