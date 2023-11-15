import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/search_bloc/search_bloc.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController = TextEditingController();
   @override
  void initState() {
    super.initState();
    _fetchAllProperties(); // Fetch all properties when the screen is first opened
  }
  void _fetchAllProperties() {
    context.read<SearchBloc>().add(GetAllPropertiesEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          customSpaces.verticalspace20,
          Padding(
            padding: customPaddings.horizontalpadding20,
            child: CustomInputField(
                onChanged: (searchInput) {
                  context
                      .read<SearchBloc>()
                      .add(SearchInputChangedEvent(searchInput));
                      print(searchInput);
                },
                
                fieldIcon: Icons.search,
                hintText: 'Serach for properties',
                controller: SearchController),
          ),
          customSpaces.verticalspace20,
          Expanded(
            child: Padding(
              padding: customPaddings.horizontalpadding20,
              child: BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchInitial) {
                    return Container(
                      child: Center(child: Text('Search For Properties')),
                    );
                  } else if (state is SearchLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is SearchLoadedSuccessState) {
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
                    child: Text('Something went Wrong'),
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
