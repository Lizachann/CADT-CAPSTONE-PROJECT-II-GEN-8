import 'package:capstone_project_mobile/layouts/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:capstone_project_mobile/pages/home/find_activity_page/find_activity_page.dart';
import 'package:capstone_project_mobile/components/buttons/favorite_button.dart';

class CategoryActivity extends StatelessWidget {
  final String? type;
  final List<DetailItem> detailActivitys;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final bool actionFilter;

  CategoryActivity({
    super.key,
    this.type,
    this.actionFilter = false,
    required this.detailActivitys,
  });

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    List<DetailItem> filteredItems;
    if (actionFilter == true) {
      filteredItems =
          detailActivitys.where((item) => item.type == type).toList();
    } else {
      filteredItems = detailActivitys.toList();
    }
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorScheme.surface,
      appBar: const MyAppBar(
        title: "Find Your Activity",
        actionsSearchEnabled: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: ListView.builder(
          itemCount: filteredItems.length,
          itemBuilder: (context, index) {
            final item = filteredItems[index];
            return Column(
              children: [
                ListTile(
                  title: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => item.navigation(context)),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shadowColor: Colors.grey,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 100,
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.12),
                            spreadRadius: 4,
                            blurRadius: 4,
                            offset: Offset(0, 5),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 4,
                              child: Image.asset(
                                item.logo,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Stack(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          item.title,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            overflow: TextOverflow.visible,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        const Text(
                                          'Find out more',
                                          style: TextStyle(
                                            color: Colors.black,
                                            overflow: TextOverflow.visible,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Positioned(
                                    top: 0,
                                    right: 0,
                                    child: FavoriteButton(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10), // Adjust the height as needed
              ],
            );
          },
        ),
      ),
    );
  }
}
