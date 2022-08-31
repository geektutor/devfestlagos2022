import 'package:devfest/utils/colors.dart';
import 'package:devfest/widgets/speaker_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:devfest/widgets/touchable_opacity.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SpeakersPage extends StatefulWidget {
  const SpeakersPage({Key? key}) : super(key: key);
  @override
  State<SpeakersPage> createState() => _SpeakersPageState();
}

class _SpeakersPageState extends State<SpeakersPage> {
  List<String> categories = [
    'All',
    'Career',
    'Design',
    'Web3',
    'Product Management'
  ];

  List speakerDets = [
    Speaker(
        firstName: 'Aise',
        lastName: 'Idahor',
        avatar: 'Aise',
        role: 'Product Designer, Valist',
        time: '9.00 AM',
        topic: 'Building a Career In the Web3 Space',
        venue: 'Hall A',
        backgroundImage: 'Rectangle_1',
        category: 'Career'),
    Speaker(
        firstName: 'Sodiq',
        lastName: 'Akinjobi',
        avatar: 'Sodiq',
        role: 'Lead Product Manager, Google',
        time: '9.00 AM',
        topic: 'Understanding Product Management',
        venue: 'Hall A',
        backgroundImage: 'Rectangle_2',
        category: 'Product Management'),
    Speaker(
        firstName: 'Sodiq',
        lastName: 'Akinjobi',
        avatar: 'Sodiq',
        role: 'Lead Product Manager, Google',
        time: '9.00 AM',
        topic: 'Understanding Product Management',
        venue: 'Hall A',
        backgroundImage: 'Rectangle_3',
        category: 'Product Management'),
  ];

  int selectedCategory = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            Gap(28),
            Text(
              'Speakers',
              style: TextStyle(
                  color: AppColors.grey0,
                  fontSize: 28,
                  fontWeight: FontWeight.w500),
            ),
            Gap(24),
            SizedBox(
              height: 31,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: ((context, index) {
                  return Row(
                    children: [
                      TouchableOpacity(
                        onTap: () {
                          setState(() {
                            selectedCategory = index;
                          });
                        },
                        child: Chip(
                          backgroundColor: selectedCategory == index
                              ? AppColors.blue1
                              : AppColors.white,
                          label: Text(
                            categories[index],
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: selectedCategory == index
                                    ? AppColors.blue7
                                    : AppColors.grey6),
                          ),
                          labelPadding: EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          side: BorderSide(
                              color: selectedCategory == index
                                  ? AppColors.blue1
                                  : AppColors.grey16,
                              width: 2),
                        ),
                      ),
                      Gap(8),
                    ],
                  );
                }),
              ),
            ),
            Column(
                children: speakerDets
                    .map((e) => SpeakerCard(
                          backgroundImage: e.backgroundImage,
                          title: e.topic,
                          avatar: e.avatar,
                          firstName: e.firstName,
                          lastName: e.lastName,
                          role: e.role,
                          time: e.time,
                          venue: e.venue,
                          category: e.category,
                        ))
                    .toList())
          ],
        ),
      ),
    );
  }
}
