
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cache_engine.dart';

// Import the newly separated event and state files
import 'cache_event.dart';
import 'cache_state.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  CacheBloc() : super(const CacheState()) {
    
    on<InitEngine>((event, emit) {
      final engine = CacheEngine(
        mappingType: event.mapping,
        replacementPolicy: event.replacement,
        writePolicy: event.write,
        cacheSize: event.cacheSize,
        blockSize: event.blockSize,
        ways: event.ways,
      );
      
      emit(CacheState(
        engine: engine, 
        updateTrigger: DateTime.now().millisecondsSinceEpoch
      ));
    });

    on<PerformAction>((event, emit) {
      if (state.engine != null) {
        state.engine!.access(event.hexAddress, event.action, event.data);
        
        emit(CacheState(
          engine: state.engine, 
          updateTrigger: DateTime.now().millisecondsSinceEpoch
        ));
      }
    });
  }
}