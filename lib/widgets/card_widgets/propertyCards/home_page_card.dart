import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';
import '../../../blocs/home_bloc/home_bloc.dart';

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
            height: 200,
            child: Center(child: CircularProgressIndicator()),
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
