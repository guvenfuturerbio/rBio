import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../../core/core.dart';
import '../../scale.dart';

class PatientScaleDietDetailScreen extends StatelessWidget {
  const PatientScaleDietDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? itemId;

    try {
      final routeParam = Atom.queryParameters['itemId'];
      itemId = int.tryParse(routeParam!);
    } catch (e, stackTrace) {
      return RbioRouteError(e: e, stackTrace: stackTrace);
    }

    return BlocProvider<PatientScaleDietDetailCubit>(
      create: (context) =>
          PatientScaleDietDetailCubit(getIt())..fetchAll(itemId!),
      child: const PatientScaleDietDetailView(),
    );
  }
}

class PatientScaleDietDetailView extends StatefulWidget {
  const PatientScaleDietDetailView({Key? key}) : super(key: key);

  @override
  State<PatientScaleDietDetailView> createState() =>
      _PatientScaleDietDetailViewState();
}

class _PatientScaleDietDetailViewState
    extends State<PatientScaleDietDetailView> {
  late TextEditingController _breakfastEditingController;
  late TextEditingController _breakfastRefreshmentEditingController;
  late TextEditingController _lunchEditingController;
  late TextEditingController _lunchRefreshmentEditingController;
  late TextEditingController _dinnerEditingController;
  late TextEditingController _dinnerRefreshmentEditingController;

  @override
  void initState() {
    super.initState();
    _breakfastEditingController = TextEditingController();
    _breakfastRefreshmentEditingController = TextEditingController();
    _lunchEditingController = TextEditingController();
    _lunchRefreshmentEditingController = TextEditingController();
    _dinnerEditingController = TextEditingController();
    _dinnerRefreshmentEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _breakfastEditingController.dispose();
    _breakfastRefreshmentEditingController.dispose();
    _lunchEditingController.dispose();
    _lunchRefreshmentEditingController.dispose();
    _dinnerEditingController.dispose();
    _dinnerRefreshmentEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RbioScaffold(
      appbar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  RbioAppBar _buildAppBar(BuildContext context) => RbioAppBar(
        title: RbioAppBar.textTitle(
          context,
          LocaleProvider.of(context).diet_list,
        ),
      );

  Widget _buildBody() {
    return BlocConsumer<PatientScaleDietDetailCubit,
        PatientScaleDietDetailState>(
      listener: (context, state) {
        state.whenOrNull(
          success: (response) {
            _breakfastEditingController.text = response.dietBreakfast ?? '';
            _breakfastRefreshmentEditingController.text =
                response.dietRefreshmentBreakfast ?? '';
            _lunchEditingController.text = response.dietLunch ?? '';
            _lunchRefreshmentEditingController.text =
                response.dietRefreshmentLunch ?? '';
            _dinnerEditingController.text = response.dietDinner ?? '';
            _dinnerRefreshmentEditingController.text =
                response.dietRefreshmentDinner ?? '';
          },
        );
      },
      builder: (context, state) {
        return state.when(
          initial: () => const SizedBox(),
          loadInProgress: () => const RbioLoading(),
          success: (result) => _buildSuccess(context, result),
          failure: () => const RbioBodyError(),
        );
      },
    );
  }

  Widget _buildSuccess(
    BuildContext context,
    ScaleTreatmentDietDetailResponse result,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          _buildTitle(
            context,
            LocaleProvider.of(context).breakfast,
          ),
          _buildTextFormField(
            _breakfastEditingController,
            R.image.clockBreakfast,
          ),

          //
          R.sizes.hSizer8,

          //
          _buildTitle(
            context,
            LocaleProvider.of(context).refreshment,
          ),
          _buildTextFormField(
            _breakfastRefreshmentEditingController,
            R.image.clockRefreshment,
          ),

          //
          R.sizes.hSizer8,

          //
          _buildTitle(
            context,
            LocaleProvider.of(context).lunch,
          ),
          _buildTextFormField(
            _lunchEditingController,
            R.image.clockLunch,
          ),

          //
          R.sizes.hSizer8,

          //
          _buildTitle(
            context,
            LocaleProvider.of(context).refreshment,
          ),
          _buildTextFormField(
            _lunchRefreshmentEditingController,
            R.image.clockRefreshment,
          ),

          //
          R.sizes.hSizer8,

          //
          _buildTitle(
            context,
            LocaleProvider.of(context).dinner,
          ),
          _buildTextFormField(
            _dinnerEditingController,
            R.image.clockDinner,
          ),

          //
          R.sizes.hSizer8,

          //
          _buildTitle(
            context,
            LocaleProvider.of(context).refreshment,
          ),
          _buildTextFormField(
            _dinnerRefreshmentEditingController,
            R.image.clockRefreshment,
          ),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: context.xHeadline3.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller,
    String imagePath,
  ) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        //
        RbioTextFormField(
          minLines: 1,
          maxLines: null,
          enabled: false,
          controller: controller,
          contentPadding: const EdgeInsets.all(12),
        ),

        //
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            imagePath,
            height: R.sizes.iconSize2,
            width: R.sizes.iconSize2,
          ),
        ),
      ],
    );
  }
}
