import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/core.dart';

abstract class IBaseBottomActionsOfGraph {
  void showFilter(BuildContext context);
  void changeGraphType();
  void changeChartShowStatus();
}

class BottomActionsOfGraph extends StatelessWidget {
  final IBaseBottomActionsOfGraph value;

  const BottomActionsOfGraph({
    Key? key,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Wrap(
        spacing: context.width * .1,
        runSpacing: context.height * .01,
        alignment: WrapAlignment.center,
        children: [
          //
          ElevatedButton(
            onPressed: () => value.showFilter(context),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.black.withAlpha(50),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.height),
              ),
            ),
            child: AutoSizeText(
              LocaleProvider.current.filter_graphs,
              maxLines: 1,
              style: context.xHeadline5.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //
          ElevatedButton(
            onPressed: () => value.changeGraphType(),
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.black.withAlpha(50),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(context.height),
              ),
            ),
            child: AutoSizeText(
              LocaleProvider.current.change_graph_type,
              maxLines: 1,
              softWrap: false,
              style: context.xHeadline5.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
