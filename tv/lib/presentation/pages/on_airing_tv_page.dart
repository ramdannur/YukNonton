import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/tv_on_airing_bloc.dart';
import 'package:tv/presentation/widgets/tv_card_list.dart';

class OnAiringTvPage extends StatefulWidget {
  const OnAiringTvPage({super.key});

  @override
  State<OnAiringTvPage> createState() => _OnAiringTvPageState();
}

class _OnAiringTvPageState extends State<OnAiringTvPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On Airing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvOnAiringBloc, TvOnAiringState>(
          builder: (context, state) {
            if (state is OnAiringTvLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnAiringTvHasData) {
              final result = state.result;

              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = result[index];
                  return TvCard(tv);
                },
                itemCount: result.length,
              );
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
  void initState() {
    super.initState();
    Future.microtask(() => context.read<TvOnAiringBloc>().add(const OnFetchOnAiringTv()));
  }
}
