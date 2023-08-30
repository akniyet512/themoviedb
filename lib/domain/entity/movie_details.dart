import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/domain/entity/movie_details_videos.dart';

class MovieDetails {
  final String? backdropPath;
  final String? homepage;
  final String? overview;
  final String? imdbId;
  final String? posterPath;
  final int? runtime;
  final BelongsToCollection? belongsToCollection;
  final DateTime? releaseDate;
  final String? tagline;
  final bool? adult;
  final int budget;
  final List<Genre> genres;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final int revenue;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final MovieDetailsCredits credits;
  final MovieDetailsVideos videos;

  MovieDetails({
    this.backdropPath,
    this.belongsToCollection,
    this.homepage,
    this.imdbId,
    this.overview,
    this.posterPath,
    this.runtime,
    this.tagline,
    this.releaseDate,
    required this.adult,
    required this.budget,
    required this.genres,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.productionCompanies,
    required this.productionCountries,
    required this.revenue,
    required this.spokenLanguages,
    required this.status,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required this.credits,
    required this.videos,
  });
  factory MovieDetails.fromJson(Map<String, dynamic> json) {
    return MovieDetails(
      backdropPath: json["backdrop_path"],
      belongsToCollection: json["belongs_to_collection"] != null
          ? BelongsToCollection.fromJson(json["belongs_to_collection"])
          : null,
      homepage: json["homepage"],
      imdbId: json["imdb_id"],
      overview: json["overview"],
      posterPath: json["poster_path"],
      runtime: json["runtime"],
      tagline: json["tagline"],
      adult: json["adult"],
      budget: json["budget"],
      genres: (json["genres"] as List<dynamic>)
          .map((genreJson) => Genre.fromJson(genreJson))
          .toList(),
      id: json["id"],
      originalLanguage: json["original_language"],
      originalTitle: json["original_title"],
      popularity: json["popularity"],
      productionCompanies: (json["production_companies"] as List<dynamic>)
          .map((companyJson) => ProductionCompany.fromJson(companyJson))
          .toList(),
      productionCountries: (json["production_countries"] as List<dynamic>)
          .map((countryJson) => ProductionCountry.fromJson(countryJson))
          .toList(),
      releaseDate: Movie.releaseDateFromString(json["release_date"]),
      revenue: json["revenue"],
      spokenLanguages: (json["spoken_languages"] as List<dynamic>)
          .map((languageJson) => SpokenLanguage.fromJson(languageJson))
          .toList(),
      status: json["status"],
      title: json["title"],
      video: json["video"],
      voteAverage: json["vote_average"],
      voteCount: json["vote_count"],
      credits:
          MovieDetailsCredits.fromJson(json["credits"] as Map<String, dynamic>),
      videos:
          MovieDetailsVideos.fromJson(json["videos"] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "backdrop_path": backdropPath,
      "belongs_to_collection": belongsToCollection?.toJson(),
      "homepage": homepage,
      "imdb_id": imdbId,
      "overview": overview,
      "poster_path": posterPath,
      "runtime": runtime,
      "tagline": tagline,
      "adult": adult,
      "budget": budget,
      "genres": genres.map((genre) => genre.toJson()).toList(),
      "id": id,
      "original_language": originalLanguage,
      "original_title": originalTitle,
      "popularity": popularity,
      "production_companies":
          productionCompanies.map((company) => company.toJson()).toList(),
      "production_countries":
          productionCountries.map((country) => country.toJson()).toList(),
      "release_date": releaseDate,
      "revenue": revenue,
      "spoken_languages":
          spokenLanguages.map((language) => language.toJson()).toList(),
      "status": status,
      "title": title,
      "video": video,
      "vote_avarage": voteAverage,
      "vote_count": voteCount,
      "credits": credits.toJson(),
    };
  }
}

class BelongsToCollection {
  BelongsToCollection();
  factory BelongsToCollection.fromJson(Map<String, dynamic> json) {
    return BelongsToCollection();
  }
  Map<String, dynamic> toJson() {
    return {};
  }
}

class PosterPath {
  PosterPath();
  factory PosterPath.fromJson(Map<String, dynamic> json) {
    return PosterPath();
  }
  Map<String, dynamic> toJson() {
    return {};
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json["id"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
    };
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String originCountry;
  final String? logoPath;

  ProductionCompany({
    this.logoPath,
    required this.id,
    required this.originCountry,
    required this.name,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json["id"],
      name: json["name"],
      originCountry: json["origin_country"],
      logoPath: json["logo_path"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "origin_country": originCountry,
      "logo_path": logoPath,
    };
  }
}

class ProductionCountry {
  final String iso;
  final String name;

  ProductionCountry({
    required this.iso,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso: json["iso_3166_1"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "iso_3166_1": iso,
      "name": name,
    };
  }
}

class SpokenLanguage {
  final String iso;
  final String name;

  SpokenLanguage({
    required this.iso,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      iso: json["iso_639_1"],
      name: json["name"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "iso_639_1": iso,
      "name": name,
    };
  }
}
