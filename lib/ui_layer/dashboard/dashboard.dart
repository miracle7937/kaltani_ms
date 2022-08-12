import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kaltani_ms/logic/local_storage.dart';
import 'package:kaltani_ms/logic/model/auth_response_model.dart';
import 'package:kaltani_ms/ui_layer/pages/bailing_screen.dart';
import 'package:kaltani_ms/ui_layer/pages/sorting_screen.dart';
import 'package:kaltani_ms/utils/greetings.dart';
import 'package:kaltani_ms/utils/images.dart';
import 'package:kaltani_ms/utils/scaffolds_widget/ka_scaffold.dart';

import '../../utils/colors.dart';
import '../../utils/reuseable/card_bg.dart';
import '../auth/change_password_screen.dart';
import '../pages/collection_screen.dart';
import '../pages/recycle_screen.dart';
import '../pages/sales_screen.dart';
import '../pages/transfer_screen.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  AuthResponse? _authResponse;
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    _authResponse = await getUserData();
    setState(() {});
  }

  void handleClick(String value) {
    switch (value) {
      case 'Change password':
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => ChangePasswordScreen()));
        break;
      case 'Logout':
        clearUser();
        Navigator.pushNamed(context, "/");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    String firstName = _authResponse?.user?.firstName ?? "";
    String location = _authResponse?.user?.location?.name ?? "";
    return KAScaffold(
      padding: EdgeInsets.zero,
      builder: (_) {
        return Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                KAImages.dashboardBg,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            greetingMessage(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: KAColors.appBlackColor),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            firstName.toUpperCase(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1!
                                .copyWith(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 12,
                                    color: KAColors.appBlackColor),
                          )
                        ],
                      ),
                      const Spacer(),
                      PopupMenuButton<String>(
                        icon: SizedBox(
                          width: MediaQuery.of(context).size.height * 0.07,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Image.asset(KAImages.logout1),
                        ),
                        onSelected: handleClick,
                        itemBuilder: (BuildContext context) {
                          return {"Change password", 'Logout'}
                              .map((String choice) {
                            return PopupMenuItem<String>(
                              value: choice,
                              child: Text(choice,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: KAColors.appBlackColor)),
                            );
                          }).toList();
                        },
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     clearUser();
                      //     Navigator.pushNamed(context, "/");
                      //   },
                      //   child: SizedBox(
                      //     width: MediaQuery.of(context).size.height * 0.07,
                      //     height: MediaQuery.of(context).size.height * 0.07,
                      //     child: Image.asset(KAImages.logout1),
                      //   ),
                      // )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CardBG(
                    body: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            Text(
                              "Location",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: KAColors.appGreyColor),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Image.asset(KAImages.location),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  location,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w400,
                                          color: KAColors.appBlackColor),
                                ),
                              ],
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What will you like to do?",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: KAColors.appGreyColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Expanded(
                      child: GridView.count(
                          controller: ScrollController(keepScrollOffset: false),
                          padding: const EdgeInsets.all(12),
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 22.0,
                          childAspectRatio: 0.98,
                          children: List.generate(_list.length, (index) {
                            return _selectableTab(index);
                          }))),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  _selectableTab(int i) {
    return CardBG(
      callback: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => _list[i].page));
      },
      color: _list[i].color,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(_list[i].image!),
            const SizedBox(
              height: 15,
            ),
            Text(
              _list[i].title.toString(),
              style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontWeight: FontWeight.w400, color: KAColors.appWhiteColor),
            )
          ],
        ),
      ),
    );
  }

  final List<DashData> _list = [
    DashData(
        page: CollectionScreen(),
        title: "Collect",
        image: KAImages.collection,
        color: const Color.fromRGBO(252, 186, 3, 1)),
    DashData(
        page: SortingScreen(),
        title: "Sorting",
        image: KAImages.sorting,
        color: const Color.fromRGBO(255, 123, 0, 1)),
    DashData(
        title: "Bailing",
        page: BailingScreen(),
        image: KAImages.billing,
        color: const Color.fromRGBO(95, 94, 94, 1)),
    DashData(
        page: const TransferScreen(),
        title: "Transfer",
        image: KAImages.transfer,
        color: const Color.fromRGBO(107, 5, 142, 1)),
    DashData(
        title: "Recycle",
        page: RecycleScreen(),
        image: KAImages.recycle,
        color: const Color.fromRGBO(0, 206, 120, 1)),
    DashData(
        title: "Sales",
        page: SalesScreen(),
        image: KAImages.sells,
        color: const Color.fromRGBO(255, 0, 106, 1)),
    // DashData(
    //     title: "Log out",
    //     image: KAImages.logout,
    //     color: const Color.fromRGBO(210, 0, 38, 1)),
  ];
}

class DashData {
  late final String? title, image;
  late final dynamic page;
  late final Color? color;
  DashData({this.title, this.image, this.page, this.color});
}
