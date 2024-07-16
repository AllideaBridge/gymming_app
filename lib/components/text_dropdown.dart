import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../common/colors.dart';

class TextDropdown extends StatefulWidget {
  //상단의 제목
  final String? title;

  //플레이스홀더
  final String placeholder;

  //필수값 표시 여부
  final bool isRequired;

  //드롭다운 목록
  final List<String> dropdownItems;

  //선택된 값 부모 컴포넌트에 저장하는 메소드
  final Function setter;

  //기본 저장된 값
  final String originValue;

  final double dropdownWidth;

  const TextDropdown({
    super.key,
    this.title,
    this.placeholder = '선택하세요',
    this.isRequired = false,
    this.dropdownWidth = double.infinity,
    this.originValue = '',
    required this.dropdownItems,
    required this.setter,
  });

  @override
  State<TextDropdown> createState() => _TextDropdownState();
}

class _TextDropdownState extends State<TextDropdown> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedItem;
  bool _isOpen = false;
  bool _isValid = true;

  @override
  void initState() {
    super.initState();
    if (widget.originValue != "") {
      setState(() {
        _selectedItem = widget.originValue;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.dropdownWidth,
      child: Form(
        key: _formKey,
        child: Column(children: [
          if (widget.title != null)
            inputFieldTitle(widget.title!, widget.isRequired),
          DropdownButtonHideUnderline(
            child: DropdownButtonFormField2<String>(
              isExpanded: true,
              value: _selectedItem,
              hint: Text(
                widget.placeholder,
                style: TextStyle(
                  fontSize: 20,
                  color: TERITARY_COLOR,
                  fontWeight: FontWeight.w500,
                ),
              ),
              items: widget.dropdownItems
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return '드롭다운을 선택해 주세요.';
                }
                return null;
              },
              onChanged: (String? value) {
                setState(() {
                  _selectedItem = value;
                  widget.setter(_selectedItem);
                  _isValid = _formKey.currentState!.validate();
                });
              },
              onMenuStateChange: (bool isOpen) {
                setState(() {
                  _isOpen = isOpen;
                  if (!isOpen) {
                    _isValid = _formKey.currentState!.validate();
                  }
                });
              },
              decoration: InputDecoration.collapsed(hintText: ''),
              buttonStyleData: ButtonStyleData(
                  height: 52,
                  padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: getBorderColor(), width: 2)),
                  )),
              dropdownStyleData: DropdownStyleData(
                  offset: const Offset(0, -8),
                  scrollPadding: EdgeInsets.all(4),
                  padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                  maxHeight: 200.0,
                  decoration: BoxDecoration(
                      color: BACKGROUND_COLOR,
                      border: Border.all(width: 1, color: PRIMARY_COLOR),
                      borderRadius: BorderRadius.all(Radius.circular(4)))),
              iconStyleData: IconStyleData(
                  icon: Icon(_isOpen
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded),
                  iconSize: 24),
              menuItemStyleData:
                  const MenuItemStyleData(height: 40, padding: EdgeInsets.zero),
            ),
          )
        ]),
      ),
    );
  }

  Color getBorderColor() {
    if (_isValid) {
      return _isOpen ? PRIMARY_COLOR : SECONDARY_COLOR;
    }
    return Colors.red[700]!;
  }

  Widget inputFieldTitle(String title, bool required) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            SizedBox(
              width: 2,
            ),
            Text(
              required ? '*' : '',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: PRIMARY2_COLOR),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        )
      ],
    );
  }
}
