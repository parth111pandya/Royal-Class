import 'dart:convert';

import 'package:royal_class_app/api/ApiExecutor.dart';
import 'package:royal_class_app/api/ApiNameConst.dart';
import 'package:royal_class_app/common/no_data.dart';
import 'package:royal_class_app/custom/custom_icon_btn.dart';
import 'package:royal_class_app/custom/medium_text_widget.dart';
import 'package:royal_class_app/screens/product_details/product_detail_page.dart';
import 'package:royal_class_app/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../../custom/bold_text_widget.dart';
import '../../models/categories_model.dart';
import '../../models/products_model.dart';

class ProductsPage extends StatefulWidget {
  CategoriesModel? categoriesModel;

  ProductsPage({
    this.categoriesModel,
    super.key,
  });

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    productsApi(context);
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
                        title: "Choose Product",
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
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 5), // changes position of shadow
                            ),
                          ],
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
                            itemBuilder: (BuildContext context, int index) {
                              return CustomProductCard(
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
    );
  }

  ApiExecutor apiexecutor = ApiExecutor();

  // bool isproductsApi = true;
  List<ProductsModel> listOfCategories = [];

  Future<List<ProductsModel>> productsApi(context) async {
    listOfCategories.clear();
    List<ProductsModel> tempList = [];
    Map<String, String> map = {};
    await apiexecutor.callApi(
      context,
      PRODUCTS,
      true,
      true,
      map,
      (val) {
        // Parse the JSON string
        List<dynamic> jsonList = jsonDecode(val);

        // Convert the JSON list to a list of Item objects
        tempList =
            jsonList.map((json) => ProductsModel.fromJson(json)).toList();
        widget.categoriesModel != null
            ? listOfCategories.addAll(tempList.where(
                (item) => item.category!.id == widget.categoriesModel!.id))
            : listOfCategories = tempList;
        setState(() {});
        // isproductsApi = false;
      },
      true,
    );
    return listOfCategories;
  }
}

class CustomProductCard extends StatelessWidget {
  ProductsModel model;

  CustomProductCard({
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
              builder: (context) => ProductDetailPage(
                    productsModel: model,
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
          model.images!.isNotEmpty || model.images != null
              ? Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Image.network(
                          Uri.parse(model.images!.first
                                      .replaceFirst("[\"", '')
                                      .replaceFirst('\"]', ''))
                                  .host
                                  .isNotEmpty
                              ? model.images!.first
                                  .replaceFirst("[\"", '')
                                  .replaceFirst('\"]', '')
                              : model.category!.image!,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              model.category!.image!,
                              height: 100,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BoldTextWidget(
                                    title: model.title,
                                    fontcolor: Colors.white,
                                    fontsize: 14,
                                  ),
                                  MediumTextWidget(
                                    title: "\$${model.price}",
                                    fontcolor: Colors.white,
                                    fontsize: 14,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
