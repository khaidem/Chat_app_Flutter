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
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController phoneController = TextEditingController();

  var phone = '';
  @override
  void initState() {
    countryController.text = '+91';
    super.initState();
  }

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
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
                      child: TextField(
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
                        controller: phoneController,
                        onChanged: (value) {
                          phone = value;
                        },
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
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
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }
                    formKey.currentState!.save();
                    try {
                      final veri = context.read<AuthProvider>();
                      veri.verificationPhone(
                          context, countryController.text + phone);
                      await Future.delayed(
                        const Duration(seconds: 2),
                      );
                    } catch (error) {
                      debugPrint(
                        error.toString(),
                      );
                    }
                  },
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
              )
            ],
          ),
        ),
      )),
    );
  }
}
