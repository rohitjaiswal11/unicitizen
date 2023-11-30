import 'package:dappwallet/utils/export.dart';

class CustomeAppbar extends StatelessWidget {
  String title = "";
  Widget? icon;
  CustomeAppbar({required this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        "$title",
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(fontWeight: FontWeight.w500, fontSize: 19),
      ),
      centerTitle: true,
      leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back,
              color: Theme.of(context).textTheme.headlineSmall!.color)),
      actions: [
        icon ?? SizedBox(),
      ],
    );
  }
}

///When Call in App bar Widget than  Use this Type

AppbarSecond({
  required String title,
  Widget? icon,
  required BuildContext context,
  bool back = false,
}) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    leading: back
        ? IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,
                color: Theme.of(context).textTheme.headlineSmall!.color))
        : SizedBox(),
    title: Text(
      "$title",
      style: Theme.of(context)
          .textTheme
          .headlineSmall!
          .copyWith(fontWeight: FontWeight.w500, fontSize: 19),
    ),
    centerTitle: true,
    actions: [
      icon ?? SizedBox(),
    ],
  );
}
