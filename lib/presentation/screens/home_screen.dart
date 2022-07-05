import 'package:bloc_app/constants/enums.dart';
import 'package:bloc_app/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.color}) : super(key: key);

  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: const Text("First Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
                builder: ((context, state) {
              if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Wifi) {
                return Text(
                  'Wi-Fi',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.green,
                      ),
                );
              } else if (state is InternetConnected &&
                  state.connectionType == ConnectionType.Mobile) {
                return Text(
                  'Mobile',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.red,
                      ),
                );
              } else if (state is InternetDisconnected) {
                return Text(
                  'Disconnected',
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                        color: Colors.grey,
                      ),
                );
              }
              return const Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: CircularProgressIndicator(),
              );
            })),
            const Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 1000),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Counter: ${counterState.counterValue.toString()} Internet: Mobile',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'Counter: ${counterState.counterValue.toString()} Internet: Wi-Fi',
                    style: Theme.of(context).textTheme.headline6,
                  );
                }
                return Text(
                  'Counter: ${counterState.counterValue.toString()} Internet: Disconnected',
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
            const SizedBox(
              height: 24,
            ),
            Builder(builder: (context) {
              final counterValue = context.select(
                (CounterCubit cubit) => cubit.state.counterValue,
              );
              return Text(
                'Counter: ${counterValue.toString()}',
                style: Theme.of(context).textTheme.headline6,
              );
            }),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  backgroundColor: widget.color,
                  heroTag: 'btn1',
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  backgroundColor: widget.color,
                  heroTag: 'btn2',
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/second');
              },
              color: widget.color,
              textColor: Colors.white,
              child: const Text('Go to second page'),
            ),
            const SizedBox(
              height: 24,
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/third');
              },
              color: widget.color,
              textColor: Colors.white,
              child: const Text('Go to third page'),
            ),
          ],
        ),
      ),
    );
  }
}
