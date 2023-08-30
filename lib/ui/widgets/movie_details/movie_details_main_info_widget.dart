import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_details_credits.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/elements/radial_percent_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.all(20.0),
          child: _MovieNameWidget(),
        ),
        _ScoreWidget(),
        _SummeryWidget(),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'Overview',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: _DescriptionWidget(),
        ),
        SizedBox(height: 30),
        _PeopleWidgets(),
      ],
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  const _PeopleWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    List<Employee>? crew = model?.movieDetails?.credits.crew;

    if (crew == null || crew.isEmpty) {
      return Container();
    }
    if (crew.length > 4) {
      crew = model?.movieDetails?.credits.crew.sublist(0, 4);
    }

    List<List<Employee>?> chunks = [];
    for (int i = 0; i < (crew?.length ?? 0); i += 2) {
      chunks.add(crew?.sublist(i, i + 2 > crew.length ? crew.length : i + 2));
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children:
            chunks.map((chunk) => _PeopleWidgetsRow(employes: chunk)).toList(),
      ),
    );
  }
}

class _PeopleWidgetsRow extends StatelessWidget {
  final List<Employee>? employes;
  const _PeopleWidgetsRow({required this.employes});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: (employes ?? [])
            .map((employee) => _PeopleWidgetsRowItem(employee: employee))
            .toList(),
      ),
    );
  }
}

class _PeopleWidgetsRowItem extends StatelessWidget {
  final Employee employee;
  const _PeopleWidgetsRowItem({required this.employee});

  @override
  Widget build(BuildContext context) {
    const TextStyle nameStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    const TextStyle jobTilteStyle = TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    );
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name,
            style: nameStyle,
          ),
          Text(
            employee.job,
            style: jobTilteStyle,
          ),
        ],
      ),
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(
      model?.movieDetails?.overview ?? "",
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    final String? backdropPath = model?.movieDetails?.backdropPath;
    final String? posterPath = model?.movieDetails?.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if (backdropPath != null)
            Image.network(ApiClient.imageUrl(backdropPath)),
          if (posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: Image.network(ApiClient.imageUrl(posterPath)),
            ),
        ],
      ),
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: model?.movieDetails?.title ?? "",
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: " (${model?.movieDetails?.releaseDate?.year})",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double voteAvarage =
        NotifierProvider.watch<MovieDetailsModel>(context)
                ?.movieDetails
                ?.voteAverage ??
            0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: voteAvarage / 10,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: Text((voteAvarage * 10).toInt().toString()),
                ),
              ),
              const SizedBox(width: 10),
              const Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        TextButton(
          onPressed: () {},
          child: const Row(
            children: [
              Icon(Icons.play_arrow),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
        child: Text(
          '${model?.movieDetails?.releaseDate?.day}/${model?.movieDetails?.releaseDate?.month}/${model?.movieDetails?.releaseDate?.year} (${model?.movieDetails?.productionCompanies.first.originCountry}) ${(model?.movieDetails?.runtime ?? 0) ~/ 60}h ${(model?.movieDetails?.runtime ?? 0) % 60}m ${model?.movieDetails?.genres.map((e) => e.name).join(", ")}',
          maxLines: 3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
