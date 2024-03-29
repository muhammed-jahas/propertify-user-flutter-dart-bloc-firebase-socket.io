import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/search_bloc/search_bloc.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  String? searchQuery;
  SearchScreen({super.key, this.searchQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchController = TextEditingController();
  @override
  void initState() {
    SearchController.text = widget.searchQuery ?? '';
    if (widget.searchQuery != null) {
      context
          .read<SearchBloc>()
          .add(SearchInputChangedEvent(widget.searchQuery!));
    } else {
      _fetchAllProperties();
    }
    // Fetch all properties when the screen is first opened
    super.initState();
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
          // customSpaces.verticalspace20,
          CustomInputField(
            onChanged: (searchInput) {
              context
                  .read<SearchBloc>()
                  .add(SearchInputChangedEvent(searchInput));
              print(searchInput);
            },
            fieldIcon: Icons.search,
            hintText: 'Serach for properties',
            controller: SearchController,
            borderColor: Colors.transparent,
            bgColor: Colors.white,
          ),
          Divider(
            height: 1,
            color: Colors.grey.shade400,
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
                    if (state.properties.isEmpty) {
                      // Show 'No Results Found' when the list is empty
                      return Center(
                        child: Text('No Properties Found',
                            style: AppFonts.SecondaryColorText20),
                      );
                    }
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
                            property:
                                property, // Pass the property to the widget
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
