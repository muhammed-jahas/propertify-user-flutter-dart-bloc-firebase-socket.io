// ignore: unused_import
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/views/categories%20screen/categories_screen.dart';
import 'package:propertify/views/presentation/notification_screens/notification_screen.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/views/presentation/saved_screen/saved_screen.dart';
import 'package:propertify/views/presentation/search_screen/search_screen.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_card.dart';
import 'package:propertify/widgets/iconbox/customIconBox.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';
import 'package:propertify/widgets/location_widget.dart';

import '../../../blocs/home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
        body: ListView(shrinkWrap: true, children: [
          //AppBar

          Container(
            // color: AppColors.primaryColor,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.symmetric(
                      horizontal: 20, vertical: 20),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                            onTap: () {
                              _showBottomSheet(context);
                            },
                            child: locationWidget()),
                        Row(
                          children: [
                            CustomIconBox(
                              boxheight: 40,
                              boxwidth: 40,
                              boxIcon: Icons.refresh,
                              radius: 8,
                              boxColor: Colors.transparent,
                              IconColor: AppColors.secondaryColor,
                              iconSize: 28,
                              iconFunction: () {
                                context
                                    .read<HomeBloc>()
                                    .add(getAllProperties());
                              },
                            ),
                            CustomIconBox(
                              boxheight: 40,
                              boxwidth: 40,
                              boxIcon: PropertifyIcons.save,
                              radius: 8,
                              boxColor: Colors.transparent,
                              IconColor: AppColors.secondaryColor,
                              iconSize: 24,
                              iconFunction: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SavedScreen(),
                                ));
                              },
                            ),
                            CustomIconBox(
                              boxheight: 40,
                              boxwidth: 40,
                              boxIcon: Icons.notifications_none_outlined,
                              radius: 8,
                              boxColor: Colors.transparent,
                              IconColor: AppColors.secondaryColor,
                              iconSize: 28,
                              iconFunction: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NotificationScreen(),
                                ));
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: customPaddings.horizontalpadding20,
                  child: CustomInputField(
                    onTap: () {
                      print('Tapped on the non-editable field');
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SearchScreen(),
                      ));
                    },
                    enabled: false,
                    editable: true,
                    bgColor: AppColors.whiteColor,
                    borderColor: Colors.grey.shade300,

                    // borderColor: Colors.white,
                    fieldIcon: Icons.search,
                    hintText: 'Serach for properties',
                    // fillColor: AppColors.whiteColor,
                    // borderColor: Colors.transparent
                  ),
                ),
              ],
            ),
          ),

          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: categoryBox(
                        cateoryname: 'House',
                        imagePath: 'assets/images/categories/house.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CategoriesScreen(category: 'House'),
                          ));
                        },
                      ),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: categoryBox(
                        cateoryname: 'Apartment',
                        imagePath: 'assets/images/categories/apartment.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CategoriesScreen(category: 'Apartment'),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
                customSpaces.verticalspace10,
                Row(
                  children: [
                    Expanded(
                      child: categoryBox(
                        cateoryname: 'Office',
                        imagePath: 'assets/images/categories/office.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CategoriesScreen(category: 'Office'),
                          ));
                        },
                      ),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: categoryBox(
                        cateoryname: 'Other',
                        imagePath: 'assets/images/categories/other.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CategoriesScreen(category: 'Other'),
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // customSpaces.verticalspace20,
          //Three Boxes
          // Padding(
          //   padding: customPaddings.horizontalpadding20,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Expanded(
          //         child: borderBoxIconandText(
          //             boxIcon: PropertifyIcons.categories,
          //             boxText: 'Categories'),
          //       ),
          //       customSpaces.horizontalspace10,
          //       Expanded(
          //         child: borderBoxIconandText(
          //             boxIcon: PropertifyIcons.guides, boxText: 'Guides'),
          //       ),
          //       customSpaces.horizontalspace10,
          //       Expanded(
          //         child: borderBoxIconandText(
          //             boxIcon: PropertifyIcons.recent, boxText: 'Recent'),
          //       ),
          //     ],
          //   ),
          // ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Recommendations',
                  style: AppFonts.SecondaryColorText18,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoriesScreen(),
                    ));
                  },
                  child: Text(
                    'See All',
                    style: AppFonts.PrimaryColorText14,
                  ),
                ),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: HomePageCard(),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Offers For You',
                  style: AppFonts.SecondaryColorText18,
                ),
                // Text(
                //   'See All',
                //   style: AppFonts.PrimaryColorText14,
                // ),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                image: AssetImage('assets/images/banner-1.jpg'),
              ),
            ),
          ),
          customSpaces.verticalspace20,
          // Padding(
          //   padding: customPaddings.horizontalpadding20,
          //   child: HomePageCard(),
          // ),
          // customSpaces.verticalspace20,
        ]),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    // ignore: unused_local_variable
    String selectedState;
    // ignore: unused_local_variable
    String selectedStateCode;
    // ignore: unused_local_variable
    String selectedDistrict;
    TextEditingController placeController = TextEditingController();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: customPaddings.horizontalpadding20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // customSpaces.verticalspace10,
                // State and District Picker with default country as India
                // CSCPicker(
                //   defaultCountry: CscCountry.India,
                //   // Set India as the default country
                //   onCountryChanged: (value) {
                //     // You can handle country changes if needed
                //   },
                //   onStateChanged: (value) {
                //     selectedState = value!;
                //   },
                //   onCityChanged: (value) {
                //     selectedDistrict = value!;
                //   },
                //   layout: Layout.vertical,
                //   showStates: true,
                //   showCities: true,
                //   flagState: CountryFlag.ENABLE,
                //   dropdownDecoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey),
                //     borderRadius: BorderRadius.circular(8),
                //   ),
                //   selectedItemStyle: TextStyle(fontSize: 18),
                //   dropdownHeadingStyle: TextStyle(fontSize: 16),
                // ),
                customSpaces.verticalspace20,
                CustomInputField(
                  hintText: 'Enter Place to Search',
                  controller: placeController,
                  fieldIcon: PropertifyIcons.location,
                ),

                customSpaces.verticalspace10,
                CustomColorButton(
                  buttonText: 'Search',
                  buttonColor: AppColors.primaryColor,
                  buttonFunction: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          SearchScreen(searchQuery: placeController.text),
                    ));
                  },
                ),
                customSpaces.verticalspace20,
              ],
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class categoryBox extends StatelessWidget {
  String? cateoryname;
  String? imagePath;
  VoidCallback? onTap;

  categoryBox({
    Key? key,
    this.cateoryname,
    this.imagePath,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: AssetImage(imagePath ?? 'assets/images/banner-1.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
            child:
                Text(cateoryname ?? '', style: AppFonts.WhiteColorText14Bold)),
      ),
    );
  }
}
