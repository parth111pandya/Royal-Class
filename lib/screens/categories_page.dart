import 'dart:convert';

import 'package:royal_class_app/api/ApiExecutor.dart';
import 'package:royal_class_app/api/ApiNameConst.dart';
import 'package:royal_class_app/common/no_data.dart';
import 'package:royal_class_app/custom/custom_icon_btn.dart';
import 'package:royal_class_app/screens/product_page/product_page.dart';
import 'package:royal_class_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:royal_class_app/custom/custom_scaffold.dart';
import 'package:flutter/material.dart';

import '../custom/bold_text_widget.dart';
import '../custom/custom_card.dart';
import '../models/categories_model.dart';
import '../models/products_model.dart';
import '../utils/colors.dart';

class CategotiesPage extends StatefulWidget {
  const CategotiesPage({super.key});

  @override
  State<CategotiesPage> createState() => _CategotiesPageState();
}

class _CategotiesPageState extends State<CategotiesPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    categoriesApi(context);
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ScaffoldBackgroundColor,
      body: Stack(
        children: [
          const Positioned(
            bottom: -100,
            top: 150,
            right: 0,
            child: Image(
              image: AssetImage(
                'assets/images/bachground_image.png',
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 25,
                right: 25,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      BoldTextWidget(
                        title: "Choose Categories",
                        fontcolor: AppColors.LightColor,
                        fontsize: 20,
                      ),
                      const Spacer(),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF34C8E8),
                              Color(0xFF4E4AF2),
                            ],
                            stops: [0, 6],
                            begin: Alignment(-1, -1),
                            end: Alignment(1, 1),
                          ),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.search,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 100,
                    width: double.maxFinite,
                    child: Stack(
                      children: [
                        Positioned(
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductsPage(),
                                ),
                              );
                            },
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF353F54),
                                    Color(0xFF222834),
                                  ],
                                  stops: [0, 6],
                                  begin: Alignment(-1, -1),
                                  end: Alignment(1, 1),
                                ),
                              ),
                              child: Center(
                                child: BoldTextWidget(
                                  title: "All",
                                  fontcolor: Colors.white,
                                  fontsize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 70,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF353F54),
                                  Color(0xFF222834),
                                ],
                                stops: [0, 6],
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                              ),
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/1.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 20,
                          left: 140,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF353F54),
                                  Color(0xFF222834),
                                ],
                                stops: [0, 6],
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                              ),
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/2.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 210,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF353F54),
                                  Color(0xFF222834),
                                ],
                                stops: [0, 6],
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                              ),
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/3.png'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 40,
                          left: 280,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFF353F54),
                                  Color(0xFF222834),
                                ],
                                stops: [0, 6],
                                begin: Alignment(-1, -1),
                                end: Alignment(1, 1),
                              ),
                            ),
                            child: const Image(
                              image: AssetImage('assets/images/4.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: (listOfCategories.isNotEmpty)
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: (1 / 1.5),
                            ),
                            itemCount: listOfCategories.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return CustomCategoriesCard(
                                  model: listOfCategories[index]);
                            })
                        : Container(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF181C24),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/bicycle.png'),
            ),
            label: '',
            backgroundColor: Color(0xFF181C24),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/cart.fill.png'),
            ),
            label: '',
            backgroundColor: Color(0xFF181C24),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/doc.text.fill.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/map.fill.png'),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('assets/images/person.fill.png'),
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  ApiExecutor apiexecutor = ApiExecutor();

  bool iscategoriesApiCall = true;
  List<CategoriesModel> listOfCategories = [];

  Future<List<CategoriesModel>> categoriesApi(context) async {
    listOfCategories.clear();
    Map<String, String> map = {};
    await apiexecutor.callApi(
      context,
      CATEGORIES,
      true,
      true,
      map,
      (val) {
        // Parse the JSON string
        List<dynamic> jsonList = jsonDecode(val);
        // Convert the JSON list to a list of Item objects
        listOfCategories =
            jsonList.map((json) => CategoriesModel.fromJson(json)).toList();
        iscategoriesApiCall = false;
        setState(() {});
      },
      true,
    );
    return listOfCategories;
  }
}

class CustomCategoriesCard extends StatelessWidget {
  CategoriesModel model;

  CustomCategoriesCard({
    required this.model,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductsPage(
                    categoriesModel: model,
                  )),
        );
      },
      child: Stack(
        children: [
          const Center(
            child: Image(
              image: AssetImage(
                "assets/images/Rectangle 166.png",
              ),
              fit: BoxFit.fitHeight,
            ),
          ),
          model.image != null
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Image.network(
                          model.image!,
                          height: 100,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      BoldTextWidget(
                        title: model.name,
                        fontcolor: Colors.white,
                        fontsize: 16,
                      ),
                    ],
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
