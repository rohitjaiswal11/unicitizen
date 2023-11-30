import 'package:dappwallet/utils/export.dart';

class ErrorScreen extends StatelessWidget {
  double? ht, wh;
  String title;
  ErrorScreen({required this.title, this.ht, this.wh});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomImageView(
          imagePath: Appimages.Nodata,
          height: ht ?? height(context) * 0.3,
          width: wh ?? width(context) * 0.8,
        ),
        SizedBox(
          height: height(context) * 0.01,
        ),
        Text(
          "$title",
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
