import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class VerifyCode extends StatefulWidget {
  final String VerificationId;
  const VerifyCode({super.key, required this.VerificationId});
  

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  final TextEditingController _PhoneTextController = TextEditingController();
    bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Verify Code'),
        backgroundColor: Color(0xff2e8b6d),
        centerTitle: true,
      ),
    
      body: SingleChildScrollView(
        child: SafeArea(child: Padding(padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.3, horizontal: 20),
        child: Column(
          children: [
            TextFormField(
                    controller: _PhoneTextController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 13.0, vertical: 14.0),
                      hintText: 'Enter Otp',
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
                          final credential = PhoneAuthProvider.credential(verificationId: widget.VerificationId, smsCode: _PhoneTextController.text);
                         
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
                              'Verify',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0,
                              ),
                            )),
          ],
        ),
        )
          ),
      )
    );
  }
}