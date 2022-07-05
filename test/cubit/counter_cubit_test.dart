import 'package:bloc_app/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit counterCubit = CounterCubit();

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      counterCubit.close();
    });

    test(
        'The initial state for the CounterCubit is CounterState(counterValue: 0, wasIncremented: false)',
        () {
      expect(
        counterCubit.state,
        const CounterState(counterValue: 0, wasIncremented: false),
      );
    });

    blocTest(
      'The cubit should emit a CounterState(conterValue: 1, wasIncremented: true) when cubit.increment() function is called',
      build: () => counterCubit,
      act: (CounterCubit counterCubit) => counterCubit.increment(),
      expect: () => [const CounterState(counterValue: 1, wasIncremented: true)],
    );

    blocTest(
      'The cubit should emit a CounterState(conterValue: -1, wasIncremented: false) when cubit.decrement() function is called',
      build: () => counterCubit,
      act: (CounterCubit cubit) => cubit.decrement(),
      expect: () =>
          [const CounterState(counterValue: -1, wasIncremented: false)],
    );
  });
}
