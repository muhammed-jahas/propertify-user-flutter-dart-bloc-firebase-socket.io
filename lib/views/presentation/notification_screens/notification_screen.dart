import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:propertify/blocs/payment_bloc/payment_bloc.dart';
import 'package:propertify/constants/colors/colors.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/models/agent_model.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/models/request_recieving_model.dart';
import 'package:propertify/views/presentation/notification_screens/notification_single_screen.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
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
            customSpaces.verticalspace40,
            Padding(
              padding: customPaddings.horizontalpadding20,
              child: Text(
                "Notifications",
                style: AppFonts.SecondaryColorText28,
              ),
            ),
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
                      if (state.paymentRequests.isEmpty) {
                        return Container(
                          child: Text('No Paynment Requests'),
                        );
                      }else {
                        return Container(
                              child: ListView.separated(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  print('In ListView Builder');
                                  RequestRecievingModel paymentrequest =
                                      state.paymentRequests[index];

                                  return NotificationWidget(
                                      paymentrequest: paymentrequest);
                                },
                                separatorBuilder: (context, index) {
                                  return customSpaces.verticalspace20;
                                },
                                itemCount: state.paymentRequests.length,
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
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => NotificationSingleScreen(property: property,agent: agent,paymentrequest: paymentrequest),));
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
