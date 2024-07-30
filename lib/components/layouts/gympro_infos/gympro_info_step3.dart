import 'package:flutter/material.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/components/text_dropdown.dart';
import 'package:gymming_app/services/utils/validate_util.dart';

class GymproInfoStep3 extends StatefulWidget {
  final Function onChanged;
  final Map<String, dynamic>? originModel;

  const GymproInfoStep3({super.key, required this.onChanged, this.originModel});

  @override
  State<StatefulWidget> createState() => GymproInfoStep3State();
}

class GymproInfoStep3State extends State<GymproInfoStep3> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  late Map<String, dynamic> _model = {
    'centerName': '',
    'centerAddress': '',
    'centerContact': '',
    'centerType': '',
  };

  @override
  void initState() {
    super.initState();

    if (widget.originModel != null) {
      setState(() {
        _model = widget.originModel!;
        _nameController.text = _model['centerName'];
        _addressController.text = _model['centerAddress'];
      });
    }

    widget.onChanged(_model);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void onChangedCenterName(bool isValid) {
    setState(() {
      _model['centerName'] = _nameController.text;
    });
    widget.onChanged(_model);
  }

  void onChangedCenterAddress(bool isValid) {
    setState(() {
      _model['centerAddress'] = _addressController.text;
    });
    widget.onChanged(_model);
  }

  void onChangedCenterContact(String contactNumber) {
    if (ValidateUtil.isPhoneNumberValid(contactNumber)) {
      setState(() {
        _model['centerContact'] = contactNumber;
      });
    } else {
      setState(() {
        _model['centerContact'] = '';
      });
    }
    widget.onChanged(_model);
  }

  void onChangedCenterType(String centerType) {
    setState(() {
      _model['centerType'] = centerType;
    });
    widget.onChanged(_model);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InputField(
              controller: _nameController,
              title: '소속 센터',
              validator: (val) {
                if (val.length < 1) return '소속 센터는 필수값입니다.';
              },
              onValidationChanged: onChangedCenterName,
              isRequired: true,
            ),
            SizedBox(height: 60.0),
            InputField(
              controller: _addressController,
              title: '센터 주소',
              validator: (val) {
                if (val.length < 1) return '센터 주소는 필수값입니다.';
              },
              onValidationChanged: onChangedCenterAddress,
              isRequired: true,
            ),
            SizedBox(height: 60.0),
            PhoneNumberSelect(
              title: '센터 연락처',
              setter: onChangedCenterContact,
              originalNumber: _model['centerContact'] == ''
                  ? null
                  : _model['centerContact'],
            ),
            SizedBox(height: 60.0),
            TextDropdown(
              title: '센터 유형',
              originValue: _model['centerType'] ?? '',
              dropdownItems: ['PT 전문 센터', '필라테스', '헬스장', '크로스핏', '기타'],
              setter: onChangedCenterType,
              isRequired: true,
            ),
          ],
        ));
  }
}
