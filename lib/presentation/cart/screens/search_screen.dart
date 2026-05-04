import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fork_up/core/di/di.dart';
import 'package:fork_up/presentation/cart/cubit/search_cubit.dart';
import 'package:fork_up/presentation/cart/widgets/search_view_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SearchCubit>(),
      child: SearchViewWidget(),
    );
  }
}
