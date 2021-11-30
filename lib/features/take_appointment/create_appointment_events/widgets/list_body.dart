part of '../view/create_appointment_events_screen.dart';

class ListBody extends StatefulWidget {
  final ValueNotifier<_EventSelectedModel> completeNotifier;
  final CreateAppointmentEventsVm vm;
  final void Function() onSubmit;

  const ListBody({
    Key key,
    @required this.completeNotifier,
    @required this.vm,
    @required this.onSubmit,
  }) : super(key: key);

  @override
  State<ListBody> createState() => _ListBodyState();
}

class _ListBodyState extends State<ListBody>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    offset = Tween<Offset>(
      begin: Offset(0.0, -0.3),
      end: Offset(0.0, 0.0),
    ).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        //
        if (widget.vm.availableSlots?.keys?.isEmpty) ...[
          Positioned.fill(
            child: Center(
              child: Text(
                'Not Found!',
                style: context.xHeadline3,
              ),
            ),
          ),
        ] else ...[
          Positioned.fill(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                //
                Expanded(
                  flex: 9,
                  child: _buildLeftList(context),
                ),

                //
                Expanded(
                  flex: 3,
                  child: SizedBox(),
                ),

                //
                Expanded(
                  flex: 9,
                  child: _buildRightList(),
                ),
              ],
            ),
          ),
        ],

        //
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewPadding.bottom,
            ),
            child: ValueListenableBuilder(
              valueListenable: widget.completeNotifier,
              builder: (BuildContext context, _EventSelectedModel selectedModel,
                  Widget child) {
                return RbioSwitcher(
                  showFirstChild:
                      selectedModel != null && selectedModel.selected != null,
                  child1: child,
                  child2: SizedBox(),
                );
              },
              child: RbioElevatedButton(
                onTap: widget.onSubmit,
                title: "Randevu Oluştur",
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLeftList(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.completeNotifier,
      builder: (
        BuildContext context,
        _EventSelectedModel selectedModel,
        Widget child,
      ) {
        return SingleChildScrollView(
          padding: EdgeInsets.zero,
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              for (var item in widget.vm.availableSlots?.keys ?? []) ...[
                _buildLeftCard(
                  context,
                  item,
                  widget.vm.availableSlots[item],
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildLeftCard(
    BuildContext context,
    String value,
    List<ResourcesRequest> items,
  ) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          widget.completeNotifier.value = _EventSelectedModel(
            value: value,
            items: items,
          );
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.symmetric(
            vertical: 7,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.completeNotifier.value?.value == value
                ? getIt<ITheme>().mainColor
                : getIt<ITheme>().cardBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            '${value}:00',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline2.copyWith(
              color: widget.completeNotifier.value?.value == value
                  ? getIt<ITheme>().textColor
                  : getIt<ITheme>().textColorSecondary,
            ),
          ),
        ),
      ),
    );
  }

  _EventSelectedModel oldModel;
  Widget _buildRightList() {
    return ValueListenableBuilder(
      valueListenable: widget.completeNotifier,
      builder: (
        BuildContext context,
        _EventSelectedModel selectedModel,
        Widget child,
      ) {
        if (selectedModel == null) {
          return SizedBox();
        }

        if (oldModel?.value != selectedModel.value) {
          controller.reset();
          controller.forward();
        }
        oldModel = selectedModel;

        return SlideTransition(
          position: offset,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: selectedModel.items
                  .map((e) => _buildRightCard(context, e))
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  Widget _buildRightCard(BuildContext context, ResourcesRequest item) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          final notifierValue = widget.completeNotifier.value;
          widget.completeNotifier.value = _EventSelectedModel(
            items: notifierValue.items,
            value: notifierValue.value,
            selected: item,
          );
        },
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.symmetric(
            vertical: 7,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.completeNotifier.value.selected?.from == item.from
                ? getIt<ITheme>().mainColor
                : getIt<ITheme>().cardBackgroundColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            '${item.from.substring(11, 16)} : ${item.to.substring(11, 16)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.xHeadline2.copyWith(
              color: widget.completeNotifier.value.selected?.from == item.from
                  ? getIt<ITheme>().textColor
                  : getIt<ITheme>().textColorSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
