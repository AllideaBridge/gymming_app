import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../common//colors.dart';

class ProfileImg extends StatefulWidget {
  final List<String> imgList;

  const ProfileImg({super.key, required this.imgList});

  @override
  State<ProfileImg> createState() => _ProfileImgState();
}

class _ProfileImgState extends State<ProfileImg> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 390,
      child: Stack(
        children: [
          sliderWidget(),
          sliderTopIndicator(),
          sliderBottomIndicator()
        ],
      ),
    );
  }

  Widget sliderWidget() {
    return CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          height: 390,
          aspectRatio: 1,
          enableInfiniteScroll: false,
          viewportFraction: 1.0,
          autoPlay: false,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          },
        ),
        items: widget.imgList.map((String imageUrl) {
          return Builder(builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(imageUrl), fit: BoxFit.contain)));
          });
        }).toList());
  }

  Widget sliderBottomIndicator() {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.imgList.asMap().entries.map((entry) {
            return Container(
                width: 6,
                height: 6,
                margin:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white
                      .withOpacity(_current == entry.key ? 1.0 : 0.4),
                ));
          }).toList(),
        ));
  }

  Widget sliderTopIndicator() {
    return Align(
        alignment: Alignment.topRight,
        child: Container(
          width: 50,
          height: 22,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: INDICATOR_COLOR.withOpacity(0.4),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Text('${_current + 1} / ${widget.imgList.length}',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
        ));
  }
}
