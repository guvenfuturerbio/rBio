part of '../shopping_cart_screen.dart';

class QuantityDropdown extends StatefulWidget {
  const QuantityDropdown({Key? key}) : super(key: key);

  @override
  State<QuantityDropdown> createState() => _QuantityDropdownState();
}

class _QuantityDropdownState extends State<QuantityDropdown> {
  final TextEditingController quantity = TextEditingController(text: '1');

  String dropdownValue = '1';

  @override
  Widget build(BuildContext context) {
    return dropdownValue != '10+'
        ? DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: context.xPrimaryColor,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['1', '2', '3', '4', '5', '6', '7', '8', '9', '10+']
                .map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          )
        : Row(
            children: [
              //
              const Text("Adet: "),

              //
              Container(
                constraints: const BoxConstraints(maxHeight: 50, maxWidth: 50),
                child: TextFormField(
                  controller: quantity,
                  style: Utils.instance.inputTextStyle(context),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(),
                ),
                margin: const EdgeInsets.only(bottom: 20),
              ),

              //
              const SizedBox(
                width: 5,
              ),

              //
              Utils.instance.button(
                context: context,
                text: "Update",
                width: 30,
                height: 12,
                onPressed: () {
                  LoggerUtils.instance.i("Update worked!");
                },
              ),
            ],
          );
  }
}
