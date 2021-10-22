class DoctorCvResponse {
  int id;
  String title;
  String firstName;
  String lastName;
  String birthplace;
  String birthdate;
  List<Specialties> specialties;
  List<Treatments> treatments;
  List<Experiences> experiences;
  List<Educations> educations;
  List<Publications> publications;
  List<Memberships> memberships;
  List<Trainings> trainings;
  List<Awards> awards;
  String identity;
  String location;
  String email;
  String emailPersonal;
  String phone;
  String slug;
  String image1;
  String image2;
  String image3;
  String createdAt;
  String updatedAt;
  String deletedAt;
  String foreign;
  int isCompleted;
  String notes;

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
    id = json['id'];
    title = json['title'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    birthplace = json['birthplace'];
    birthdate = json['birthdate'];
    if (json['specialties'] != null) {
      specialties = new List<Specialties>();
      json['specialties'].forEach((v) {
        specialties.add(new Specialties.fromJson(v));
      });
    }
    if (json['treatments'] != null) {
      treatments = new List<Treatments>();
      json['treatments'].forEach((v) {
        treatments.add(new Treatments.fromJson(v));
      });
    }
    if (json['experiences'] != null) {
      experiences = new List<Experiences>();
      json['experiences'].forEach((v) {
        experiences.add(new Experiences.fromJson(v));
      });
    }
    if (json['educations'] != null) {
      educations = new List<Educations>();
      json['educations'].forEach((v) {
        educations.add(new Educations.fromJson(v));
      });
    }
    if (json['publications'] != null) {
      publications = new List<Publications>();
      json['publications'].forEach((v) {
        publications.add(new Publications.fromJson(v));
      });
    }
    if (json['memberships'] != null) {
      memberships = new List<Memberships>();
      json['memberships'].forEach((v) {
        memberships.add(new Memberships.fromJson(v));
      });
    }
    if (json['trainings'] != null) {
      trainings = new List<Trainings>();
      json['trainings'].forEach((v) {
        trainings.add(new Trainings.fromJson(v));
      });
    }
    if (json['awards'] != null) {
      awards = new List<Awards>();
      json['awards'].forEach((v) {
        awards.add(new Awards.fromJson(v));
      });
    }
    identity = json['identity'];
    location = json['location'];
    email = json['email'];
    emailPersonal = json['email_personal'];
    phone = json['phone'];
    slug = json['slug'];
    image1 = json['image_1'];
    image2 = json['image_2'];
    image3 = json['image_3'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    foreign = json['foreign'];
    isCompleted = json['is_completed'];
    notes = json['notes'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['birthplace'] = this.birthplace;
    data['birthdate'] = this.birthdate;
    if (this.specialties != null) {
      data['specialties'] = this.specialties.map((v) => v.toJson()).toList();
    }
    if (this.treatments != null) {
      data['treatments'] = this.treatments.map((v) => v.toJson()).toList();
    }
    if (this.experiences != null) {
      data['experiences'] = this.experiences.map((v) => v.toJson()).toList();
    }
    if (this.educations != null) {
      data['educations'] = this.educations.map((v) => v.toJson()).toList();
    }
    if (this.publications != null) {
      data['publications'] = this.publications.map((v) => v.toJson()).toList();
    }
    if (this.memberships != null) {
      data['memberships'] = this.memberships.map((v) => v.toJson()).toList();
    }
    if (this.trainings != null) {
      data['trainings'] = this.trainings.map((v) => v.toJson()).toList();
    }
    if (this.awards != null) {
      data['awards'] = this.awards.map((v) => v.toJson()).toList();
    }
    data['identity'] = this.identity;
    data['location'] = this.location;
    data['email'] = this.email;
    data['email_personal'] = this.emailPersonal;
    data['phone'] = this.phone;
    data['slug'] = this.slug;
    data['image_1'] = this.image1;
    data['image_2'] = this.image2;
    data['image_3'] = this.image3;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['foreign'] = this.foreign;
    data['is_completed'] = this.isCompleted;
    data['notes'] = this.notes;
    return data;
  }
}

class Awards {
  String text;
  Awards({this.text});
  Awards.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Trainings {
  String text;
  Trainings({this.text});
  Trainings.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Memberships {
  String text;
  Memberships({this.text});
  Memberships.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Publications {
  String text;
  Publications({this.text});
  Publications.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Educations {
  String text;
  Educations({this.text});
  Educations.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Experiences {
  String text;
  Experiences({this.text});
  Experiences.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Treatments {
  String text;
  Treatments({this.text});
  Treatments.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}

class Specialties {
  String text;
  Specialties({this.text});
  Specialties.fromJson(Map<String, dynamic> json) {
    text = json['text'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    return data;
  }
}
