import 'package:flutter/material.dart';


class MutableUserInfoContainer extends StatefulWidget {
  final TextEditingController controller;
  final String label;

  const MutableUserInfoContainer({
    super.key,
    required this.controller,
    required this.label,
  });

  @override
  State<MutableUserInfoContainer> createState() => _MutableUserInfoContainerState();

}

class _MutableUserInfoContainerState extends State<MutableUserInfoContainer> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 55,
      width: 300,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF757575))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: TextStyle(
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

  return MutableUserInfoContainer(
      controller: passwordController,
      label: "비밀번호"
  );
}


Widget userPasswordConfirmationContainer(ControllerCallback controllerCallback){
  TextEditingController passwordConfirmationController = TextEditingController();

  controllerCallback(passwordConfirmationController);

  return MutableUserInfoContainer(
      controller: passwordConfirmationController,
      label: "비밀번호 재확인"
  );
}

Widget userAddressContainer(ControllerCallback controllerCallback){
  TextEditingController addressController = TextEditingController();

  controllerCallback(addressController);

  return MutableUserInfoContainer(
      controller: addressController,
      label: "주소"
  );
}

