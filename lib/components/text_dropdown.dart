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

  const TextDropdown({
    super.key,
    this.title,
    this.placeholder = '선택하세요',
    this.isRequired = false,
    required this.dropdownItems,
    required this.setter,
  });

  @override
  State<TextDropdown> createState() => _TextDropdownState();
}

class _TextDropdownState extends State<TextDropdown> {
  String _selectedItem = '';
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (widget.title != null)
        inputFieldTitle(widget.title!, widget.isRequired),
      Column(
        children: [
          buildDropdownBody(),
          if (_isOpen) buildDropdownItemList(),
        ],
      ),
    ]);
  }

  Container buildDropdownItemList() {
    return Container(
      constraints: BoxConstraints(maxHeight: 248),
      margin: EdgeInsets.fromLTRB(0, 11, 0, 0),
      padding: EdgeInsets.fromLTRB(16, 4, 16, 4),
      decoration: BoxDecoration(
          border: Border.all(color: PRIMARY_COLOR),
          borderRadius: BorderRadius.circular(4),
          color: BACKGROUND_COLOR),
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 4.0,
        radius: Radius.circular(10.0),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.dropdownItems.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedItem = widget.dropdownItems[index];
                    widget.setter(_selectedItem);
                    _isOpen = !_isOpen;
                  });
                },
                child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
                    child: Text(widget.dropdownItems[index],
                        style: TextStyle(fontSize: 20, color: Colors.white))),
              );
            }),
      ),
    );
  }

  GestureDetector buildDropdownBody() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isOpen = !_isOpen;
        });
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  color: _isOpen ? PRIMARY_COLOR : SECONDARY_COLOR, width: 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(_selectedItem,
                style: TextStyle(fontSize: 20, color: Colors.white)),
            _isOpen
                ? Image.asset('assets/images/icon_nav_arrow_up.png',
                    width: 20, height: 20)
                : Image.asset('assets/images/icon_nav_arrow_down.png',
                    width: 20, height: 20),
          ],
        ),
      ),
    );
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
