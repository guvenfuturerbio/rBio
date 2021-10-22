class GetAvailabilityRateRequest {
  int availabilityId;

  GetAvailabilityRateRequest({
    this.availabilityId,
  });

  factory GetAvailabilityRateRequest.fromJson(Map<String, dynamic> json) =>
      GetAvailabilityRateRequest(
        availabilityId: json['availability_id'] as int,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'availability_id': availabilityId,
      };
}
