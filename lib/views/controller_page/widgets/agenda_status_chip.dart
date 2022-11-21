import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({super.key, this.status = AgendaStatus.ongoing});
  final AgendaStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: status.bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        status.statusText,
        style: TextStyle(
          color: status.textColor,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

enum AgendaStatus {
  ongoing('ONGOING', AppColors.yellow1, AppColors.yellowPrimary),
  pending('PENDING', AppColors.greyWhite40, AppColors.grey2),
  complete('COMPLETE', AppColors.lightGreen2, AppColors.greenPrimary);

  const AgendaStatus(this.statusText, this.bgColor, this.textColor);

  final String statusText;
  final Color bgColor;
  final Color textColor;
}

extension AgendaStatusFromString on String? {
  AgendaStatus? get agendaStatus {
    return AgendaStatus.values.firstWhere(
        (element) => element.statusText.toLowerCase() == this,
        orElse: () => AgendaStatus.pending);
  }
}
