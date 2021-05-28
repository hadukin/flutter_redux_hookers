import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart' show HookWidget;
import 'package:flutter_redux_hookers/flutter_redux_hookers.dart';

import 'package:redux/redux.dart';

enum Actions { Increment }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }

  return state;
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);

  runApp(
    StoreProvider<int>(
      store: store,
      child: FlutterReduxApp(),
    ),
  );
}

class FlutterReduxApp extends HookWidget {
  const FlutterReduxApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dispatch = useDispatch<int>();
    final count = useSelector<int, String>((state) => state.toString());

    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('useSelector: $count'),
              StoreConnector<int, int>(
                converter: (store) => store.state,
                builder: (context, vm) {
                  return Text('StoreConnector: $vm');
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => dispatch(Actions.Increment),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
