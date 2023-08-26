import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_demo/providers/providers.dart';
import 'package:sqflite_demo/utils/utils.dart';
import 'common_text_field.dart';

class SelectDateTime extends ConsumerWidget {
  const SelectDateTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final date = ref.watch(dateProvider);
    final time = ref.watch(timeProvider);

    return Row(
      children: [
        Expanded(
          child: CommonTextField(
            title: 'Date',
            hintText: DateFormat.yMMMd().format(date),
            suffixIcon: IconButton(
              onPressed: () => Helpers.selectDate(context, ref),
              icon: const FaIcon(FontAwesomeIcons.calendar),
            ),
            readOnly: true,
          ),
        ),
        const Gap(10),
        Expanded(
          child: CommonTextField(
            title: 'Time',
            hintText: Helpers.timeToString(time),
            suffixIcon: IconButton(
              onPressed: () => _selectTime(context, ref),
              icon: const FaIcon(FontAwesomeIcons.clock),
            ),
            readOnly: true,
          ),
        ),
      ],
    );
  }
}

void _selectTime(BuildContext context, WidgetRef ref) async {
  final initialTime = ref.read(timeProvider);

  TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: initialTime,
  );

  if (pickedTime != null) {
    ref.read(timeProvider.notifier).state = pickedTime;
  }
}
