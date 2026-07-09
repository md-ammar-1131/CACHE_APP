import 'package:equatable/equatable.dart';
import '../models/cache_engine.dart';

class CacheState extends Equatable {
  final CacheEngine? engine;
  final int updateTrigger; 

  const CacheState({this.engine, this.updateTrigger = 0});
  
  @override
  List<Object?> get props => [engine, updateTrigger];
}