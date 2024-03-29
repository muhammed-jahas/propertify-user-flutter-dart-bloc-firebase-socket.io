// ignore: unused_import
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/views/categories%20screen/categories_screen.dart';
import 'package:propertify/views/presentation/notification_screens/notification_screen.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/views/presentation/saved_screen/saved_screen.dart';
import 'package:propertify/views/presentation/search_screen/search_location_screen.dart';
import 'package:propertify/views/presentation/search_screen/search_screen.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_card.dart';
import 'package:propertify/widgets/iconbox/customIconBox.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';
import 'package:propertify/widgets/location_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../blocs/home_bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(getAllProperties());
  }

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
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => SearchLocationScreen(),
                              ));
                              // _showBottomSheet(context);
                            },
                            child: locationWidget()),
                        Row(
                          children: [
                            // CustomIconBox(
                            //   boxheight: 40,
                            //   boxwidth: 40,
                            //   boxIcon: Icons.refresh,
                            //   radius: 8,
                            //   boxColor: Colors.transparent,
                            //   IconColor: AppColors.secondaryColor,
                            //   iconSize: 28,
                            //   iconFunction: () {
                            //     context
                            //         .read<HomeBloc>()
                            //         .add(getAllProperties());
                            //   },
                            // ),
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
                GestureDetector(
                  onTap: () {
                    print('Tapped on the non-editable field');
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ));
                  },
                  child: Padding(
                    padding: customPaddings.horizontalpadding20,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.grey.shade200)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              customSpaces.horizontalspace10,
                              Text(
                                'Search for Properties',
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade400,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(4),
                                // border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: customPaddings.horizontalpadding20,
                //   child: CustomInputField(
                //     onTap: () {
                //       print('Tapped on the non-editable field');
                //       Navigator.of(context).push(MaterialPageRoute(
                //         builder: (context) => SearchScreen(),
                //       ));
                //     },
                //     enabled: false,
                //     editable: true,
                //     bgColor: AppColors.whiteColor,
                //     borderColor: Colors.grey.shade300,

                //     // borderColor: Colors.white,
                //     fieldIcon: Icons.search,
                //     hintText: 'Serach for properties',
                //     // fillColor: AppColors.whiteColor,
                //     // borderColor: Colors.transparent
                //   ),
                // ),
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
                      child: CategoryBox(
                        categoryName: 'House',
                        categoryIcon: PropertifyIcons.home,
                        imagePath: 'assets/images/categories/house.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoriesScreen(
                              category: 'House',
                            ),
                          ));
                        },
                        isLoading: _isLoadingCategories(context),
                      ),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: CategoryBox(
                        categoryName: 'Apartment',
                        categoryIcon: Icons.apartment_rounded,
                        imagePath: 'assets/images/categories/apartment.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CategoriesScreen(category: 'Apartment'),
                          ));
                        },
                        isLoading: _isLoadingCategories(context),
                      ),
                    ),
                  ],
                ),
                customSpaces.verticalspace10,
                Row(
                  children: [
                    Expanded(
                      child: CategoryBox(
                        categoryName: 'Office',
                        categoryIcon: Icons.work_outline_rounded,
                        imagePath: 'assets/images/categories/office.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CategoriesScreen(
                              category: 'Office',
                            ),
                          ));
                        },
                        isLoading: _isLoadingCategories(context),
                      ),
                    ),
                    customSpaces.horizontalspace10,
                    Expanded(
                      child: CategoryBox(
                        categoryIcon: Icons.category_outlined,
                        categoryName: 'Other',
                        imagePath: 'assets/images/categories/other.jpg',
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                CategoriesScreen(category: 'Other'),
                          ));
                        },
                        isLoading: _isLoadingCategories(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Recently Added',
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
            child: HomePageRecentCardSingle(),
          ),

          customSpaces.verticalspace20,

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

  bool _isLoadingCategories(BuildContext context) {
    final state = context.watch<HomeBloc>().state;
    return state is HomeLoadingState;
  }
}

// ignore: must_be_immutable
class CategoryBox extends StatelessWidget {
  final String? categoryName;
  final String? imagePath;
  final VoidCallback? onTap;
  final bool isLoading;
  final IconData? categoryIcon;

  const CategoryBox({
    Key? key,
    this.categoryName,
    this.categoryIcon,
    this.imagePath,
    this.onTap,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300)
                  // image: DecorationImage(
                  //   image: AssetImage(imagePath ?? 'assets/images/banner-1.jpg'),
                  //   fit: BoxFit.cover,
                  // ),
                  ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        categoryIcon,
                        size: 24,
                      ),
                      customSpaces.horizontalspace20,
                      Text(
                        categoryName ?? '',
                        style: AppFonts.SecondaryColorText14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
