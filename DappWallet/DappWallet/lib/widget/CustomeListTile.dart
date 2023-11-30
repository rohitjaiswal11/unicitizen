import 'package:dappwallet/utils/export.dart';

class CustomeListTile extends StatelessWidget {
  String Title;
  String imagepath;
  String? subtitle;
  Widget? prfix;
  EdgeInsetsGeometry? padding;
  bool? tap;
  CustomeListTile(
      {required this.Title,
      required this.imagepath,
      this.subtitle,
      this.tap = true,
      this.padding,
      this.prfix});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (tap == true) {
          Get.toNamed(AppRoute.send);
        }
      },
      tileColor: Theme.of(context).cardColor,
      contentPadding:
          padding ?? EdgeInsets.only(left: 10, right: 10, bottom: 2, top: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      minLeadingWidth: width(context) * 0.05,
      leading: CustomImageView(
        height: height(context) * 0.05,
        width: height(context) * 0.05,
        imagePath: imagepath,
      ),
      title: Text(
        Title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      subtitle: Text(
        "$subtitle",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.w400, fontSize: 13),
      ),
      trailing: prfix ?? SizedBox(),
    );
  }
}
