import 'package:dappwallet/data/base/perferance.dart';
import 'package:dappwallet/utils/export.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intoduction extends StatefulWidget {
  const Intoduction({Key? key}) : super(key: key);

  @override
  State<Intoduction> createState() => _IntoductionState();
}

class _IntoductionState extends State<Intoduction> {
  PageController controller = PageController();
  int _currntpage = 0;

  @override
  void initState() {
    //  getdata();
    super.initState();
  }

  getdata() async {
    String login =
        await SharedPreferenceClass.GetSharedData(AppContant.LOGINSTAUS);
    if (login.toString() == "true") {
      Get.toNamed(AppRoute.bottomNavigationBar);
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: height(context) * 0.65,
              margin: EdgeInsets.only(top: height(context) * 0.15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height(context) * 0.08,
                  ),
                  SizedBox(
                    height: height(context) * 0.5,
                    child: PageView(
                      controller: controller,
                      allowImplicitScrolling: true,
                      children: [
                        _pagewidget(
                            Appimages.Into1, "Private and Secure", context),
                        _pagewidget(
                            Appimages.Into1, "Private and Secure", context),
                        _pagewidget(
                            Appimages.Into1, "Private and Secure", context),
                      ],
                      onPageChanged: (value) {
                        setState(() {
                          _currntpage = value;
                        });
                      },
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: ExpandingDotsEffect(
                        activeDotColor: Theme.of(context).primaryColor,
                        dotColor: Theme.of(context).primaryColor,
                        dotWidth: 8,
                        expansionFactor: 3.5,
                        dotHeight: 8),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: height(context) * 0.04,
            ),
            CustomButton(
              width: width(context),
              height: height(context) * 0.05,
              colors: Theme.of(context).primaryColor,
              onTap: () {
                Get.toNamed(AppRoute.createWallet);
              },
              text: "Create a new wallet",
              textcolor: Theme.of(context).hintColor,
              margin: EdgeInsets.only(left: 10, right: 10),
            ),
            SizedBox(
              height: height(context) * 0.015,
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed(AppRoute.importWallet);
                },
                child: Text(
                  "I already have a wallet",
                  style: TextStyle(
                      color: Theme.of(context).canvasColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ))
          ],
        ),
      ),
    );
  }

  _pagewidget(String image, String title, BuildContext context) {
    return Column(
      children: [
        CustomImageView(
          width: width(context),
          height: height(context) * 0.4,
          imagePath: image,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          "$title",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
        )
      ],
    );
  }
}
