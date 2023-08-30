import 'package:flutter/material.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_info_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_main_screen_cast_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({Key? key}) : super(key: key);

  @override
  State createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    NotifierProvider.read<MovieDetailsModel>(context)?.setupLocale(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const _TitleWidget()),
      body: const _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    final MovieDetails? movieDetails = model?.movieDetails;
    if (movieDetails == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ColoredBox(
      color: const Color.fromRGBO(24, 23, 27, 1.0),
      child: ListView(
        children: const [
          MovieDetailsMainInfoWidget(),
          SizedBox(height: 30),
          MovieDetailsMainScreenCastWidget(),
        ],
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final MovieDetailsModel? model =
        NotifierProvider.watch<MovieDetailsModel>(context);
    return Text(model?.movieDetails?.title ?? "Loading...");
  }
}
