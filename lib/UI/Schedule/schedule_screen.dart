import "package:flutter/material.dart";
import "package:grabber_app/Theme/light_theme.dart";
import "package:grabber_app/UI/Schedule/Widget/custom_time_slot.dart";
import "package:grabber_app/UI/Schedule/Widget/table_widget.dart";
import "package:grabber_app/UI/checkout/checkout_screen.dart";

class ScheduleScreen extends StatefulWidget {
  static String routeName = "ScheduleScreen";

  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime today = DateTime.now();
  List<Map<String, dynamic>> timeSlotData = [
    {"time": "08:00 AM – 09:30 AM", "price": "\$3.50", "isFree": false},
    {"time": "10:00 AM – 11:15 AM", "price": "Free", "isFree": true},
    {"time": "12:30 PM – 01:45 PM", "price": "\$4.99", "isFree": false},
    {"time": "03:00 PM – 04:15 PM", "price": "\$6.25", "isFree": false},
    {"time": "05:30 PM – 06:45 PM", "price": "\$7.75", "isFree": false},
    {"time": "08:00 PM – 09:15 PM", "price": "\$9.99", "isFree": false},
    {"time": "06:30 AM – 07:00 AM", "price": "Free", "isFree": true},
  ];

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, CheckoutScreen.routeName);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
              ),
              Text(
                "Schedule Delivery",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),

          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  spreadRadius: 4,
                  blurRadius: 8,
                  offset: const Offset(8, 8),
                ),
              ],
              gradient: const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  LightThemeData.primaryLightColor,
                  LightThemeData.secondaryLightColor,
                  LightThemeData.secondaryDarkColor,
                ],
              ),
            ),
            child: TableWidget(today: today, onDaySelected: _onDaySelected),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              "Time Slots",
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(

              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: (timeSlotData.length / 3.0).toInt(),
              itemBuilder: (context, index) => Column(
                children: [
                  CustomTimeSlot(
                    title: timeSlotData[index]["time"],
                    price: timeSlotData[index]["price"],
                    isFree: timeSlotData[index]["isFree"],
                  ),
                  CustomTimeSlot(
                    title: timeSlotData[index + 1]["time"],
                    price: timeSlotData[index + 1]["price"],
                    isFree: timeSlotData[index + 1]["isFree"],
                  ),
                  CustomTimeSlot(
                    title: timeSlotData[index + 2]["time"],
                    price: timeSlotData[index + 2]["price"],
                    isFree: timeSlotData[index + 2]["isFree"],
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 4,
                      blurRadius: 8,
                      color: Colors.black.withValues(alpha: 0.2),
                      offset: const Offset(8, 8),
                    ),
                  ],

                  color: Theme.of(context).colorScheme.secondary,
                ),
                child: InkWell(
                  autofocus: true,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text(
                        "Save & Continue",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30,),
        ],
      ),
    );
  }
}
