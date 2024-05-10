import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfict_ui_login/Ui/Auth/signup_screen.dart';
import 'package:perfict_ui_login/Utils/utils.dart';
import 'package:perfict_ui_login/Widgets/round_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  //////this for empty if text field empty hongi to show krdy k fill kro
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
////textfield sy data  lyny kele r save krny kele data base min na k data firestore min
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void Login() {
    setState(() {
      loading = true;
    });

    try {
      auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString());
    } on FirebaseAuthException catch (e) {
      Utils().toastMassage(e.toString());
      print(
          "_________________________ exception catch here-----------------$e");
      // if (e is FirebaseAuthException) {
      //   // Firebase Authentication error
      //   if (e.code == 'user-not-found') {
      //     print(
      //         "_________________________ exception catch here-----------------$e");
      //     // Handle user not found error
      //   } else if (e.code == 'wrong-password') {
      //     print(
      //         "_________________________ exception catch here-----------------$e");
      //     // Handle wrong password error
      //   } else if (e.code == '[firebase_auth/unknown]') {
      //     print(
      //         "_________________________ exception catch here-----------------$e");
      //   } else {
      //     // Handle other Firebase Authentication errors
      //     print(
      //         "_________________________ exception catch here-----------------$e");
      //   }
      // } else {
      //   // Handle non-Firebase Authentication errors
      //   print('An unexpected error occurred: $e');
      // }
    }
    // } catch (e) {
    //   print(
    //       "_________________________ exception catch here-----------------$e");
    //   // Handle the exception
    //   if (e.toString() == 'firebase_auth/unknown') {
    //     print(
    //         "_________________________ exception catch here-----------------");
    //     // Handle the specific exception
    //     print(
    //         'The supplied auth credential is incorrect, malformed, or has expired.');
    //
    //     // You can show an error message to the user or perform other actions
    //   } else {
    //     print(
    //         "_________________________ exception catch here-----------------");
    //     // Handle other exceptions
    //     Utils().toastMassage(e.toString());
    //     print('An unexpected error occurred: $e');
    //   }
    //   //  on Exception catch (error) {
    //   //   print("_________________________ exception catch here-----------------");
    //   //   debugPrint(error.toString());
    //   //   Utils().toastMassage(error.toString());
    //   //   setState(() {
    //   //     loading = false;
    //   //   });
    //   //   // TODO
    // }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    //final width = MediaQuery.of(context).size.width;

    //////  willposscop widget is us k jb koi mobile k button sy back kry to y back ho jay
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          automaticallyImplyLeading: false,
          title: Text(
            "Login Screen",
            style: TextStyle(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.18,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.alternate_email),
                          hintText: "email",
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "password",
                          prefixIcon: Icon(Icons.lock),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.12,
                ),
                RoundButton(
                  title: "LogIn",
                  loading: loading,
                  ontap: () {
                    if (_formKey.currentState!.validate()) {
                      Login();
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont Have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()));
                      },
                      child: Text(
                        "SignUp",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
