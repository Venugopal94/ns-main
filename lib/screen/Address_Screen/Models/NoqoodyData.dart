class NoqoodyData {
  List<UserProjects>? userProjects;
  bool? success;
  String? code;
  String? message;

  NoqoodyData(
      {this.userProjects, this.success, this.code, this.message});

  NoqoodyData.fromJson(Map<String, dynamic> json) {
    if (json['UserProjects'] != null) {
      userProjects = <UserProjects>[];
      json['UserProjects'].forEach((v) {
        userProjects!.add(new UserProjects.fromJson(v));
      });
    }
    success = json['success'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userProjects != null) {
      data['UserProjects'] = this.userProjects!.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}

class UserProjects {
  int? iD;
  String? projectName;
  String? projectDescription;
  String? projectCode;
  String? clientSecret;
  String? accessURL;
  bool? isActive;
  List<ServicesList>? servicesList;

  UserProjects(
      {this.iD,
        this.projectName,
        this.projectDescription,
        this.projectCode,
        this.clientSecret,
        this.accessURL,
        this.isActive,
        this.servicesList});

  UserProjects.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    projectName = json['ProjectName'];
    projectDescription = json['ProjectDescription'];
    projectCode = json['ProjectCode'];
    clientSecret = json['ClientSecret'];
    accessURL = json['AccessURL'];
    isActive = json['IsActive'];
    if (json['ServicesList'] != null) {
      servicesList = <ServicesList>[];
      json['ServicesList'].forEach((v) {
        servicesList!.add(new ServicesList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ProjectName'] = this.projectName;
    data['ProjectDescription'] = this.projectDescription;
    data['ProjectCode'] = this.projectCode;
    data['ClientSecret'] = this.clientSecret;
    data['AccessURL'] = this.accessURL;
    data['IsActive'] = this.isActive;
    if (this.servicesList != null) {
      data['ServicesList'] = this.servicesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServicesList {
  int? iD;
  int? serviceID;
  bool? isActive;
  String? serviceName;
  String? serviceDescription;
  String? redirctUrl;

  ServicesList(
      {this.iD,
        this.serviceID,
        this.isActive,
        this.serviceName,
        this.serviceDescription,
        this.redirctUrl});

  ServicesList.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    serviceID = json['ServiceID'];
    isActive = json['IsActive'];
    serviceName = json['ServiceName'];
    serviceDescription = json['ServiceDescription'];
    redirctUrl = json['RedirctUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['ServiceID'] = this.serviceID;
    data['IsActive'] = this.isActive;
    data['ServiceName'] = this.serviceName;
    data['ServiceDescription'] = this.serviceDescription;
    data['RedirctUrl'] = this.redirctUrl;
    return data;
  }
}