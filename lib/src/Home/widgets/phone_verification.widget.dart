import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../example.dart';

class PhoneNumberVerificationWidget extends StatefulWidget {
  const PhoneNumberVerificationWidget({Key? key}) : super(key: key);
  static const routeName = '/PhoneNumberVerificationWidget';

  @override
  State<PhoneNumberVerificationWidget> createState() =>
      _PhoneNumberVerificationWidgetState();
}

class _PhoneNumberVerificationWidgetState
    extends State<PhoneNumberVerificationWidget> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  var phone = '';
  @override
  void initState() {
    countryController.text = '+91';
    super.initState();
  }

  bool _isLoading = false;
  bool enableButton = false;

  @override
  void dispose() {
    countryController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          icon: const Icon(
            Icons.cancel,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/phone_verifciation_image.png',
                  height: size.height * 0.3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      "Enter your Phone Number",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: const [
                    Text(
                      ' we will send you one Time Code on your phone number',
                      style: TextStyle(fontSize: 15, color: Colors.black45),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextFormField(
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(
                          fontSize: 33,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 300,
                        child: TextFormField(
                          // maxLength: 10,
                          controller: phoneController,
                          onChanged: (value) {
                            if (value.length == 10) {
                              setState(
                                () {
                                  enableButton = true;
                                  phone = value;
                                },
                              );
                            } else {
                              enableButton = false;
                            }
                          },
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Phone number",
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: enableButton
                        ? () async {
                            if (mounted) {
                              setState(() {
                                _isLoading = true;
                              });
                            }

                            try {
                              await context
                                  .read<AuthProvider>()
                                  .verificationPhone(
                                    context,
                                    countryController.text + phone,
                                  );
                              log(phone.toString());

                              await Future.delayed(
                                const Duration(seconds: 5),
                              );
                            } on FirebaseAuthException catch (error) {
                              debugPrint(
                                error.toString(),
                              );
                            }
                            if (mounted) {
                              setState(
                                () {
                                  _isLoading = false;
                                },
                              );
                            }
                          }
                        : null,
                    child: _isLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ),
                          )
                        : const Text("Send the code"),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    phoneController.clear();
                  },
                  child: const Text('Cancel'),
                ),
                // const Spacer(
                //   flex: 1,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
