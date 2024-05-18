import 'package:core/common/constants.dart';
import 'package:core/common/data/datasources/remote/ssl_pinning_helper.dart';
import 'package:core/common/presentation/pages/route_name.dart';
import 'package:core/common/presentation/widgets/empty_page.dart';
import 'package:core/common/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/movie_now_playing_bloc.dart';
import 'package:movie/presentation/bloc/movie_popular_bloc.dart';
import 'package:movie/presentation/bloc/movie_search_bloc.dart';
import 'package:movie/presentation/bloc/movie_top_rated_bloc.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/search_movie_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:tv/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/tv_on_airing_bloc.dart';
import 'package:tv/presentation/bloc/tv_popular_bloc.dart';
import 'package:tv/presentation/bloc/tv_search_bloc.dart';
import 'package:tv/presentation/bloc/tv_top_rated_bloc.dart';
import 'package:tv/presentation/pages/home_tv_page.dart';
import 'package:tv/presentation/pages/on_airing_tv_page.dart';
import 'package:tv/presentation/pages/popular_tv_page.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';
import 'package:tv/presentation/pages/top_rated_tv_page.dart';
import 'package:tv/presentation/pages/tv_detail_page.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_toggle_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:yuknonton/firebase_options.dart';
import 'package:yuknonton/injection.dart' as di;
import 'package:yuknonton/presentation/pages/about_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SslPinningHelper.init();

  di.init();

  await Firebase.initializeApp(
    name: "yuknonton",
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieNowPlayingBloc>(
          create: (_) => di.locator<MovieNowPlayingBloc>(),
        ),
        BlocProvider<MoviePopularBloc>(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider<MovieTopRatedBloc>(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider<MovieDetailBloc>(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider<MovieSearchBloc>(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (_) => di.locator<WatchlistMovieBloc>(),
        ),
        BlocProvider<TvOnAiringBloc>(
          create: (_) => di.locator<TvOnAiringBloc>(),
        ),
        BlocProvider<TvPopularBloc>(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider<TvTopRatedBloc>(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider<TvDetailBloc>(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider<TvSearchBloc>(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (_) => di.locator<WatchlistTvBloc>(),
        ),
        BlocProvider<WatchlistToggleBloc>(
          create: (_) => di.locator<WatchlistToggleBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'YukNonton!',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: const HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case RouteName.movieHomePage:
              return MaterialPageRoute(builder: (_) => const HomeMoviePage());
            case RouteName.tvHomePage:
              return MaterialPageRoute(builder: (_) => const HomeTvPage());
            case RouteName.tvOnAiringPage:
              return MaterialPageRoute(builder: (_) => const OnAiringTvPage());
            case RouteName.moviePopularPage:
              return CupertinoPageRoute(builder: (_) => const PopularMoviesPage());
            case RouteName.tvPopularPage:
              return CupertinoPageRoute(builder: (_) => const PopularTvPage());
            case RouteName.movieTopRatedPage:
              return CupertinoPageRoute(builder: (_) => const TopRatedMoviesPage());
            case RouteName.tvTopRatedPage:
              return CupertinoPageRoute(builder: (_) => const TopRatedTvPage());
            case RouteName.movieDetailPage:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case RouteName.tvDetailPage:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case RouteName.movieSearchPage:
              return CupertinoPageRoute(builder: (_) => const SearchMoviePage());
            case RouteName.tvSearchPage:
              return CupertinoPageRoute(builder: (_) => const SearchTvPage());
            case RouteName.watchlistMoviePage:
              return MaterialPageRoute(builder: (_) => const WatchlistMoviesPage());
            case RouteName.watchlistTvPage:
              return MaterialPageRoute(builder: (_) => const WatchlistTvPage());
            case RouteName.aboutPage:
              return MaterialPageRoute(builder: (_) => const AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: EmptyPage(
                    icon: Icons.rocket,
                    label: 'Page not found :(',
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
