import 'package:flutter/material.dart';

import '../widgets/common_widgets/user_datepicker_widget.dart';

class Test1 extends StatefulWidget {
  @override
  _Test1State createState() => _Test1State();
}

class _Test1State extends State<Test1> {
  TextEditingController _idController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GestureDetector(
        onTap: () {
      FocusScope.of(context).unfocus();
    },
          child: Column(
            children: [
              Text('asdf'),
              ListView(),
            ],
          ),
    ));
  }
}

