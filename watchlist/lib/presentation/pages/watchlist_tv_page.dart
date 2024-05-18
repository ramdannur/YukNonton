import 'package:core/common/presentation/widgets/empty_page.dart';
import 'package:core/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:watchlist/presentation/widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({super.key});

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
          builder: (context, state) {
            if (state is WatchlistTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvHasData) {
              final result = state.result;

              if (result.isEmpty) {
                return const EmptyPage(
                  label: 'Series is empty',
                );
              } else {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = result[index];
                    return TvCard(tv);
                  },
                  itemCount: result.length,
                );
              }
            } else {
              return const Center(
                key: Key('error_message'),
                child: Text("Failed"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvBloc>().add(const OnFetchWatchlistTv());
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => context.read<WatchlistTvBloc>().add(const OnFetchWatchlistTv()));
  }
}
