import 'package:flutter/material.dart';
import 'package:vocab_app/radial_menu/radial_menu_state.dart';

class RadialMenuController extends ChangeNotifier{
  final AnimationController _progress;
  RadialMenuState _state = RadialMenuState.closed;
  String _activationId;
  Set<Function(String menuItemId)> _onSelectedListeners;


  RadialMenuController({
    @required TickerProvider vsync,
  }) : _progress = AnimationController(vsync: vsync),
        _onSelectedListeners = Set(){
    _progress
      ..addListener(_onProgressUpdate)
      ..addStatusListener((AnimationStatus status){
        if (status == AnimationStatus.completed){
          _onTransitionCompleted();
        }
      });
  }


  @override
  void dispose() {
    _onSelectedListeners.clear();
    super.dispose();
  }

  void addSelectionListener(Function(String menuItemId) onSelected){
    if (null != onSelected) {
      _onSelectedListeners.add(onSelected);
    }
  }

  void removeSelectionListener(Function(String menuItemId) onSelected){
    _onSelectedListeners.remove(onSelected);
  }

  void _notifySelectionListeners(){
    _onSelectedListeners.forEach((listener){
      listener(_activationId);
    });
  }

  void _onProgressUpdate() {
    notifyListeners();
  }

  void _onTransitionCompleted(){
    switch(_state){
      case RadialMenuState.closing:
        _state = RadialMenuState.closed;
        break;
      case RadialMenuState.opening:
        _state = RadialMenuState.open;
        break;
      case RadialMenuState.expanding:
        _state = RadialMenuState.expanded;
        break;
      case RadialMenuState.collapsing:
        _state = RadialMenuState.open;
        break;
      case RadialMenuState.activating:
        _state = RadialMenuState.dissipating;
        _progress.duration = Duration(milliseconds: 500);
        _progress.forward(from: 0.0);
        break;
      case RadialMenuState.dissipating:
        _notifySelectionListeners();
        _state = RadialMenuState.open;
        _activationId = null;
        break;
      case RadialMenuState.closed:
      case RadialMenuState.open:
      case RadialMenuState.expanded:
        throw Exception('invalid state during a transition: $_state');
        break;
    }
    notifyListeners();
  }

  RadialMenuState get state => _state;

  double get progress => _progress.value;

  String get activationId => _activationId;


  void open() {
    if(state == RadialMenuState.closed){
      _state = RadialMenuState.opening;
      _progress.duration = Duration(milliseconds: 500);
      _progress.forward(from: 0.0);
      notifyListeners();
    }
  }

  void closed(){
    if(state == RadialMenuState.open){
      _state = RadialMenuState.closing;
      _progress.duration = Duration(milliseconds: 250);
      _progress.forward(from: 0.0);
      notifyListeners();
    }

  }

  void expand() {
    if(state == RadialMenuState.open){
      _state = RadialMenuState.expanding;
      _progress.duration = Duration(milliseconds: 500);
      _progress.forward(from: 0.0);
      notifyListeners();
    }

  }


  void collapse() {
    print(state);
    if(state == RadialMenuState.expanded){
      _state = RadialMenuState.collapsing;
      _progress.duration = Duration(milliseconds: 150);
      _progress.forward(from: 0.0);
      notifyListeners();
    }

  }

  void activate(String menuItemId){
    if(state == RadialMenuState.expanded){
      _activationId = menuItemId;
      _state = RadialMenuState.activating;
      _progress.duration = Duration(milliseconds: 500);
      _progress.forward(from: 0.0);
      notifyListeners();
    }

  }
}