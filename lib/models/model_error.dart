class ErrorModel {
  String  error;

  ErrorModel();

  void fromJson(Map<String, dynamic> json){
      this.error = json['erreur'];
  }
}