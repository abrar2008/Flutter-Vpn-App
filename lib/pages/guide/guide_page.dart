import 'package:flutter/material.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/constant/app_dimens.dart';
import 'package:sail_app/constant/app_images.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> {
  var guides = [AppImages.GUIDE_1, AppImages.GUIDE_2, AppImages.GUIDE_3];
  var _showButton = false;

  @override
  Widget build(BuildContext context) {
    UserModel().setIsFirst(false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            _guideWidget(),
            Positioned(
                right: ScreenUtil().setWidth(30),
                bottom: ScreenUtil().setHeight(30),
                child: Offstage(
                  offstage: !_showButton,
                  child: Center(
                      child: FlatButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(30))),
                        color: AppColors.THEME_COLOR,
                        textColor: Colors.black87,
                        onPressed: () {
                          NavigatorUtil.goHomePage(context);
                        },
                        child: Text("Next",
                            style: TextStyle(fontSize: AppDimens.BIG_TEXT_SIZE)),
                      )),
                )),
          ],
        ));
  }

  Widget _guideWidget() {
    return Swiper(
      itemCount: guides.length,
      
      scrollDirection: Axis.horizontal,
  
      itemBuilder: (BuildContext context, int index) {
        return Image.asset(
          guides[index],
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
        );
      },
      autoplay: false,
     
      loop: false,
     
      pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            activeColor: Color(0xFFFF5722), //选中的颜色
            color: Color(0xFF999999), //非选中的颜色
          )),
      onIndexChanged: ((value) {
 
        if (value == guides.length - 1) {
          setState(() {
            _showButton = true;
          });
        } else if (_showButton && value != guides.length - 1) {
         
          setState(() {
            _showButton = false;
          });
        }
      }),
    );
  }
}
