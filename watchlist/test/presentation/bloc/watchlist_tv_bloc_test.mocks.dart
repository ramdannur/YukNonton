// Mocks generated by Mockito 5.4.2 from annotations
// in watchlist/test/presentation/bloc/watchlist_tv_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:core/common/failure.dart' as _i5;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:watchlist/data/models/watchlist_table.dart' as _i6;
import 'package:watchlist/domain/usecases/get_watchlist.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [GetWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchlist extends _i1.Mock implements _i3.GetWatchlist {
  MockGetWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, List<_i6.WatchlistTable>>> execute(
          String? type) =>
      (super.noSuchMethod(
        Invocation.method(
          #execute,
          [type],
        ),
        returnValue:
            _i4.Future<_i2.Either<_i5.Failure, List<_i6.WatchlistTable>>>.value(
                _FakeEither_0<_i5.Failure, List<_i6.WatchlistTable>>(
          this,
          Invocation.method(
            #execute,
            [type],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, List<_i6.WatchlistTable>>>);
}
