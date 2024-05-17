import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:core/common/constants.dart';
import 'package:core/common/presentation/pages/route_name.dart';
import 'package:core/common/presentation/widgets/custom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/domain/entities/tv.dart';
import 'package:tv/presentation/bloc/tv_on_airing_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({super.key});

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvOnAiringBloc>().add(const OnFetchOnAiringTv());
      context.read<TvPopularBloc>().add(const OnFetchPopularTvs());
      context.read<TvTopRatedBloc>().add(const OnFetchTopRatedTvs());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Image.asset(
            'assets/circle-g.png',
          ),
        ),
        title: const CustomNavigationBar(1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On Airing',
                onTap: () =>
                    Navigator.pushNamed(context, RouteName.TvOnAiringPage),
              ),
              BlocBuilder<TvOnAiringBloc, TvOnAiringState>(
                  builder: (context, state) {
                if (state is OnAiringTvLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is OnAiringTvHasData) {
                  return TvListSlider(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, RouteName.WatchlistTvPage);
                        },
                        icon: Icon(Icons.queue),
                        label: Text("Watchlist")),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, RouteName.TvSearchPage);
                        },
                        icon: Icon(Icons.search),
                        label: Text("Search"))
                  ],
                ),
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, RouteName.TvPopularPage),
              ),
              BlocBuilder<TvPopularBloc, TvPopularState>(
                  builder: (context, state) {
                if (state is PopularTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvsHasData) {
                  return TvList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, RouteName.TvTopRatedPage),
              ),
              BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
                  builder: (context, state) {
                if (state is TopRatedTvsLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvsHasData) {
                  return TvList(state.result);
                } else {
                  return const Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvListSlider extends StatelessWidget {
  final List<Tv> movies;

  const TvListSlider(this.movies, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = movies.map((movie) {
      return Builder(
        builder: (BuildContext context) {
          return Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Row(
                children: [
                  Flexible(
                    flex: 4,
                    child: Container(
                      color: Color.fromARGB(197, 0, 54, 81),
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            movie.name.toString(),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          RatingBarIndicator(
                            rating: (movie.voteAverage ?? 0) / 2,
                            itemCount: 5,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.cyan,
                            ),
                            itemSize: 12,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteName.TvDetailPage,
                                  arguments: movie.id,
                                );
                              },
                              child: Text(
                                "See Details",
                                style: TextStyle(fontSize: 12),
                              ))
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      height: double.maxFinite,
                      imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).toList();

    return Column(
      children: [
        CarouselSlider(
            items: items,
            options: CarouselOptions(
              height: 180,
              aspectRatio: 9 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              enlargeFactor: 0.15,
              // onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
            )),
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> tvs;

  const TvList(this.tvs, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tvs[index];
          return Padding(
            padding: const EdgeInsets.all(8),
            child: InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    RouteName.TvDetailPage,
                    arguments: movie.id,
                  );
                },
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        child: CachedNetworkImage(
                          imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        movie.name.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        movie.firstAirDate != null
                            ? DateTime.parse(movie.firstAirDate!)
                                .year
                                .toString()
                            : "-",
                        style:
                            const TextStyle(fontSize: 11, color: Colors.grey),
                      )
                    ],
                  ),
                )),
          );
        },
        itemCount: tvs.length,
      ),
    );
  }
}
