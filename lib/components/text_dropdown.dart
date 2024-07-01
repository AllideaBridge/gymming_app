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
  String? _selectedItem;
  IconData _dropdownIcon = Icons.keyboard_arrow_down_rounded;

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
    return Column(children: [
      if (widget.title != null)
        inputFieldTitle(widget.title!, widget.isRequired),
      DropdownButtonHideUnderline(
        child: DropdownButton2<String>(
          isExpanded: true,
          hint: Text(
            widget.placeholder,
            style: TextStyle(
              fontSize: 16,
              color: TERITARY_COLOR,
            ),
          ),
          items: widget.dropdownItems
              .map((String item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          value: _selectedItem,
          onChanged: (String? value) {
            setState(() {
              _selectedItem = value;
              widget.setter(_selectedItem);
            });
          },
          onMenuStateChange: (bool isOpen) {
            setState(() {
              _dropdownIcon = isOpen
                  ? Icons.keyboard_arrow_up_rounded
                  : Icons.keyboard_arrow_down_rounded;
            });
          },
          buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: 16),
              height: 40,
              width: widget.dropdownWidth,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: SECONDARY_COLOR, width: 2)),
              )),
          dropdownStyleData: DropdownStyleData(
              padding: EdgeInsets.all(12),
              maxHeight: 200.0,
              decoration: BoxDecoration(
                  color: BACKGROUND_COLOR,
                  border: Border.all(width: 2, color: PRIMARY_COLOR),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12)))),
          iconStyleData: IconStyleData(icon: Icon(_dropdownIcon), iconSize: 20),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
          ),
        ),
      )
    ]);
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
