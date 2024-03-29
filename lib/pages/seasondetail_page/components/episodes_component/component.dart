import 'package:fish_redux/fish_redux.dart';

import 'effect.dart';
import 'reducer.dart';
import 'state.dart';
import 'view.dart';

class EpisodesComponent extends Component<EpisodesState> {
  EpisodesComponent()
      : super(
            effect: buildEffect(),
            reducer: buildReducer(),
            view: buildView,
            dependencies: Dependencies<EpisodesState>(
                adapter: null,
                slots: <String, Dependent<EpisodesState>>{
                }),);

}
