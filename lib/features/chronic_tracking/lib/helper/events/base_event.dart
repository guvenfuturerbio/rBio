
class BaseEvent {
  String name;
  Map<String, dynamic> parameters;

  BaseEvent(String name, Map<String, dynamic> parameters) {
    this.name = name;
    this.parameters = parameters;
  }

  String toString() => "Event_Name: ${name.toString()}\nEvent_Parameters: ${parameters.toString()}";

}