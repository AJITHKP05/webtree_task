class Course {
  String? courseName;
  bool? isPremium;
  bool? isLive;
  int? percentage;
  int? rating;
  int? totalReview;

  Course(
      {this.courseName,
      this.isPremium,
      this.isLive,
      this.percentage,
      this.rating,
      this.totalReview});

  Course.fromJson(Map<String, dynamic> json) {
    courseName = json['course_name'];
    isPremium = json['is_premium'];
    isLive = json['is_live'];
    percentage = json['percentage'];
    rating = json['rating'];
    totalReview = json['total_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['course_name'] = courseName;
    data['is_premium'] = isPremium;
    data['is_live'] = isLive;
    data['percentage'] = percentage;
    data['rating'] = rating;
    data['total_review'] = totalReview;
    return data;
  }
}
