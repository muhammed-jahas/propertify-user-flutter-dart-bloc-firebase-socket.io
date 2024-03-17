import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/payment_bloc/payment_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/icons/propertify_icons.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/models/agent_model.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/models/request_recieving_model.dart';
import 'package:propertify/views/presentation/notification_screens/notification_single_screen.dart';
import 'package:propertify/views/presentation/properties_details_screen/property_details_screen.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSpaces.verticalspace20,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Text(
                "History",
                style: AppFonts.SecondaryColorText28,
              ),
            ),
            customSpaces.verticalspace10,
            Divider(),
            customSpaces.verticalspace10,
            Expanded(
              child: Padding(
                padding: customPaddings.horizontalpadding20,
                child: BlocBuilder<PaymentRequestsBloc, PaymentRequestsState>(
                  builder: (context, state) {
                    if (state is PaymentRequestsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is PaymentRequestsLoadedSuccessState) {
                      List<RequestRecievingModel> paidPaymentRequests = state
                          .paymentRequests
                          .where((request) => request.isPaid == true)
                          .toList();

                      if (paidPaymentRequests.isEmpty) {
                        return Center(
                          child: Text(
                            'No Recent Payments',
                            style: AppFonts.SecondaryColorText20,
                          ),
                        );
                      } else {
                        return Container(
                          child: ListView.separated(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              print('In ListView Builder');
                              RequestRecievingModel paymentrequest =
                                  paidPaymentRequests[index];

                              return historyWidget(
                                  paymentrequest: paymentrequest);
                            },
                            separatorBuilder: (context, index) {
                              return customSpaces.verticalspace20;
                            },
                            itemCount: paidPaymentRequests.length,
                          ),
                        );
                      }
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

  fetchRequests() async {
    context
        .read<PaymentRequestsBloc>()
        .add(getAllPaymentRequestsEvent()); // Dispatch the event to fetch data
  }
}

class historyWidget extends StatelessWidget {
  final RequestRecievingModel paymentrequest;
  historyWidget({
    super.key,
    required this.paymentrequest,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PropertyDetailsScreen(
                  property: paymentrequest.property!,
                )));
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                bottomLeft: Radius.circular(4),
              ),
              child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Image(
                  height: 105,
                  width: 130,
                  image: NetworkImage(
                      '${paymentrequest.property!.propertyCoverPicture!.path}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  customSpaces.verticalspace20,
                  Row(
                    children: [
                      customSpaces.horizontalspace5,
                      Text(
                        '${paymentrequest.property!.propertyName}',
                        style: AppFonts.SecondaryColorText14,
                      ),
                    ],
                  ),
                  customSpaces.verticalspace5,
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(50)),
                        child: Text(
                          '${paymentrequest.property!.propertyCategory}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      customSpaces.horizontalspace10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            PropertifyIcons.location,
                            color: Colors.grey,
                            size: 12,
                          ),
                          customSpaces.horizontalspace5,
                          Text(
                            '${paymentrequest.property!.propertyCity}',
                            style: AppFonts.greyText12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  customSpaces.verticalspace10,
                  Row(
                    children: [
                      customSpaces.horizontalspace5,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '₹ ${paymentrequest.paymentAmount}',
                            style: AppFonts.SecondaryColorText18,
                          ),
                          customSpaces.horizontalspace10,
                          CircleAvatar(
                            radius: 5,
                            backgroundColor: Colors.green.shade400,
                          ),
                          customSpaces.horizontalspace5,
                          Text(
                            'Paid',
                            style: AppFonts.greyText12,
                          ),
                        ],
                      ),
                    ],
                  ),
                  customSpaces.verticalspace10,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationWidget extends StatelessWidget {
  final RequestRecievingModel paymentrequest;
  NotificationWidget({Key? key, required this.paymentrequest});

  @override
  Widget build(BuildContext context) {
    // Extract the first letter of the agent's name
    String firstLetter = paymentrequest.agent?.name?[0].toUpperCase() ?? '';
    PropertyModel property = paymentrequest.property!;
    AgentModel agent = paymentrequest.agent!;
    return InkWell(
      onTap: () {
        // Get.to(() => NotificationSingleScreen(request: request));
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => NotificationSingleScreen(
              property: property, agent: agent, paymentrequest: paymentrequest),
        ));
        print(paymentrequest.toJson());
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          // border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              child: Text(
                firstLetter,
                style: AppFonts.WhiteColorText14Bold,
              ),
            ),
            Text(
                'You have a new Payment request from ${paymentrequest.agent?.name ?? "Unknown agent"}'),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
