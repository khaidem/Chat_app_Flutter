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
    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Phone Verification",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
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
                  Expanded(
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
                              .watch()<AuthProvider>()
                              .verificationPhone(
                                context,
                                countryController.text + phone,
                              );
                          await Future.delayed(
                            const Duration(seconds: 2),
                          );
                        } catch (error) {
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
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text('Cancel'),
            )
          ],
        ),
      ),
    ));
  }
}
