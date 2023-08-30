class MovieDetailsCredits {
  final List<Actor> cast;
  final List<Employee> crew;

  MovieDetailsCredits({
    required this.cast,
    required this.crew,
  });

  factory MovieDetailsCredits.fromJson(Map<String, dynamic> json) {
    return MovieDetailsCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((castJson) => Actor.fromJson(castJson))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((crewJson) => Employee.fromJson(crewJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "cast": cast.map((actor) => actor.toJson()).toList(),
      "crew": crew.map((employee) => employee.toJson()).toList(),
    };
  }
}

class Actor {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int castId;
  final String character;
  final String creditId;
  final int order;

  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Actor.fromJson(Map<String, dynamic> json) {
    return Actor(
      adult: json["adult"],
      id: json["id"],
      gender: json["gender"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
      castId: json["cast_id"],
      character: json["character"],
      creditId: json["credit_id"],
      order: json["order"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "gender": gender,
      "id": id,
      "known_for_department": knownForDepartment,
      "name": name,
      "original_name": originalName,
      "popularity": popularity,
      "profile_path": profilePath,
      "cast_id": castId,
      "character": character,
      "credit_id": creditId,
      "order": order,
    };
  }
}

class Employee {
  final bool adult;
  final int gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;

  Employee({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      adult: json["adult"],
      id: json["id"],
      gender: json["gender"],
      knownForDepartment: json["known_for_department"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: json["popularity"],
      profilePath: json["profile_path"],
      department: json["department"],
      job: json["job"],
      creditId: json["credit_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "adult": adult,
      "gender": gender,
      "id": id,
      "known_for_department": knownForDepartment,
      "name": name,
      "original_name": originalName,
      "popularity": popularity,
      "profile_path": profilePath,
      "department": department,
      "job": job,
      "credit_id": creditId,
    };
  }
}
