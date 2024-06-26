import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gymming_app/common/colors.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  final double size;
  final XFile? originImgUrl;

  const ProfileImage({super.key, required this.size, this.originImgUrl});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final ImagePicker picker = ImagePicker();
  XFile? _profileImg;

  @override
  void initState() {
    super.initState();
    _profileImg = widget.originImgUrl;
  }

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _profileImg = XFile(pickedFile.path);
      });
      // TODO: 이미지 서버에 전송 & DB 값 변경 API 호출
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.size,
          height: widget.size,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.size / 2),
              child: buildImage(_profileImg)),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return buildBottomSheet();
                },
                backgroundColor: BACKGROUND_COLOR,
              );
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: Icon(
                Icons.camera_alt_outlined,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildImage(XFile? imgUrl) {
    if (imgUrl == null) {
      return Container(color: TERITARY_COLOR);
    } else {
      return Image.file(File(imgUrl.path), fit: BoxFit.cover);
    }
  }

  Widget buildBottomSheet() {
    return Wrap(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          child: Column(
            children: [
              SizedBox(
                height: 20.0,
              ),
              ListTile(
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                title: Text("카메라로 촬영", style: TextStyle(color: Colors.white)),
              ),
              Container(height: 1, color: BORDER_COLOR),
              ListTile(
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                title:
                    Text("갤러리에서 가져오기", style: TextStyle(color: Colors.white)),
              ),
              Container(height: 1, color: BORDER_COLOR),
              ListTile(
                onTap: () {
                  setState(() {
                    _profileImg = null;
                  });
                  Navigator.pop(context);
                },
                title: Text("프로필 사진 삭제", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
