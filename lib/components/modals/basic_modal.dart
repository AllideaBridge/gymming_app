import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';

class BasicModal extends StatelessWidget {
  final String title;
  final Widget content;
  final VoidCallback onConfirm;

  const BasicModal({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))),
        backgroundColor: BACKGROUND_COLOR,
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(height: 20.0),
                content,
                SizedBox(height: 20.0),
                _buildButton(),
              ],
            )));
  }

  Widget _buildButton() {
    return ElevatedButton(
        onPressed: onConfirm,
        style: ElevatedButton.styleFrom(
          backgroundColor: PRIMARY_COLOR,
          minimumSize: const Size.fromHeight(36),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
        child: Text('확인',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            )));
  }
}
