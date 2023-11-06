import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/home_bloc/home_bloc.dart';
import 'package:propertify/blocs/search_bloc/search_bloc.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';

class SavedScreen extends StatefulWidget {
  SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {

  void initState() {
    super.initState();
    _fetchAllProperties(); // Fetch all properties when the screen is first opened
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
                "Favourites",
                style: AppFonts.SecondaryColorText28,
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
                      return Container(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1 / 1,
                          ),
                          itemBuilder: (context, index) {
                            PropertyModel property = state.properties[
                                index]; // Access the property at the current index
                            return HomePageCardSingle(
                              cardWidth: 210,
                              property: property, // Pass the property to the widget
                            );
                          },
                          itemCount: state.properties
                              .length, // Use the length of the properties list
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
