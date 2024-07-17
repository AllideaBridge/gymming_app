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
  final Function? validator;
  final Function onValidationChanged;

  const InputField({
    super.key,
    required this.controller,
    required this.title,
    required this.onValidationChanged,
    this.placeHolder = '입력하세요.',
    this.isRequired = false,
    this.type = TextInputType.text,
    this.validator,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  final FocusNode _focusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_validateForm);
  }

  void _validateForm() {
    bool isValid = _formKey.currentState?.validate() ?? false;
    widget.onValidationChanged(isValid);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateForm);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      onChanged: _validateForm,
      child: Column(
        children: [
          _buildTitle(),
          SizedBox(height: 8.0),
          _buildTextFormField(widget.validator),
        ],
      ),
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
      children.add(SizedBox(width: 2.0));
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

  Widget _buildTextFormField(validator) {
    return TextFormField(
      validator: validator,
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
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
    );
  }
}
