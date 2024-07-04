import 'package:date_picker_v2/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:model_house/model_house.dart';

class UserProfileUpdateScreen extends StatefulWidget {
  static const String routeName = '/UserProfileUpdate';
  const UserProfileUpdateScreen({super.key});

  @override
  State<UserProfileUpdateScreen> createState() =>
      _UserProfileUpdateScreenState();
}

class _UserProfileUpdateScreenState extends State<UserProfileUpdateScreen> {
  final displayNameController = TextEditingController();
  String? gender;
  int? birthYear;
  int? birthMonth;
  int? birthDay;
  @override
  void initState() {
    super.initState();

    displayNameController.text = my?.displayName ?? '';
    birthYear = my?.birthYear;
    birthMonth = my?.birthMonth;
    birthDay = my?.birthDay;
    gender = my?.gender;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Profile'.t),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LabelField(
                label: 'displayName'.t, controller: displayNameController),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                bottom: 2,
              ),
              child: Text(
                'gender'.t,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Male'),
                    value: 'M',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RadioListTile<String>(
                    title: const Text('Female'),
                    value: 'F',
                    groupValue: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            DatePicker(
              endYear: DateTime.now().year,
              beginYear: DateTime.now().year - 100,
              ascendingYear: false,
              initialDate: (year: birthYear, month: birthMonth, day: birthDay),
              onChanged: (year, month, day) {
                birthYear = year;
                birthMonth = month;
                birthDay = day;
                setState(() {});
              },
              labelYear: '   ${'year'.t}',
              labelMonth: ' ${'month'.t}',
              labelDay: ' ${'day'.t}',
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  my?.update(
                    displayName: displayNameController.text,
                    birthYear: birthYear,
                    birthMonth: birthMonth,
                    birthDay: birthDay,
                    gender: gender,
                  );
                },
                child: Text('Update'.t),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
