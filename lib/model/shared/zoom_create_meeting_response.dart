class ZoomCreateMeetingResponse {
  String? uuid;
  int? id;
  String? hostId;
  String? hostEmail;
  String? topic;
  int? type;
  String? status;
  String? startTime;
  int? duration;
  String? timezone;
  String? createdAt;
  String? startUrl;
  String? joinUrl;
  String? password;
  String? h323Password;
  String? pstnPassword;
  String? encryptedPassword;
  Settings? settings;

  ZoomCreateMeetingResponse({
    this.uuid,
    this.id,
    this.hostId,
    this.hostEmail,
    this.topic,
    this.type,
    this.status,
    this.startTime,
    this.duration,
    this.timezone,
    this.createdAt,
    this.startUrl,
    this.joinUrl,
    this.password,
    this.h323Password,
    this.pstnPassword,
    this.encryptedPassword,
    this.settings,
  });

  ZoomCreateMeetingResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'] as String?;
    id = json['id'] as int?;
    hostId = json['host_id'] as String?;
    hostEmail = json['host_email'] as String?;
    topic = json['topic'] as String?;
    type = json['type'] as int?;
    status = json['status'] as String?;
    startTime = json['start_time'] as String?;
    duration = json['duration'] as int?;
    timezone = json['timezone'] as String?;
    createdAt = json['created_at'] as String?;
    startUrl = json['start_url'] as String?;
    joinUrl = json['join_url'] as String?;
    password = json['password'] as String?;
    h323Password = json['h323_password'] as String?;
    pstnPassword = json['pstn_password'] as String?;
    encryptedPassword = json['encrypted_password'] as String?;
    settings = json['settings'] != null
        ? Settings.fromJson(json['settings'] as Map<String, dynamic>)
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uuid'] = uuid;
    data['id'] = id;
    data['host_id'] = hostId;
    data['host_email'] = hostEmail;
    data['topic'] = topic;
    data['type'] = type;
    data['status'] = status;
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['timezone'] = timezone;
    data['created_at'] = createdAt;
    data['start_url'] = startUrl;
    data['join_url'] = joinUrl;
    data['password'] = password;
    data['h323_password'] = h323Password;
    data['pstn_password'] = pstnPassword;
    data['encrypted_password'] = encryptedPassword;
    if (settings != null) {
      data['settings'] = settings?.toJson();
    }
    return data;
  }
}

class Settings {
  bool? hostVideo;
  bool? participantVideo;
  bool? cnMeeting;
  bool? inMeeting;
  bool? joinBeforeHost;
  bool? muteUponEntry;
  bool? watermark;
  bool? usePmi;
  int? approvalType;
  String? audio;
  String? autoRecording;
  bool? enforceLogin;
  String? enforceLoginDomains;
  String? alternativeHosts;
  bool? closeRegistration;
  bool? registrantsConfirmationEmail;
  bool? waitingRoom;
  bool? requestPermissionToUnmuteParticipants;
  bool? registrantsEmailNotification;
  bool? meetingAuthentication;

  Settings({
    this.hostVideo,
    this.participantVideo,
    this.cnMeeting,
    this.inMeeting,
    this.joinBeforeHost,
    this.muteUponEntry,
    this.watermark,
    this.usePmi,
    this.approvalType,
    this.audio,
    this.autoRecording,
    this.enforceLogin,
    this.enforceLoginDomains,
    this.alternativeHosts,
    this.closeRegistration,
    this.registrantsConfirmationEmail,
    this.waitingRoom,
    this.requestPermissionToUnmuteParticipants,
    this.registrantsEmailNotification,
    this.meetingAuthentication,
  });

  Settings.fromJson(Map<String, dynamic> json) {
    hostVideo = json['host_video'] as bool?;
    participantVideo = json['participant_video'] as bool?;
    cnMeeting = json['cn_meeting'] as bool?;
    inMeeting = json['in_meeting'] as bool?;
    joinBeforeHost = json['join_before_host'] as bool?;
    muteUponEntry = json['mute_upon_entry'] as bool?;
    watermark = json['watermark'] as bool?;
    usePmi = json['use_pmi'] as bool?;
    approvalType = json['approval_type'] as int?;
    audio = json['audio'] as String?;
    autoRecording = json['auto_recording'] as String?;
    enforceLogin = json['enforce_login'] as bool?;
    enforceLoginDomains = json['enforce_login_domains'] as String?;
    alternativeHosts = json['alternative_hosts'] as String?;
    closeRegistration = json['close_registration'] as bool?;
    registrantsConfirmationEmail =
        json['registrants_confirmation_email'] as bool?;
    waitingRoom = json['waiting_room'] as bool?;
    requestPermissionToUnmuteParticipants =
        json['request_permission_to_unmute_participants'] as bool?;
    registrantsEmailNotification =
        json['registrants_email_notification'] as bool?;
    meetingAuthentication = json['meeting_authentication'] as bool?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host_video'] = hostVideo;
    data['participant_video'] = participantVideo;
    data['cn_meeting'] = cnMeeting;
    data['in_meeting'] = inMeeting;
    data['join_before_host'] = joinBeforeHost;
    data['mute_upon_entry'] = muteUponEntry;
    data['watermark'] = watermark;
    data['use_pmi'] = usePmi;
    data['approval_type'] = approvalType;
    data['audio'] = audio;
    data['auto_recording'] = autoRecording;
    data['enforce_login'] = enforceLogin;
    data['enforce_login_domains'] = enforceLoginDomains;
    data['alternative_hosts'] = alternativeHosts;
    data['close_registration'] = closeRegistration;
    data['registrants_confirmation_email'] = registrantsConfirmationEmail;
    data['waiting_room'] = waitingRoom;
    data['request_permission_to_unmute_participants'] =
        requestPermissionToUnmuteParticipants;
    data['registrants_email_notification'] = registrantsEmailNotification;
    data['meeting_authentication'] = meetingAuthentication;
    return data;
  }
}
