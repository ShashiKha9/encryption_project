import 'dart:convert';

import 'package:encryption_project/model/login.dart';
import 'package:encryption_project/myencryptdecrypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HomeScreenPage extends StatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  State<HomeScreenPage> createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {

  List<Login>login=[];
  final nameController = TextEditingController();
  final passController = TextEditingController();
  var encryptedText;
  // final ValueNotifier<Function> notifier= ValueNotifier(readLogin());
   var box = Hive.box<Login>("login");

  @override
  void initState(){
    setState((){
      readLogin();
      super.initState();
    });

  }


  void dispose(){
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Encryption/Decryption"),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.name,
              controller: nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black,width: 3.0)
                ),
                hintText: "Name",
                prefixIcon: Icon(Icons.person),
                contentPadding: EdgeInsets.all(20)
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              keyboardType: TextInputType.visiblePassword,
              controller: passController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.black,width: 3.0)
                  ),
                  hintText: "Password",
                  prefixIcon: Icon(Icons.password_outlined),
                  contentPadding: EdgeInsets.all(20)
              ),

            ),
          ),
          ElevatedButton(onPressed: (){
            setState((){
              encryptedText=MyEncryptDecyprt.encryptAes(passController.text);
              print(encryptedText.toString());

              addLogin();
            });
          },
              child: Text("Encrypt")),

          ElevatedButton(onPressed: (){
            setState((){
              encryptedText=MyEncryptDecyprt.decryptAes(encryptedText);
              print("sample 1");
            });
          },
              child: Text("Decrypt")),
          Expanded(
               child: ListView.builder(
                        itemCount: login.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(login[index].name),
                            subtitle: Text(login[index].password),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                setState((){
                                  box.deleteAt(index);
                                });
                              },
                            ),
                        );

                }
            ),
             ),

        ],
      ),
    );
  }
  void addLogin(){
    final login=Login(
      name: nameController.text,
      password: passController.text
    );
    box.add(login);

  }
  readLogin(){
    final box = Hive.box<Login>("login");
    login=box.values.toList();
    // print(login);
  }

  void editLogin(Login login,String name ,String password){
    login.name=name;
    login.password=password;

    login.save();

  }
  void deleteLogin(Login login){
    login.delete();

  }
}
