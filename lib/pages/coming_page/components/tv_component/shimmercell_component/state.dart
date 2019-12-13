import 'package:fish_redux/fish_redux.dart';

//会像光栅扫描一样显示的控件
class ShimmerCellState implements Cloneable<ShimmerCellState> {
bool showShimmer;

ShimmerCellState({this.showShimmer=true});

  @override
  ShimmerCellState clone() {
    return ShimmerCellState();
  }
}

ShimmerCellState initState(Map<String, dynamic> args) {
  return ShimmerCellState();
}
