import 'dart:ffi';

import 'package:devfest/core/router/navigator.dart';
import 'package:devfest/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:devfest/core/state/providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:devfest/utils/extensions/extensions.dart';
import 'package:gap/gap.dart';

class MapSearchPage extends StatefulHookConsumerWidget {
  const MapSearchPage({super.key});

  @override
  ConsumerState<MapSearchPage> createState() => _MapSearchPageState();
}

class _MapSearchPageState extends ConsumerState<MapSearchPage> {
  @override
  Widget build(BuildContext context) {
    var vm = ref.watch(mapsVm);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 22, left: 32, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 14,
                  // ),
                  Spacer(),
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 16,
                        ),
                        buildDot(
                            size: 24,
                            color: Color(0xffF0F6FE),
                            child: Center(
                                child: buildDot(
                                    size: 8, color: Color(0xff4285F4)))),
                        SizedBox(
                          height: 9,
                        ),
                        buildDot(size: 4, color: AppColors.grey16),
                        SizedBox(
                          height: 9,
                        ),
                        buildDot(size: 4, color: AppColors.grey16),
                        SizedBox(
                          height: 9,
                        ),
                        buildDot(size: 4, color: AppColors.grey16),
                        SizedBox(
                          height: 12.25,
                        ),
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xffEA4335),
                        )
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   width: 6,
                  // ),
                  Spacer(
                      //flex: 1
                      ),
                  Expanded(
                    flex: 16,
                    child: Column(
                      children: [
                        buildLocationTextField(
                            vm.your_location_ctrl, 'Your Location'),
                        SizedBox(
                          height: 16,
                        ),
                        buildLocationTextField(
                            vm.landmark_ctrl, 'Landmark Event Center'),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 6,
              ),
              Divider(),
              Text(
                'Results',
                style: TextStyle(color: AppColors.grey6, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              GestureDetector(
                onTap: (() {
                  Navigator.of(context).pop('BA Street Shagari Estate');
                }),
                child: Row(
                  children: [
                    buildDot(
                      size: 48,
                      color: Color(0xffEDEEF1),
                      child: Image.asset(
                        'assets/images/png/Vector.png',
                        width: 22,
                        height: 22,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BA Street Shagari Estate',
                          style:
                              TextStyle(color: AppColors.grey0, fontSize: 18),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Lagos',
                          style:
                              TextStyle(color: AppColors.grey6, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildDot({required double size, required Color color, Widget? child}) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(100),
    ),
    child: Center(child: child),
  );
}

Widget buildLocationTextField(TextEditingController controller, String title) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
        hintText: title,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: AppColors.grey16))),
  );
}
