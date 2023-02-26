import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:todo_app/login/verifycode.dart';

class VerifyWithPhone extends StatefulWidget {
  const VerifyWithPhone({super.key});

  @override
  State<VerifyWithPhone> createState() => _VerifyWithPhoneState();
}

class _VerifyWithPhoneState extends State<VerifyWithPhone> {
 final GlobalKey _key = GlobalKey<FormState>();

    final TextEditingController _PhoneTextController = TextEditingController();
    bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify With Phone'),
        backgroundColor: Color(0xff2e8b6d),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.3, horizontal: 20),
        child: Form(
          key: _key,
          child: Column(children: [
            TextFormField(
                    controller: _PhoneTextController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 13.0, vertical: 14.0),
                      hintText: '+9 235 2210 296',
                      hintStyle: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.black, width: 1.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide:
                            BorderSide(color: Color(0xff2e8b6d), width: 1.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 70,),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(310, 50.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        backgroundColor: Color(0xff2e8b6d),
                      ),
                      onPressed: (() {
                        setState(() {
                          loading = true;
                        });
                        try {
                          FirebaseAuth.instance.verifyPhoneNumber(
                             phoneNumber: _PhoneTextController.text,
                             verificationCompleted: (_){
      
                             },
                             verificationFailed:(e){
                               final snackBar = SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             },
                             codeSent: (String verificationId, int? Token){
                                   Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VerifyCode(VerificationId: verificationId,),
                              ));
                             },
                             codeAutoRetrievalTimeout: (e){
                               final snackBar = SnackBar(content: Text(e.toString()));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                             }
                             );
                         
                        } catch (e) {
                          final snackBar = SnackBar(content: Text(e.toString()));
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          setState(() {
                            loading = false;
                          });
                        }
                      }),
                      child: loading
                          ? CircularProgressIndicator()
                          : Text(
                              'Log in',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            )),
        
          ],),
        ),
        )),
      ),
    );
  }
}