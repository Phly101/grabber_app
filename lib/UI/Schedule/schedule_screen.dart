import "package:flutter/material.dart";
import "package:grabber_app/LocalizationHelper/localization_helper.dart";

import "package:grabber_app/Theme/theme.dart";
import "package:grabber_app/UI/Schedule/Widget/custom_time_slot.dart";
import "package:grabber_app/UI/Schedule/Widget/table_widget.dart";
import "package:grabber_app/Utils/routes.dart";
import "package:grabber_app/common/gradient_widget_container.dart";

import "../../l10n/app_localizations.dart";
class ScheduleScreen extends StatefulWidget {

  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime today = DateTime.now();
  List<Map<String, dynamic>> timeSlotData = [
    {"time": "time0800to0930", "price": "\$3.50", "isFree": false},
    {"time": "time1000to1115", "price": "free", "isFree": true},
    {"time": "time1230to0145v", "price": "\$4.99", "isFree": false},
    {"time": "time0300to0415", "price": "\$6.25", "isFree": false},
    {"time": "time0530to0645", "price": "\$7.75", "isFree": false},
    {"time": "time0800to0915", "price": "\$9.99", "isFree": false},
    {"time": "time0630to0700", "price": "free", "isFree": true},
  ];

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            const SizedBox(
              height: 30,
            ),
        
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
        
                      Navigator.pushNamed(context, AppRoutes.checkout);
        
                    },
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                ),
                Text(
        
                    AppLocalizations.of(context)!.scheduleDelivery,
        
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
        
        
            GradientWidgetContainer(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
        
        
              child: TableWidget(today: today, onDaySelected: _onDaySelected),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
        
                AppLocalizations.of(context)!.timeSlots,
        
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: (timeSlotData.length / 3.0).toInt(),
                itemBuilder: (context, index) => Column(
                  children: [
                    CustomTimeSlot(
                      title: LocalizationHelper.getString(context, timeSlotData[index]["time"]),
                      price: LocalizationHelper.getString(context, timeSlotData[index]["price"]),
                      isFree: timeSlotData[index]["isFree"],
                    ),
                    CustomTimeSlot(
                      title: LocalizationHelper.getString(context, timeSlotData[index + 1]["time"]),
                      price: LocalizationHelper.getString(context, timeSlotData[index + 1]["price"]),
                      isFree: timeSlotData[index + 1]["isFree"],
                    ),
                    CustomTimeSlot(
                      title: LocalizationHelper.getString(context, timeSlotData[index + 2]["time"]),
                      price: LocalizationHelper.getString(context, timeSlotData[index + 2]["price"]),
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
        
        
                    color: AppColors.textButtonColor,
                  ),
                  child: InkWell(
                    autofocus: true,
                    onTap: () {
                    Navigator.popAndPushNamed(context, AppRoutes.checkout);
                    },
        
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
        
                            AppLocalizations.of(context)!.saveAndContinue,
        
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
        
            const SizedBox(
              height: 30,
            ),
        
          ],
        ),
      ),
    );
  }
}
