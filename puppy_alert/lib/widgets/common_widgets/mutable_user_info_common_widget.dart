import 'package:flutter/material.dart';


class MutableUserInfoCommonWidget extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const MutableUserInfoCommonWidget({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  State<MutableUserInfoCommonWidget> createState() => _MutableUserInfoCommonWidgetState();

}

class _MutableUserInfoCommonWidgetState extends State<MutableUserInfoCommonWidget> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      height: 55,
      width: 300,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF757575))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              letterSpacing: 1.2,
            ),
          ),
          Container(
            height: 15,
            child: TextFormField(
              controller: widget.controller,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 8, right: 8),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

typedef ControllerCallback = void Function(TextEditingController controller);

Widget userPasswordContainer(ControllerCallback controllerCallback){
  TextEditingController passwordController = TextEditingController();

  controllerCallback(passwordController);

  return MutableUserInfoCommonWidget(
      controller: passwordController,
      label: "비밀번호"
  );
}


Widget userPasswordConfirmationContainer(ControllerCallback controllerCallback){
  TextEditingController passwordConfirmationController = TextEditingController();

  controllerCallback(passwordConfirmationController);

  return MutableUserInfoCommonWidget(
      controller: passwordConfirmationController,
      label: "비밀번호 재확인"
  );
}

Widget userAddressContainer(ControllerCallback controllerCallback){
  TextEditingController addressController = TextEditingController();

  controllerCallback(addressController);

  return MutableUserInfoCommonWidget(
      controller: addressController,
      label: "주소"
  );
}

