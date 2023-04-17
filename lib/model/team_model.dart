class TeamModel {
  TeamModel(
     this.about,
     this.terms,
 );
  late String about;
  late String terms;

  TeamModel.fromJson(Map<String, dynamic>? json) {
    about = json!['about'];
    terms = json!['terms'];
  }
  Map<String, dynamic> toMap() {
    return {
      'about': about,
      'terms': terms,
    };
  }
}
