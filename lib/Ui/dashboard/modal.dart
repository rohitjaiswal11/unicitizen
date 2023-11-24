// ignore_for_file: public_member_api_docs, sort_constructors_first


class DashboardModal {
  String image;
  String money;
  String name;
  DashboardModal({
    required this.image,
    required this.money,
    required this.name,
  });
}
  List<DashboardModal> lockitmes = [
    DashboardModal(
        image: "assets/dashboard/lock.png", money: "0", name: "Funding"),
    DashboardModal(
        image: "assets/dashboard/lock.png", money: "0", name: "Presale"),
    DashboardModal(
        image: "assets/dashboard/person.png", money: "0", name: "Referal"),
    DashboardModal(
        image: "assets/dashboard/lock.png", money: "0", name: "Stake"),
  ];

