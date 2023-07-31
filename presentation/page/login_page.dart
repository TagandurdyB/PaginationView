// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../config/constants/rout.dart';
import '../../config/services/keyboard.dart';
import '../../config/constants/tags.dart';
import '../../data/models/basic/user_model.dart';
import '../../logic/register_provider.dart';
import '../widget/ReadyInput/login_arzan_input.dart';
import '../widget/ReadyInput/ready_input_base.dart';
import '../widget/btns_group.dart';
import '../widget/my_pop_widget.dart';

// import '../../../config/routes/my_rout.dart';
// import '../../../config/services/keyboard.dart';
// import '../../../config/vars/constants.dart';
// import '../../../domain/entities/user_entity.dart';
// import '../../providers/user_provider.dart';
// import '../widgets/ReadyInput/login_arzan_input.dart';
// import '../widgets/ReadyInput/ready_input_base.dart';
// import '../widgets/btns_group.dart';
// import '../widgets/my_pop_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  late BuildContext context;
  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: buildContent()),
    );
  }

  bool isPressBefore = false;

  String? _nameValid() {
    // if (isPressBefore) {
    //   if (RIBase.getText(Tags.rIUserPhone).length < 8) {
    //     //return "Enter min 7 char at Name";
    //     return "";
    //   }
    // }
    return null;
  }

  Widget buildContent() {
    return Column(
      children: [
        const SizedBox(height: 20),
        CoolInputs(
          validator: (String? value) => _nameValid(),
          tag: Tags.rIUserPhone,
          iconD: Icons.phone,
          label: "Telefon belgi",
          hidden: "Telefon belgi",
          type: TextInputType.phone,
        ),
        const SizedBox(height: 20),
        CoolInputs(
          validator: (String? value) => _nameValid(),
          tag: Tags.rIPass,
          iconD: Icons.vpn_key_outlined,
          label: "Açar sözi",
          hidden: "Açar sözi",
          type: TextInputType.visiblePassword,
        ),
        const SizedBox(height: 20),
        buildSign(),
        const SizedBox(height: 30),
        SuccessBtn(
          iconD: Icons.forward,
          onTap: _next,
          text: "Let's Start",
        ),
      ],
    );
  }

  void _next() {
    Keyboard.close(context);
    MyPopUpp.popLoading(context);
    RegisterP.of(context, listen: false)
        .login( UserModel(
      phone: "+993${RIBase.getText(Tags.rIUserPhone)}",
      pass: RIBase.getText(Tags.rIPass),
    ))
        .then((response) {
      MyPopUpp.popMessage(context, () {
        Navigator.popAndPushNamed(context, Rout.home);
      }, response.message, !response.status);
      // TostService.message(response.message, response.status);
      // if (response.status) {
      //   Future.delayed(const Duration(seconds: 3))
      //       .then((value) => Navigator.popAndPushNamed(context, Rout.home));
      // }
    });
  }

  Widget buildSign() {
    return TextButton(
        onPressed: () {
          // Navigator.popAndPushNamed(context, Rout.register);
        },
        child: const Text("Sign Up"));
  }
}
