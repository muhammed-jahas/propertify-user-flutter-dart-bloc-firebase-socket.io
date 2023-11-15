import 'package:flutter/material.dart';
import 'package:propertify/constants/spaces%20&%20paddings/paddings.dart';
import 'package:propertify/constants/spaces%20&%20paddings/spaces.dart';
import 'package:propertify/constants/text_styles/text_styles.dart';
import 'package:propertify/models/agent_model.dart';
import 'package:propertify/models/property_model.dart';
import 'package:propertify/models/request_recieving_model.dart';
import 'package:propertify/widgets/buttons/custombuttons.dart';
import 'package:propertify/widgets/card_widgets/propertyCards/home_page_single_card.dart';
import 'package:propertify/widgets/iconbox/customIconBox.dart';
import 'package:propertify/widgets/input_fileds/customInputFields.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

// ignore: must_be_immutable
class NotificationSingleScreen extends StatefulWidget {
  RequestRecievingModel? paymentrequest;
  PropertyModel? property;
  AgentModel? agent;

  NotificationSingleScreen(
      {super.key, this.property, this.paymentrequest, this.agent});

  @override
  State<NotificationSingleScreen> createState() =>
      _NotificationSingleScreenState();
}

class _NotificationSingleScreenState extends State<NotificationSingleScreen> {
  Razorpay? _razorpay;

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print(response);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print(response);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print(response);
  }
   makePayment(RequestRecievingModel request) async {
   String paymentAmountString = request.paymentAmount!;
String formattedAmountString = paymentAmountString + '00';
double formattedAmount = double.parse(formattedAmountString);

    var options = {
      'key' : 'rzp_test_DTnsXzHYisvY7U',
      'amount' : formattedAmount,
      'name':request.user,
      'description':request.property!.propertyName,
      'prefill':{'contact':'+919656462348','email':'jahas[ty1@gmal.com]'},
    };
    try {
      _razorpay?.open(options);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  @override
  void initState() {
    super.initState();

    _razorpay = Razorpay();
    _razorpay?.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay?.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay?.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController paymentAmountController =
        TextEditingController(text: widget.paymentrequest?.paymentAmount ?? '');
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customSpaces.verticalspace20,
              Padding(
                padding: customPaddings.horizontalpadding20,
                child: Row(
                  children: [
                    CustomIconBox(
                        boxheight: 40,
                        boxwidth: 40,
                        boxIcon: Icons.arrow_back,
                        radius: 8,
                        boxColor: Colors.grey.shade300,
                        iconSize: 20),
                    customSpaces.horizontalspace20,
                    Text(
                      widget.agent!.name!,
                      style: AppFonts.SecondaryColorText20,
                    ),
                  ],
                ),
              ),
              customSpaces.verticalspace20,
              Padding(
                padding: customPaddings.horizontalpadding20,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(),
                          customSpaces.horizontalspace10,
                          Text(
                            widget.agent!.name!,
                            style: AppFonts.SecondaryColorText14,
                          ),
                          customSpaces.verticalspace20,
                        ],
                      ),
                      customSpaces.verticalspace10,
                      HomePageCardSingle(
                        property: widget.property,
                        cardHeight: 250,
                      ),
                      customSpaces.verticalspace10,
                      CustomInputField(
                          hintText: 'Enter Your Message',
                          fieldIcon: Icons.currency_rupee,
                          controller: paymentAmountController,
                          maxLines: 1,
                          enabled: false),
                      customSpaces.verticalspace10,
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              child: CustomColorButton(
                                buttonText: 'Decline',
                                buttonFunction: () {},
                                buttonColor: Colors.red,
                              ),
                            ),
                          ),
                          customSpaces.horizontalspace10,
                          Expanded(
                            child: Container(
                              child: CustomColorButton(
                                buttonText: 'Accept',
                                buttonFunction: () async  {
                                  await makePayment(widget.paymentrequest!);
                                },
                                buttonColor: Colors.green,
                              ),
                            ),
                          ),
                        ],
                      ),
                      customSpaces.verticalspace10,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
