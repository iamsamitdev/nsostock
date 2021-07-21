import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
// import 'package:nsostock/screens/login/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final introKey = GlobalKey<IntroductionScreenState>();

  // ฟังก์ชันเมื่อแสดง slide ถึงหน้าสุดท้าย
  void _onIntroEnd(context) {
    // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
    Navigator.pushNamed(context, '/login');
  }

  // สร้างฟังก์ชันเก็บ path รูป
  Widget _buildImage(String assetName){
    return Align(
      child: Image.asset('assets/images/onboarding/$assetName.jpg', width: 350.0,),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "จัดสรรเงินออมของคุณ",
          body: "เริ่มต้นจัดการเงินออมกับเราได้ง่ายๆ",
          image: _buildImage('onboard1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Learn as you go",
          body:
              "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('onboard2'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Kids and teens",
          body:
              "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('onboard3'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('onboard4'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "เพื่ออนาคตที่ดีกว่า",
          bodyWidget: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("เริ่มต้นตั้งแต่วันนี้เพื่ออนาคตที่ดีกว่า", style: bodyStyle),
            ],
          ),
          image: _buildImage('onboard5'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('ข้าม'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('เริ่มใช้งาน', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
    
  }
}