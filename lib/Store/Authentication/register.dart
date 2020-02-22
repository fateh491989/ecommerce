import 'dart:io';

import 'package:ecommerce/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../Authentication/authenication.dart';
import '../Config/config.dart';
import '../Widgets/customTextField.dart';
import '../dialogs/errorDialog.dart';
import '../dialogs/loadingDialog.dart';
import '../homepage.dart';


class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}
final TextEditingController _nameController = TextEditingController();
class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
  TextEditingController();
  String userPhotoUrl = "";
  File _image;

  Future<void> _pickImage() async {
    _image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> uploadImage() async {

    if (_image == null) {
      showDialog(
          context: context,
          builder: (v) {
            return ErrorAlertDialog(
              message: "Please pick an photo",
            );
          });
    } else {

      _passwordController.text == _passwordConfirmController.text
          ? _emailController.text.isNotEmpty &&
          _passwordConfirmController.text.isNotEmpty &&
          _nameController.text.isNotEmpty
          ? upload()
          :
          showMyDialog('Please fill the desired fields')

          : showMyDialog('Password doesn\'t match');

    }
  }
  upload() async {
    showDialog(
        context: context,
        builder: (_) {
          return LoadingAlertDialog();
        });
    String fileName = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    StorageReference reference =
    FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = reference.putFile(_image);
    StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    await storageTaskSnapshot.ref.getDownloadURL().then((url) {
      userPhotoUrl = url;
      print(userPhotoUrl);
      _register();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Register here',
                style: TextStyle(color: Colors.red),
              ),
            ),

            InkWell(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: _screenWidth * 0.15,
                  backgroundColor: Colors.white,
                  backgroundImage: _image==null?null:FileImage(_image),
                  child: _image == null
                      ? Icon(
                    Icons.person_add,
                    size: _screenWidth * 0.15,
                    color: Colors.grey,
                  )
                      : null,
//                        backgroundImage: _image == null
//                            ? AssetImage('assets/images/loading.png')
//                            : FileImage(_image)
                )),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  CustomTextField(
                    data: Icons.person_outline,
                    controller: _nameController,
                    hintText: 'Name',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.person_outline,
                    controller: _emailController,
                    hintText: 'Email',
                    isObsecure: false,
                  ),
                  CustomTextField(
                    data: Icons.lock_outline,
                    controller: _passwordController,
                    hintText: 'Password',
                    isObsecure: true,
                  ),
                  CustomTextField(
                    data: Icons.lock_outline,
                    controller: _passwordConfirmController,
                    hintText: 'Confirm passsword',
                    isObsecure: true,
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                uploadImage();
              },
              color: Colors.redAccent,
              child: Text('Sign up'),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              height: 3,
              width: _screenWidth * 0.8,
              color: Colors.red,
            ),
            SizedBox(
              height: 10,
            ),

          ],
        ),
      ),
    );
  }

//  void _completeRegister() {
//    _passwordController.text == _passwordConfirmController.text
//        ? _emailController.text.isNotEmpty &&
//        _passwordConfirmController.text.isNotEmpty &&
//        _nameController.text.isNotEmpty
//        ? _register()
//        : showDialog(
//        context: context,
//        builder: (con) {
//          return ErrorAlertDialog(
//            message: 'Please fill the desired fields',
//          );
//        })
//        : showDialog(
//        context: context,
//        builder: (con) {
//          return ErrorAlertDialog(
//            message: 'Password doesn\'t match',
//          );
//        });
//  }

  void _register() async {


    FirebaseUser currentUser;
    await _auth
        .createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((error) {
      Navigator.pop(context);
      showDialog(
          context: context,
          builder: (con) {
            return ErrorAlertDialog(
              message: error.message.toString(),
            );
          });
    });
    if (currentUser != null) {
      writeDataToDataBase(currentUser).then((s) {
        Navigator.pop(context);

        Route route = MaterialPageRoute(builder: (context) => StoreHomePage());
        Navigator.pushReplacement(context, route);
      });
    } else {
      //   _success = false;
    }
  }


  Future writeDataToDataBase(FirebaseUser currentUser) async {
    EcommerceApp.firestore
        .collection(EcommerceApp.collectionUser)
        .document(currentUser.uid)
        .setData({
      EcommerceApp.userUID: currentUser.uid,
      EcommerceApp.userEmail: currentUser.email,
      EcommerceApp.userName: _nameController.text,
      EcommerceApp.userAvatarUrl: userPhotoUrl
    });
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userUID, currentUser.uid);
    await EcommerceApp.sharedPreferences.setStringList(EcommerceApp.userCartList, ['garbageValue']);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userEmail, currentUser.email);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userName, _nameController.text);
    await EcommerceApp.sharedPreferences
        .setString(EcommerceApp.userAvatarUrl, userPhotoUrl);
  }

  showMyDialog(String message) {

    showDialog(
        context: context,
        builder: (con) {
          return ErrorAlertDialog(
            message: message,
          );
        });

  }
}
final FirebaseAuth _auth = FirebaseAuth.instance;
