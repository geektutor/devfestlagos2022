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
          padding: EdgeInsets.only(top: 22, left: 32),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 20,
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Column(
                    children: [
                      buildDot(
                          size: 24,
                          color: Color(0xffF0F6FE),
                          child: Center(
                              child:
                                  buildDot(size: 8, color: Color(0xff4285F4)))),
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
                  SizedBox(
                    width: 6,
                  ),
                  // Column(
                  //   children: [
                  //     TextField(
                  //       controller: vm.your_location_ctrl,
                  //       decoration: InputDecoration(
                  //           hintText: 'Your Location',
                  //           border: OutlineInputBorder(
                  //               borderRadius: BorderRadius.circular(5),
                  //               borderSide:
                  //                   BorderSide(color: AppColors.grey16))),
                  //     )
                  //   ],
                  // )
                ],
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
