import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/home_bloc/home_bloc.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';

// ignore: must_be_immutable
class CategoriesScreen extends StatefulWidget {
  String? category;
  CategoriesScreen({super.key, this.category});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? selectedCategory; // Default to show all categories

  void initState() {
    super.initState();
    selectedCategory = widget.category ?? 'All';
    _fetchAllProperties();
  }

  void _fetchAllProperties() {
    context.read<HomeBloc>().add(getAllProperties());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Text(
                "All Properties",
                style: AppFonts.SecondaryColorText28,
              ),
            ),
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Container(
                padding: customPaddings.horizontalpadding20,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  underline: Container(),
                  isExpanded: true,
                  value: selectedCategory,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue!;
                    });
                  },
                  items: ['All', 'House', 'Apartment', 'Office', 'Other']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
            customSpaces.verticalspace20,
            Expanded(
              child: Padding(
                padding: customPaddings.horizontalpadding20,
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is HomeLoadedSuccessState) {
                      List<PropertyModel> filteredProperties =
                          selectedCategory == 'All'
                              ? state.properties
                              : state.properties
                                  .where((property) =>
                                      property.propertyCategory ==
                                      selectedCategory)
                                  .toList();
                      if (filteredProperties.isEmpty) {
                        return Center(
                          child: Text('No Properties', style: AppFonts.SecondaryColorText14,),
                        );
                      }
                      return Container(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1 / 1,
                          ),
                          itemBuilder: (context, index) {
                            PropertyModel property = filteredProperties[index];
                            return HomePageCardSingle(
                              cardWidth: 210,
                              property: property,
                            );
                          },
                          itemCount: filteredProperties.length,
                        ),
                      );
                    }
                    return SizedBox(
                      child: Text('Something went wrong'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
