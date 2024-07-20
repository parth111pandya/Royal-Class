import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:royal_class_app/custom/custom_button.dart';
import 'package:royal_class_app/custom/custom_elevated_button.dart';
import 'package:royal_class_app/custom/medium_text_widget.dart';
import 'package:royal_class_app/models/products_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import '../../custom/bold_text_widget.dart';
import '../../utils/colors.dart';

class ProductDetailPage extends StatefulWidget {
  ProductsModel productsModel;

  ProductDetailPage({
    required this.productsModel,
    super.key,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 25,
                    right: 25,
                  ),
                  child: Row(
                    children: [
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
                            Icons.keyboard_arrow_down,
                            size: 25,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                      Flexible(
                        child: BoldTextWidget(
                          title: widget.productsModel.title,
                          fontcolor: AppColors.LightColor,
                          fontsize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 25,
                    left: 25,
                    right: 25,
                  ),
                  child: CarouselSlider(
                    options: CarouselOptions(height: 320.0),
                    items: widget.productsModel.images!.map((item) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              Uri.parse(item
                                          .replaceFirst("[\"", '')
                                          .replaceFirst("\"", '')
                                          .replaceFirst('\\"]', ''))
                                      .host
                                      .isNotEmpty
                                  ? item
                                      .replaceFirst("[\"", '')
                                      .replaceFirst('\"]', '')
                                  : widget.productsModel.category!.image!,
                              height: 100,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.network(
                                  widget.productsModel.category!.image!,
                                  height: 100,
                                );
                              },
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: AppColors.ScaffoldBackgroundColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 5,
                          blurRadius: 10,
                          offset: const Offset(
                            0,
                            -5,
                          ), // changes position of shadow
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF323B4F)
                                          .withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          0, 5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CustomElevatedButton(
                                  onCallPressed: onCallPressed,
                                  backgroundColor: const Color(0xFF323B4F),
                                  BtnWidthsize: 150,
                                  text: "Description",
                                  textColor: Colors.blue,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFF323B4F)
                                          .withOpacity(0.2),
                                      spreadRadius: 5,
                                      blurRadius: 10,
                                      offset: const Offset(
                                          -0, -5), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: CustomElevatedButton(
                                  onCallPressed: onCallPressed,
                                  backgroundColor: const Color(0xFF323B4F),
                                  BtnWidthsize: 150,
                                  text: "Specification",
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: BoldTextWidget(
                              title: widget.productsModel.title,
                              fontsize: 20,
                              fontcolor: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: MediumTextWidget(
                              title: widget.productsModel.description,
                              fontsize: 16,
                              fontcolor: Colors.white,
                            ),
                          ),
                          Container(
                            width: double.maxFinite,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Color(0xFF262E3D),
                            ),
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 18,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BoldTextWidget(
                                  title: '\$${widget.productsModel.price}',
                                  fontsize: 20,
                                  fontcolor: Colors.blue,
                                ),
                                Container(
                                  width: 150,
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
                                  child: Center(
                                    child: BoldTextWidget(
                                      title: 'Add to Card',
                                      fontsize: 20,
                                      fontcolor: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  onCallPressed() {}
}
