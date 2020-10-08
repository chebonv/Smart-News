class FeedModel{
  final int feedId;
  final String feedTitle;
  final String feedImage;
  final String feedDescription;

  FeedModel({this.feedId, this.feedTitle, this.feedImage, this.feedDescription});

  factory FeedModel.fromJson(Map<String, dynamic> json) {
    return FeedModel(
      feedId: json['feedId'] as int,
      feedTitle: json['feedTitle'] as String,
      feedImage: json['feedImage'] as String,
      feedDescription: json['feedDescription'] as String,
    );
  }
}