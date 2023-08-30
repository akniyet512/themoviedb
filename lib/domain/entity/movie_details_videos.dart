class MovieDetailsVideos {
  final List<MovieDetailsVideosResult> results;

  MovieDetailsVideos({
    required this.results,
  });

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) {
    return MovieDetailsVideos(
      results: (json['results'] as List<dynamic>)
          .map((result) => MovieDetailsVideosResult.fromJson(result))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results.map((result) => result.toJson()).toList(),
    };
  }
}

class MovieDetailsVideosResult {
  final String id;
  final String isoLower;
  final String isoUpper;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;

  MovieDetailsVideosResult({
    required this.id,
    required this.isoLower,
    required this.isoUpper,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory MovieDetailsVideosResult.fromJson(Map<String, dynamic> json) {
    return MovieDetailsVideosResult(
      id: json['id'],
      isoLower: json['iso_639_1'],
      isoUpper: json['iso_3166_1'],
      key: json['key'],
      name: json['name'],
      site: json['site'],
      size: json['size'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'iso_639_1': isoLower,
      'iso_3166_1': isoUpper,
      'key': key,
      'name': name,
      'site': site,
      'size': size,
      'type': type,
    };
  }
}
