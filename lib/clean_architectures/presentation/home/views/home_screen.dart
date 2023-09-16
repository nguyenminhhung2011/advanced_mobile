import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/course/course.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/domain/entities/pagination/pagination.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_bloc.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/bloc/home_state.dart';
import 'package:flutter_base_clean_architecture/core/components/utils/state_mixins/did_change_dependencies_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_bloc_pattern/flutter_bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart_ext/rxdart_ext.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with DidChangeDependencies {
  HomeBloc get _bloc => BlocProvider.of<HomeBloc>(context);
  Object? listen;

  @override
  void initState() {
    super.initState();

    // _fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    ///
    super.didChangeDependencies();
    listen ??= _bloc.state$.flatMap(handleState).collect();
    // dom something
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const SizedBox(height: 100),
          StreamBuilder<Pagination<Course?>>(
            stream: _bloc.courses$,
            builder: (context, snapShot) =>
                Text(snapShot.data?.count.toString() ?? '01'),
          ),
          StreamBuilder<bool?>(
            stream: _bloc.loading$,
            builder: (context, snapShot) {
              return ButtonCustom(
                loading: (snapShot.data ?? false),
                onPress: () {
                  _bloc.fetchData();
                },
                child: const Text('clic here'),
              );
            },
          ),
          // Expanded(
          //     child: StreamBuilder<Pagination<Course>?>(
          //   stream: _bloc.courses$,
          //   builder: (context, snapShot) {
          //     return PaginationViewCustom<Course>(
          //       paginationViewType: PaginationViewType.list,
          //       paginationDataCall: (_, __) async {
          //         print(1);
          //         _fetchData();
          //         return snapShot.data!.rows as List<Course>;
          //       },
          //       items: [],
          //       itemBuilder: (_, course, __) => const SizedBox(),
          //     );
          //   },
          // ))
        ],
      ),
    );
  }

  Stream<void> handleState(state) async* {
    if (state is FetchDataCourseFailed) {
      log('[Fetch data course] ${state.message}');
      return;
    }
    if (state is FetchDataCourseSuccess) {
      log('[Fetch data success] ${state.message}');
      return;
    }
  }
}
