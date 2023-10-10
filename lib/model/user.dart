class User {
  int? id;
  String? fullName;
  String? username;
  String? phone;
  String? password;
  String? companyName;
  String? jobName;
  String? city;
  String? accessToken;

  User(
      {this.id,
      this.fullName,
      this.username,
      this.phone,
      this.password,
      this.companyName,
      this.jobName,
      this.city,
      this.accessToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['full_name'],
      username: json['username'],
      phone: json['phone'],
      companyName: json['company_name'],
      jobName: json['job_name'],
      // city: json['city'], returned int
      accessToken: json['access_token'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    fullName != null ? data['full_name'] = fullName : null;
    username != null ? data['username'] = username : null;
    phone != null ? data['phone'] = phone : null;
    companyName != null ? data['company_name'] = companyName : null;
    jobName != null ? data['job_name'] = jobName : null;
    city != null ? data['city'] = city : null;
    password != null ? data['password'] = password : null;
    return data;
  }
}
