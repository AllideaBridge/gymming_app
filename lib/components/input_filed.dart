import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final String placeHolder;
  final bool isRequired;

  /*
  type
    - TextInputType.text: 텍스트 형식
    - TextInputType.number: 숫자 형식
    - TextInputType.emailAddress: 이메일 형식
   */
  final TextInputType type;

  const InputField({
    super.key,
    required this.controller,
    required this.title,
    this.placeHolder = '입력하세요.',
    this.isRequired = false,
    this.type = TextInputType.text,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitle(),
        _buildTextField(),
      ],
    );
  }

  Widget _buildTitle() {
    List<Widget> children = [
      Text(
        widget.title,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
    ];
    if (widget.isRequired) {
      children.add(Text(
        '*',
        style: TextStyle(
          fontSize: 18.0,
          color: PRIMARY2_COLOR,
        ),
      ));
    }

    return Row(
      children: children,
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: widget.controller,
      focusNode: _focusNode,
      style: TextStyle(
        color: Colors.white,
      ),
      keyboardType: widget.type,
      decoration: InputDecoration(
        hintText: widget.placeHolder,
        hintStyle: TextStyle(color: TERITARY_COLOR),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: SECONDARY_COLOR,
            width: 2.0,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: PRIMARY_COLOR,
            width: 2.0,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: 11,
          horizontal: 8,
        ),
      ),
    );
  }
}
