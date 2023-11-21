import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/home_bloc/home_bloc.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/data/shared_preferences/shared_preferences.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/repositories/user_repo/user_repo.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';

class SavedScreen extends StatefulWidget {
  SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // Default to show all categories
  List<String> favoritePropertyIds = [];
  void initState() {
    super.initState();
    
    _fetchUserFavourites();
     _fetchAllProperties();
  }

  void _fetchAllProperties() {
    context.read<HomeBloc>().add(getAllProperties());
  }
  

    _fetchUserFavourites() async {
    String? userId = await SharedPref.instance.getUserId();
    final response = UserRepo().getAllFavourites(userId);
    response.fold(
      (left) => print(left),
      (response) => {
        if (response['status'] == 'success') {
          setState(() {
            // Update favoritePropertyIds with the received property IDs
            favoritePropertyIds =
                List<String>.from(response['propertyIds']);
          })
        
        }
      },
    );
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
            customSpaces.verticalspace10,
            Divider(),
            customSpaces.verticalspace10,
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
                      List<PropertyModel> filteredProperties = state.properties
          .where((property) =>
              favoritePropertyIds.contains(property.id))
          .toList();
           if (filteredProperties.isEmpty) {
                        // Show 'No Results Found' when the list is empty
                        return Center(
                          child: Text('No Favourites', style: AppFonts.SecondaryColorText20),
                        ); }
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
