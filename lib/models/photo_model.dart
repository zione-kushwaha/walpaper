class photo_model{
  String url;
  String photgrapher;
  String description;
  photo_model({required this.description, required this.photgrapher, required this.url});

  factory photo_model.fromJson(Map<String, dynamic> json){
    return photo_model(description: json['alt'], photgrapher: json['photographer'], url: json['src']['portrait']);
  }
  
}