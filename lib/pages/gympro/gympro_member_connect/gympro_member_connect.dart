import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:gymming_app/components/common_header.dart';
import 'package:gymming_app/components/input_filed.dart';
import 'package:gymming_app/components/modals/basic_modal.dart';
import 'package:gymming_app/components/profile_card.dart';
import 'package:gymming_app/pages/gympro/gympro_home/gympro_home.dart';
import 'package:gymming_app/services/models/trainer_user_detail.dart';
import 'package:gymming_app/services/repositories/trainer_user_repository.dart';
import 'package:provider/provider.dart';

import '../../../state/info_state.dart';

class GymproMemberConnect extends StatefulWidget {
  final int userId;
  final TrainerUserDetail trainerUserDetail;
  final bool isEdit;

  const GymproMemberConnect(
      {super.key,
      required this.userId,
      required this.trainerUserDetail,
      required this.isEdit});

  @override
  State<StatefulWidget> createState() => GymproMemberConnectState();
}

class GymproMemberConnectState extends State<GymproMemberConnect> {
  final TextEditingController _countController = TextEditingController();
  final TextEditingController _infoController = TextEditingController();
  final Map<String, dynamic> _model = {
    'count': '',
    'workDay': [],
    'info': '',
  };
  late bool _enableBtn = false;

  final List<String> _buttonLabels = ["일", "월", "화", "수", "목", "금", "토", "불규칙"];
  late List<bool> _selectedButtons;

  @override
  void initState() {
    super.initState();

    if (!widget.isEdit) {
      _selectedButtons = List<bool>.filled(_buttonLabels.length, false);
    } else {
      _infoController.text = widget.trainerUserDetail.specialNotes;
      _selectedButtons =
          _convertDaysStringToBoolList(widget.trainerUserDetail.exerciseDays);

      _model['info'] = _infoController.text;
    }
    _model['workDay'] = _selectedButtons;

    _validate();
  }

  @override
  void dispose() {
    _countController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  void onChangedCount(bool isValid) {
    setState(() {
      _model['count'] = _countController.text;
    });
    _validate();
  }

  void onSelectWorkDay(int index) {
    if (index == 7) {
      setState(() {
        _selectedButtons = List<bool>.filled(8, false);
        _selectedButtons[7] = true;
      });
    } else {
      setState(() {
        _selectedButtons[index] = !_selectedButtons[index];
        _selectedButtons[7] = false;
      });
    }
    _model['workDay'] = _selectedButtons;
    _validate();
  }

  void onChangedInfo(bool isValid) {
    setState(() {
      _model['info'] = _infoController.text;
    });
  }

  void _validate() {
    bool isValidWorkDay = _model['workDay'].any((data) => data == true);
    bool isValidCount = _model['count'] != '';

    setState(() {
      _enableBtn = isValidWorkDay && (widget.isEdit || isValidCount);
    });
  }

  void _showModal() {
    showDialog(
        context: context,
        barrierColor: Colors.black.withOpacity(0.7),
        builder: (context) => BasicModal(
              type: 'alert',
              title: '회원을 등록하시겠습니까?',
              content: Text(
                '등록하려는 회원의 정보가 정확한지 확인해주세요.',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onConfirm: () async {
                await _connectMember();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => GymproHome()),
                  (Route<dynamic> route) => false,
                );
              },
              onCancel: () {
                Navigator.pop(context);
              },
            ));
  }

  void _updateUser() async {
    String selectedLabel = _buttonLabels
        .asMap()
        .entries
        .where((entry) => _model['workDay'][entry.key])
        .map((entry) => entry.value)
        .join(',');

    Map<String, dynamic> body = {
      'lesson_total_count': widget.trainerUserDetail.lessonTotalCount,
      'lesson_current_count': widget.trainerUserDetail.lessonCurrentCount,
      'exercise_days': selectedLabel,
      'special_notice': _model['info'],
    };
    await TrainerUserRepository().updateTrainerUser(
        Provider.of<InfoState>(context, listen: false).trainerId!,
        widget.userId,
        body);
    Navigator.pop(context);
  }

  Future<void> _connectMember() async {
    String selectedLabel = _buttonLabels
        .asMap()
        .entries
        .where((entry) => _model['workDay'][entry.key])
        .map((entry) => entry.value)
        .join(',');

    Map<String, Object> body = {
      'user_name': widget.trainerUserDetail.name,
      'phone_number': widget.trainerUserDetail.phoneNumber,
      'lesson_total_count': int.parse(_model['count']),
      'lesson_current_count': int.parse(_model['count']),
      'exercise_days': selectedLabel,
      'special_notice': _model['info'],
    };
    await TrainerUserRepository().connectTrainerUser(
        Provider.of<InfoState>(context, listen: false).trainerId!, body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CommonHeader(
                title: widget.isEdit ? '회원 정보 수정' : '새로운 회원 등록',
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
            if (!widget.isEdit)
              ProfileCard(
                imgUrl: widget.trainerUserDetail.userProfileImgUrl,
                name: widget.trainerUserDetail.name,
                birth: widget.trainerUserDetail.birthday,
                gender: widget.trainerUserDetail.gender,
                phoneNumber: widget.trainerUserDetail.phoneNumber,
              ),
            // FutureBuilder(
            //   future: UserRepository(client: http.Client())
            //       .getUserDetail(widget.userId),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return CircularProgressIndicator();
            //     } else if (snapshot.hasError) {
            //       return Text('Error: ${snapshot.error}',
            //           style: TextStyle(color: Colors.white));
            //     } else {
            //       userDetail = snapshot.data!;
            //       return ProfileCard(
            //         imgUrl: userDetail['user_profile_img_url'],
            //         name: userDetail['user_name'],
            //         birth: DateTime.parse(userDetail['user_birthday']),
            //         gender: userDetail['user_gender'],
            //         phoneNumber: userDetail['user_phone_number'],
            //       );
            //     }
            //   },
            // ),
            if (!widget.isEdit) SizedBox(height: 60.0),
            if (!widget.isEdit)
              InputField(
                controller: _countController,
                title: '등록 횟수',
                validator: (val) {
                  if (val.length < 1) return '등록 횟수는 필수값입니다.';
                },
                onValidationChanged: onChangedCount,
                isRequired: true,
              ),
            SizedBox(height: 60.0),
            _buildTitle(),
            SizedBox(height: 16.0),
            _buildWorkDayButton(),
            SizedBox(height: 60.0),
            InputField(
              controller: _infoController,
              title: '특이사항',
              onValidationChanged: onChangedInfo,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Row(
      children: [
        Text(
          '운동일',
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        SizedBox(width: 2.0),
        Text(
          '*',
          style: TextStyle(
            fontSize: 18.0,
            color: PRIMARY2_COLOR,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkDayButton() {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 2,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            backgroundColor:
                _selectedButtons[index] ? PRIMARY_COLOR : BTN_COLOR,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          onPressed: () => onSelectWorkDay(index),
          child: Text(
            _buttonLabels[index],
            style: TextStyle(
              color: _selectedButtons[index] ? Colors.black : Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      },
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
            widget.isEdit ? _updateUser() : _showModal();
          } else {
            null;
          }
        },
        child: Text(
          widget.isEdit ? "수정 완료" : "새로운 회원 등록",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  List<bool> _convertDaysStringToBoolList(String daysString) {
    List<bool> result = List.filled(_buttonLabels.length, false);

    List<String> daysList =
        daysString.split(',').map((day) => day.trim()).toList();

    for (String day in daysList) {
      int index = _buttonLabels.indexOf(day);
      if (index != -1) {
        result[index] = true;
      }
    }
    return result;
  }
}
