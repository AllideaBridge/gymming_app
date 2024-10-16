import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gymming_app/components/time_formatter.dart';

import '../common/colors.dart';

class AvailableTime extends StatefulWidget {
  final List<Map<String, dynamic>> availableTime;
  final Function onChanged;

  const AvailableTime(
      {super.key, required this.availableTime, required this.onChanged});

  @override
  State<AvailableTime> createState() => _AvailableTimeState();
}

class _AvailableTimeState extends State<AvailableTime> {
  late List<TextEditingController> _startControllers;
  late List<TextEditingController> _endControllers;
  late List<Map<String, dynamic>> _availableTimeList;

  void _initializeData() {
    _availableTimeList = List.from(widget.availableTime);
    _startControllers = List.generate(
        _availableTimeList.length, (_) => TextEditingController());
    _endControllers = List.generate(
        _availableTimeList.length, (_) => TextEditingController());
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    for (TextEditingController node in _startControllers) {
      node.dispose();
    }
    for (TextEditingController node in _endControllers) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AvailableTime oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.availableTime != widget.availableTime) {
      _initializeData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          buildTitle(),
          SizedBox(height: 8.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _availableTimeList.length,
            itemBuilder: (context, index) {
              return buildRow(index, _availableTimeList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: 36.0,
          child: Text(
            '요일',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 120.0,
          child: Text(
            '시작 시간',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 120.0,
          child: Text(
            '종료 시간',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 36.0,
          child: Text(
            '선택',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  TextStyle _buildTextStyle(bool enable, bool bold) {
    return TextStyle(
        fontSize: 20.0,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: enable ? PRIMARY_COLOR : SECONDARY_COLOR,
        decoration: enable ? null : TextDecoration.lineThrough,
        decorationColor: SECONDARY_COLOR,
        decorationThickness: 1.5);
  }

  Widget buildRow(int index, Map<String, dynamic> item) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 36.0,
          child: Text(
            item['title'],
            style: _buildTextStyle(item['isChecked'], true),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 120.0,
          height: 52.0,
          child: buildTextField(index, 'start', _startControllers[index]),
        ),
        SizedBox(
          width: 120.0,
          height: 52.0,
          child: buildTextField(index, 'end', _endControllers[index]),
        ),
        SizedBox(
          width: 36.0,
          child: Checkbox(
            value: item['isChecked'],
            onChanged: (bool? value) {
              setState(() {
                _availableTimeList[index]['isChecked'] = value;
              });
              widget.onChanged();
            },
          ),
        ),
      ],
    );
  }

  Widget buildTextField(index, type, controller) {
    return TextField(
      onChanged: (value) {
        setState(() {
          _availableTimeList[index][type] = value;
        });
        widget.onChanged();
      },
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        TimeFormatter(),
      ],
      style: _buildTextStyle(_availableTimeList[index]['isChecked'], false),
      decoration: InputDecoration(
        hintText: '00:00',
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
