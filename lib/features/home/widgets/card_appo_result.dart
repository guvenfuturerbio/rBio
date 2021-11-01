import 'package:atom/atom.dart';
import 'package:flutter/material.dart';

enum WidgetType { RESULT, APPOINTMENT }

class CardAppoResult extends StatelessWidget {
  final String tenantName;
  final String doctorName;
  final String departmentName;
  final String date;
  final String time;
  final Icon icon;
  final WidgetType widgetype;
  final bool isActive;

  const CardAppoResult(
      {Key key, 
      this.tenantName,
      this.doctorName,
      this.departmentName,
      this.date,
      this.time,
      this.icon,
      this.widgetype,
      this.isActive = false})
      : super(key: key);

  factory CardAppoResult.appointment({
    String tenantName,
    String doctorName,
    String departmentName,
    String date,
    String time,
    Icon icon,
  }) {
    return CardAppoResult(
      date: date,
      departmentName: departmentName,
      doctorName: doctorName,
      tenantName: tenantName,
      time: time,
      icon: icon,
      widgetype: WidgetType.APPOINTMENT,
    );
  }

  factory CardAppoResult.result(
      {String tenantName,
      String doctorName,
      String departmentName,
      String date,
      bool isActive}) {
    return CardAppoResult(
      date: date,
      departmentName: departmentName,
      doctorName: doctorName,
      tenantName: tenantName,
      isActive: isActive,
      widgetype: WidgetType.RESULT,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (Atom.height * .06) + (Atom.height * .2),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent.withOpacity(0.3),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            width: Atom.width * 0.94,
            height: Atom.height * 0.05,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    tenantName,
                    style: const TextStyle(fontSize: 18),
                  ),
                  widgetype == WidgetType.APPOINTMENT ? icon : const SizedBox()
                ],
              ),
            ),
          ),

          //
          Container(
            width: Atom.width * 0.94,
            height: Atom.height * 0.2,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Doktor Adı",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade400)),
                      Text(doctorName, style: const TextStyle(fontSize: 17))
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bölüm",
                          style: TextStyle(
                              fontSize: 17, color: Colors.grey.shade400)),
                      Text(departmentName, style: const TextStyle(fontSize: 17))
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Tarih",
                              style: TextStyle(
                                  fontSize: 17, color: Colors.grey.shade400),
                            ),
                            Text(
                              date,
                              style: const TextStyle(fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Spacer(flex: widgetype == WidgetType.RESULT ? 2 : 1),
                      widgetype == WidgetType.APPOINTMENT
                          ? Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Saat",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey.shade400)),
                                  Text(time,
                                      style: const TextStyle(fontSize: 17))
                                ],
                              ),
                            )
                          : ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade700,
                                  onSurface: Colors.green,
                                  shape: (RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0),
                                  ))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 12.0),
                                child: Text(
                                  isActive ? "Görüntüle" : "Bekleniyor",
                                  style: const TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                              onPressed: isActive
                                  ? () {
                                      print("Work");
                                    }
                                  : null,
                            ),
                      widgetype == WidgetType.RESULT
                          ? const SizedBox()
                          : const Spacer()
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
