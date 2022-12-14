import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../core/core.dart';
import '../../progress_sections/glucose_progress/view_model/bg_progress_page_view_model.dart';
import '../glucose_margins_filter.dart';
import 'bg_filter_pop_up_vm.dart';

class BgFilterPopUp extends StatelessWidget {
  final double width;
  final double height;
  const BgFilterPopUp({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.all(10),
        elevation: 0,
        child: ChangeNotifierProvider(
          create: (_) => BgFilterPopUpVm(
              filters:
                  Provider.of<BgProgressPageViewModel>(context, listen: false)
                      .filterState),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Atom.width * .03),
            child: SizedBox(
              width: width,
              child: Card(
                elevation: R.sizes.defaultElevation,
                color: R.color.bg_gray,
                shape: RoundedRectangleBorder(
                  borderRadius: R.sizes.borderRadiusCircular,
                ),
                child: Consumer<BgFilterPopUpVm>(
                  builder: (_, value, __) => SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Atom.height * .01),
                          child: Column(
                            children: value.colorInfo.keys
                                .map((color) => _colorFilterItem(
                                    text:
                                        value.colorInfo[color]!.toShortString(),
                                    status: value.isFilterSelected(
                                        value.colorInfo[color]!),
                                    color: color,
                                    size: 15,
                                    statCallback: (_) => value
                                        .changeFilter(value.colorInfo[color]!),
                                    isHungry: false))
                                .toList(),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: Atom.height * .01),
                          child: Column(
                            children: value.states
                                .map((state) => _colorFilterItem(
                                    text: state.toShortString(),
                                    status: value.isFilterSelected(state),
                                    color: R.color.state_color,
                                    size: 15,
                                    style: state == GlucoseMarginsFilter.full ||
                                            state == GlucoseMarginsFilter.hungry
                                        ? BoxShape.circle
                                        : BoxShape.rectangle,
                                    statCallback: (_) =>
                                        value.changeFilter(state),
                                    isHungry:
                                        state == GlucoseMarginsFilter.hungry))
                                .toList(),
                          ),
                        ),
                        Wrap(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<BgProgressPageViewModel>(context,
                                        listen: false)
                                    .cancelSelections();
                                Atom.dismiss();
                              },
                              child: Card(
                                elevation: R.sizes.defaultElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: R.sizes.borderRadiusCircular,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: <Color>[
                                          R.color.white,
                                          R.color.white
                                        ]),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    LocaleProvider.current.cancel,
                                    softWrap: false,
                                    style: const TextStyle(
                                        color: Colors.black, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Provider.of<BgProgressPageViewModel>(context,
                                        listen: false)
                                    .updateFilterState();
                                Atom.dismiss();
                              },
                              child: Card(
                                elevation: R.sizes.defaultElevation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: R.sizes.borderRadiusCircular,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    gradient: LinearGradient(
                                        begin: Alignment.bottomRight,
                                        end: Alignment.topLeft,
                                        colors: <Color>[
                                          R.color.btnLightBlue,
                                          R.color.btnDarkBlue
                                        ]),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Text(
                                    LocaleProvider.current.save,
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    softWrap: false,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 17),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TextButton(
                            onPressed: () {
                              Provider.of<BgProgressPageViewModel>(context,
                                      listen: false)
                                  .resetFilterValues();
                              value.resetFilterValues();
                            },
                            child: Text(
                                LocaleProvider.current.reset_filter_value,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    decoration: TextDecoration.underline)))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding _colorFilterItem(
      {double? size,
      required String text,
      required Color color,
      bool? status,
      BoxShape? style,
      Function(bool?)? statCallback,
      required bool isHungry}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 25),
            height: size,
            width: size,
            decoration: BoxDecoration(
              shape: style ?? BoxShape.circle,
              color: isHungry ? Colors.transparent : color,
              border: Border.all(
                color: color,
                width: 2.0,
              ),
            ),
          ),
          Expanded(flex: 2, child: Text(text)),
          Expanded(
              child: SizedBox(
                  height: size,
                  width: size,
                  child: Checkbox(value: status, onChanged: statCallback)))
        ],
      ),
    );
  }
}
