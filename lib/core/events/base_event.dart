
class BaseEvent {
  String? name;
  Map<String, dynamic>? parameters;

  BaseEvent(String name, Map<String, dynamic> parameters) {
    name = name;
    parameters = parameters;
  }

  @override
  String toString() => "Event_Name: ${name.toString()}\nEvent_Parameters: ${parameters.toString()}";

}
