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
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    ref.watch(mapsVm).initializePlaces();
    ref.watch(mapsVm).initializeFocusNode(FocusNode());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //ref.watch(mapsVm).getStartFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vm = ref.watch(mapsVm);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: PageScrollPhysics(),
        child: SafeArea(
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
                              AppNavigator.pop();
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
                              controller: vm.yourlocation_ctrl,
                              title: 'Your Location',
                              onChanged: vm.onChanged,
                              focusNode: vm.getStartFocusNode,
                              suffixIcon: vm.yourlocation_ctrl.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: vm.clearSearchField,
                                      icon: Icon(
                                        Icons.cancel_outlined,
                                        color: Colors.black,
                                      ))
                                  : null),
                          SizedBox(
                            height: 16,
                          ),
                          buildLocationTextField(
                              controller: vm.landmarkctrl,
                              title: 'Landmark Event Center',
                              enabled: false),
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
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: vm.predictions.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          vm.onTap(index);
                        },
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/png/Vector.png',
                            width: 22,
                            height: 22,
                          ),
                          title: Text(
                            vm.predictions[index].description.toString(),
                            style:
                                TextStyle(color: AppColors.grey0, fontSize: 18),
                          ),
                          subtitle: Text(
                            'Lagos',
                            style:
                                TextStyle(color: AppColors.grey6, fontSize: 14),
                          ),
                          horizontalTitleGap: 2,
                        ),
                      );
                    })
              ],
            ),
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

Widget buildLocationTextField({
  required TextEditingController controller,
  required String title,
  bool? enabled,
  void Function(String)? onChanged,
  FocusNode? focusNode,
  Widget? suffixIcon,
}) {
  return TextField(
    controller: controller,
    decoration: InputDecoration(
      hintText: title,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.grey16)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: AppColors.grey16)),
      suffixIcon: suffixIcon,
    ),
    cursorColor: Colors.black,
    enabled: enabled,
    onChanged: onChanged,
    focusNode: focusNode,
  );
}
