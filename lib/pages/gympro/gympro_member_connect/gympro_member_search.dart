import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/phone_number_select.dart';
import 'package:gymming_app/pages/gympro/gympro_member_connect/gympro_member_connect.dart';
import 'package:gymming_app/services/repositories/user_repository.dart';
import 'package:gymming_app/services/utils/toast_util.dart';
import 'package:gymming_app/services/utils/validate_util.dart';
import 'package:http/http.dart' as http;

import '../../../services/models/trainer_user_detail.dart';

class GymproMemberSearch extends StatefulWidget {
  const GymproMemberSearch({super.key});

  @override
  State<StatefulWidget> createState() => GymproMemberSearchState();
}

class GymproMemberSearchState extends State<GymproMemberSearch> {
  final userRepository = UserRepository(client: http.Client());

  late FToast fToast;
  final TextEditingController _nameController = TextEditingController();
  final Map<String, dynamic> _model = {
    'name': '',
    'phoneNumber': '',
  };
  late bool _enableBtn = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void onChangedName(bool isValid) {
    setState(() {
      _model['name'] = _nameController.text;
    });
    _validate();
  }

  void onChangedPhoneNumber(String phoneNumber) {
    setState(() {
      _model['phoneNumber'] = phoneNumber;
    });
    _validate();
  }

  void _validate() {
    if (_model['name'] != '' &&
        ValidateUtil.isPhoneNumberValid(_model['phoneNumber'])) {
      setState(() {
        _enableBtn = true;
      });
    } else {
      _enableBtn = false;
    }
  }

  void _searchMember() async {
    final result = await userRepository.checkUserExist(
        _model['name'], _model['phoneNumber']);

    /**
     * result 예시 :

        {
        user_id: 5,
        user_email: null,
        user_name: asd,
        user_gender: M,
        user_phone_number: 010-1111-1111,
        user_profile_img_url: null,
        user_delete_flag: false,
        user_birthday: null
        }

        or

        null
     */

    print(result);

    if (result != null) {
      _moveNextStep(result);
    } else {
      _showToast('회원을 찾을 수 없습니다.');
    }
  }

  void _moveNextStep(Map<String, dynamic> user) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => GymproMemberConnect(
                userId: user['id'],
                trainerUserDetail: TrainerUserDetail.fromJson(user),
                isEdit: false,
              )),
    );
  }

  void _showToast(msg) {
    fToast.showToast(
        child: ToastUtil.defaultToast(msg),
        toastDuration: Duration(seconds: 1),
        positionedToastBuilder: (context, child) {
          return Positioned(
            bottom: 176.0,
            left: 0,
            right: 0,
            child: child,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(
                title: '새로운 회원 등록',
                onPressed: () {
                  Navigator.pop(context);
                }),
            Expanded(
              child: SingleChildScrollView(
                child: _buildBody(),
              ),
            ),
            _buildButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            InputField(
              controller: _nameController,
              title: '회원 이름',
              validator: (val) {
                if (val.length < 1) return '회원 이름은 필수값입니다.';
              },
              onValidationChanged: onChangedName,
              isRequired: true,
            ),
            SizedBox(height: 60.0),
            PhoneNumberSelect(
              title: '연락처',
              setter: onChangedPhoneNumber,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 40.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              _enableBtn ? PRIMARY_COLOR : PRIMARY_COLOR.withOpacity(0.3),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          minimumSize: const Size.fromHeight(56),
        ),
        onPressed: () {
          if (_enableBtn) {
            _searchMember();
          } else {
            null;
          }
        },
        child: Text(
          "회원 정보 조회",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
