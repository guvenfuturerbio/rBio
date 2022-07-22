part of '../view/create_appointment_screen.dart';

Widget _buildHistoryDoctorCard(
  BuildContext context,
  String? doctorName,
  CreateAppointmentVm vm,
  int index,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: GestureDetector(
      onTap: () {
        vm.fillFromFavorites(index);
      },
      child: SizedBox(
        width: Atom.width * .15,
        child: Column(
          children: [
            ClipOval(
              child: Image.network(
                vm.doctorsImageUrls[index],
                fit: BoxFit.cover,
                width: Atom.width * .07,
                height: Atom.width * .07,
              ),
            ),

            //
            Text(
              doctorName ?? "",
              maxLines: 3,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                color: context.xAppColors.grey,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
