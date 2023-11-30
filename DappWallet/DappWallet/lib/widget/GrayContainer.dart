import 'package:dappwallet/utils/export.dart';

class GrayContainer extends StatelessWidget {
  double? radius;
  Widget child;
  EdgeInsetsGeometry? margin;
  GrayContainer({this.radius = 6, required this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.zero,
      width: width(context),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius ?? 6),
        border: Border.all(color: Theme.of(context).cardColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: child,
      ),
    );
  }
}
