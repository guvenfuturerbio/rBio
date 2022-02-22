import '../../../core/core.dart';

class DoctorCvResponse extends IBaseModel<DoctorCvResponse> {
  int? id;
  String? title;
  String? firstName;
  String? lastName;
  String? birthplace;
  String? birthdate;
  List<Specialties>? specialties;
  List<Treatments>? treatments;
  List<Experiences>? experiences;
  List<Educations>? educations;
  List<Publications>? publications;
  List<Memberships>? memberships;
  List<Trainings>? trainings;
  List<Awards>? awards;
  String? identity;
  String? location;
  String? email;
  String? emailPersonal;
  String? phone;
  String? slug;
  String? image1;
  String? image2;
  String? image3;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? foreign;
  int? isCompleted;
  String? notes;

  DoctorCvResponse({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.birthplace,
    this.birthdate,
    this.specialties,
    this.treatments,
    this.experiences,
    this.educations,
    this.publications,
    this.memberships,
    this.trainings,
    this.awards,
    this.identity,
    this.location,
    this.email,
    this.emailPersonal,
    this.phone,
    this.slug,
    this.image1,
    this.image2,
    this.image3,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.foreign,
    this.isCompleted,
    this.notes,
  });

  DoctorCvResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int?;
    title = json['title'] as String?;
    firstName = json['first_name'] as String?;
    lastName = json['last_name'] as String?;
    birthplace = json['birthplace'] as String?;
    birthdate = json['birthdate'] as String?;
    if (json['specialties'] != null) {
      specialties = <Specialties>[];
      json['specialties'].forEach((v) {
        specialties?.add(Specialties.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['treatments'] != null) {
      treatments = <Treatments>[];
      json['treatments'].forEach((v) {
        treatments?.add(Treatments.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['experiences'] != null) {
      experiences = <Experiences>[];
      json['experiences'].forEach((v) {
        experiences?.add(Experiences.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['educations'] != null) {
      educations = <Educations>[];
      json['educations'].forEach((v) {
        educations?.add(Educations.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['publications'] != null) {
      publications = <Publications>[];
      json['publications'].forEach((v) {
        publications?.add(Publications.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['memberships'] != null) {
      memberships = <Memberships>[];
      json['memberships'].forEach((v) {
        memberships?.add(Memberships.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['trainings'] != null) {
      trainings = <Trainings>[];
      json['trainings'].forEach((v) {
        trainings?.add(Trainings.fromJson(v as Map<String, dynamic>));
      });
    }
    if (json['awards'] != null) {
      awards = <Awards>[];
      json['awards'].forEach((v) {
        awards?.add(Awards.fromJson(v as Map<String, dynamic>));
      });
    }
    identity = json['identity'] as String?;
    location = json['location'] as String?;
    email = json['email'] as String?;
    emailPersonal = json['email_personal'] as String?;
    phone = json['phone'] as String?;
    slug = json['slug'] as String?;
    image1 = json['image_1'] as String?;
    image2 = json['image_2'] as String?;
    image3 = json['image_3'] as String?;
    createdAt = json['created_at'] as String?;
    updatedAt = json['updated_at'] as String?;
    deletedAt = json['deleted_at'] as String?;
    foreign = json['foreign'] as String?;
    isCompleted = json['is_completed'] as int?;
    notes = json['notes'] as String?;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['birthplace'] = birthplace;
    data['birthdate'] = birthdate;
    if (specialties != null) {
      data['specialties'] = specialties?.map((v) => v.toJson()).toList();
    }
    if (treatments != null) {
      data['treatments'] = treatments?.map((v) => v.toJson()).toList();
    }
    if (experiences != null) {
      data['experiences'] = experiences?.map((v) => v.toJson()).toList();
    }
    if (educations != null) {
      data['educations'] = educations?.map((v) => v.toJson()).toList();
    }
    if (publications != null) {
      data['publications'] = publications?.map((v) => v.toJson()).toList();
    }
    if (memberships != null) {
      data['memberships'] = memberships?.map((v) => v.toJson()).toList();
    }
    if (trainings != null) {
      data['trainings'] = trainings?.map((v) => v.toJson()).toList();
    }
    if (awards != null) {
      data['awards'] = awards?.map((v) => v.toJson()).toList();
    }
    data['identity'] = identity;
    data['location'] = location;
    data['email'] = email;
    data['email_personal'] = emailPersonal;
    data['phone'] = phone;
    data['slug'] = slug;
    data['image_1'] = image1;
    data['image_2'] = image2;
    data['image_3'] = image3;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['foreign'] = foreign;
    data['is_completed'] = isCompleted;
    data['notes'] = notes;
    return data;
  }

  @override
  DoctorCvResponse fromJson(Map<String, dynamic> json) {
    return DoctorCvResponse.fromJson(json);
  }
}

class Awards {
  String? text;
  Awards({this.text});
  Awards.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Trainings {
  String? text;
  Trainings({this.text});
  Trainings.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Memberships {
  String? text;
  Memberships({this.text});
  Memberships.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Publications {
  String? text;
  Publications({this.text});
  Publications.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Educations {
  String? text;
  Educations({this.text});
  Educations.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Experiences {
  String? text;
  Experiences({this.text});
  Experiences.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Treatments {
  String? text;
  Treatments({this.text});
  Treatments.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}

class Specialties {
  String? text;
  Specialties({this.text});
  Specialties.fromJson(Map<String, dynamic> json) {
    text = json['text'] as String?;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    return data;
  }
}
