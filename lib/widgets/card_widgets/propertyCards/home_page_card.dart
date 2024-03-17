import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_recent_card.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';
import '../../../blocs/home_bloc/home_bloc.dart';
import 'package:shimmer/shimmer.dart';

class HomePageCard extends StatelessWidget {
  const HomePageCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Container(
            height: 180,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[50]!,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                scrollDirection: Axis.horizontal,

                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    // width: 200.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .5 - 20,
                          height: 100.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: 150.0,
                          height: 10.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: 2, // Your desired number of shimmer items
              ),
            ),
          );
        } else if (state is HomeLoadedSuccessState) {
          if (state.properties.isEmpty) {
            return Container(
              height: 200,
              child: Center(child: Text('No Properties')),
            );
          } else {
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
                itemCount: state
                    .properties.length, // Use the length of the properties list
              ),
            );
          }
        }
        return SizedBox(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}

class HomePageRecentCardSingle extends StatelessWidget {
  const HomePageRecentCardSingle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return Container(
            height: 200,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[50]!,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 10,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 150.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 10.0,
                          color: Colors.white,
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 10.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                itemCount: 1, // Display only one shimmer item
              ),
            ),
          );
        } else if (state is HomeLoadedSuccessState) {
          if (state.properties.isEmpty) {
            return Container(
              height: 200,
              child: Center(child: Text('No Properties')),
            );
          } else {
            // Access the last property from the list
            PropertyModel lastProperty = state.properties.last;
            return HomePageRecentCradSingle(
              cardWidth: 210,
              property: lastProperty,
            );
          }
        }
        return SizedBox(
          child: Text('Something went wrong'),
        );
      },
    );
  }
}
