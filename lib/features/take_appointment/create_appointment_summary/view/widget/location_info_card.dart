// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class LocationInfoCard extends StatelessWidget {
  final TextEditingController _countryController;
  final TextEditingController _cityController;
  final Function() countryOnTap;
  final Function() cityOnTap;
  final bool isCityVisible;

  const LocationInfoCard({
    Key? key,
    required TextEditingController countryController,
    required TextEditingController cityController,
    required this.countryOnTap,
    required this.cityOnTap,
    required this.isCityVisible,
  })  : _countryController = countryController,
        _cityController = cityController,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.xCardColor,
        borderRadius: R.sizes.borderRadiusCircular,
      ),
      child: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        //
        Text(
          LocaleProvider.of(context).where_will_you_attend_the_meeting,
          style: context.xHeadline4.copyWith(fontWeight: FontWeight.bold),
        ),

        //
        R.widgets.hSizer16,

        //
        RbioTextFormField(
          controller: _countryController,
          readOnly: true,
          hintText: LocaleProvider.of(context).country,
          prefixIcon: Icon(Icons.language, color: context.xPrimaryColor),
          onTap: countryOnTap,
        ),

        //
        R.widgets.hSizer12,

        //
        Visibility(
          visible: isCityVisible,
          child: RbioTextFormField(
            controller: _cityController,
            readOnly: true,
            hintText: LocaleProvider.of(context).city,
            prefixIcon: Icon(
              Icons.location_city,
              color: _cityController.text.isEmpty
                  ? Colors.grey
                  : context.xPrimaryColor,
            ),
            onTap: cityOnTap,
          ),
        ),
      ],
    );
  }
}
