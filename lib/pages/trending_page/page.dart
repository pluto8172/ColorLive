import 'package:fish_redux/fish_redux.dart';
import 'package:colorlive/customwidgets/custom_stfstate.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class TrendingPage extends Page<TrendingPageState, Map<String, dynamic>> {
  @override
  CustomstfState<TrendingPageState> createState() =>
      CustomstfState<TrendingPageState>();
  TrendingPage()
      : super(
          initState: initState,
          effect: buildEffect(),
          reducer: buildReducer(),
          view: buildView,
          dependencies: Dependencies<TrendingPageState>(
              adapter: null, slots: <String, Dependent<TrendingPageState>>{}),
          middleware: <Middleware<TrendingPageState>>[],
        );
}
