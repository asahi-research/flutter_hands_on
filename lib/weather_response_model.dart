class Weather {
  final String publicTime;
  final String publicTimeFormatted;
  final String publishingOffice;
  final String title;
  final String link;
  final Map<String, String> description;
  final List<dynamic> forecasts;
  final Map<String, String> location;
  final Map<String, dynamic> copyright;

  Weather({
    required this.publicTime,
    required this.publicTimeFormatted,
    required this.publishingOffice,
    required this.title,
    required this.link,
    required this.description,
    required this.forecasts,
    required this.location,
    required this.copyright,
  });

  factory Weather.fromJson(json) {
    var _originalResponse = {};

    _originalResponse['description'] =
        Map<String, String>.from(json['description']);
    _originalResponse['forecasts'] = json['forecasts'];
    _originalResponse['location'] = Map<String, String>.from(json['location']);
    _originalResponse['copyright'] = json['copyright'];
    return Weather(
      publicTime: json['publicTime'],
      publicTimeFormatted: json['publicTimeFormatted'],
      publishingOffice: json['publishingOffice'],
      title: json['title'],
      link: json['link'],
      description: _originalResponse['description'],
      forecasts: _originalResponse['forecasts'],
      location: _originalResponse['location'],
      copyright: _originalResponse['copyright'],
    );
  }
}
