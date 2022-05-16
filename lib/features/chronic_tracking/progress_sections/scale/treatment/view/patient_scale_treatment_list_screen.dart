import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

class PatientScaleTreatmentListScreen extends StatelessWidget {
  const PatientScaleTreatmentListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: RbioAppBar(),
      body: Column(
        children: [
          RbioTreatmentCard(
            title: "Diyet Listesi",
            description: "Tedavi notları",
            dateTime: DateTime.now(),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class RbioTreatmentCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dateTime;
  final VoidCallback onTap;

  const RbioTreatmentCard({
    Key? key,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
