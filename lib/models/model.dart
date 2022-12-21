class TextModel {
  final int? id;
  final String
      author,
      title,
      description;

  TextModel({
    this.id,
    required this.author,
    required this.title,
    required this.description
  });

  TextModel.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        author = json['author'],
        title = json['title'],
        description = json['description'];

  Map<String, Object?> toMap(){
    return{
      "id" : id,
      "author": author,
      "title" : title,
      "description" : description,
    };

  }

}
