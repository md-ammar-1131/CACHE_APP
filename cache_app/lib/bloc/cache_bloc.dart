// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import '../models/cache_engine.dart';
// import '../models/enums.dart';

// // --- EVENTS ---
// abstract class CacheEvent {}

// class InitEngine extends CacheEvent {
//   final MappingType mapping;
//   final ReplacementPolicy replacement;
//   final WritePolicy write;
//   final int ways;
//   InitEngine(this.mapping, this.replacement, this.write, this.ways);
// }

// class PerformAction extends CacheEvent {
//   final String hexAddress;
//   final CacheAction action;
//   final String data;
//   PerformAction(this.hexAddress, this.action, this.data);
// }

// // --- STATES ---
// class CacheState extends Equatable {
//   final CacheEngine? engine;
//   final int updateTrigger; 

//   const CacheState({this.engine, this.updateTrigger = 0});

//   @override
//   List<Object?> get props => [engine, updateTrigger];
// }

// // --- BLOC ---
// class CacheBloc extends Bloc<CacheEvent, CacheState> {
//   CacheBloc() : super(const CacheState()) {
    
//     on<InitEngine>((event, emit) {
//       final engine = CacheEngine(
//         mappingType: event.mapping,
//         replacementPolicy: event.replacement,
//         writePolicy: event.write,
//         cacheSize: 1024, // 1KB total cache
//         blockSize: 16,   // 16 bytes per block
//         ways: event.ways,
//       );
//       emit(CacheState(engine: engine, updateTrigger: DateTime.now().millisecondsSinceEpoch));
//     });

//     on<PerformAction>((event, emit) {
//       if (state.engine != null) {
//         state.engine!.access(event.hexAddress, event.action, event.data);
//         emit(CacheState(engine: state.engine, updateTrigger: DateTime.now().millisecondsSinceEpoch));
//       }
//     });
//   }
// }
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/cache_engine.dart';
import '../models/enums.dart';

// ==========================================
// 1. EVENTS
// ==========================================
abstract class CacheEvent {}

class InitEngine extends CacheEvent {
  final MappingType mapping;
  final ReplacementPolicy replacement;
  final WritePolicy write;
  final int cacheSize;  // Added from UI Drawer
  final int blockSize;  // Added from UI Drawer
  final int ways;

  InitEngine(
    this.mapping, 
    this.replacement, 
    this.write, 
    this.cacheSize, 
    this.blockSize, 
    this.ways
  );
}

class PerformAction extends CacheEvent {
  final String hexAddress;
  final CacheAction action;
  final String data;

  PerformAction(this.hexAddress, this.action, this.data);
}

// ==========================================
// 2. STATE
// ==========================================
class CacheState extends Equatable {
  final CacheEngine? engine;
  final int updateTrigger; 

  const CacheState({this.engine, this.updateTrigger = 0});
  
  @override
  List<Object?> get props => [engine, updateTrigger];
}

// ==========================================
// 3. BLOC
// ==========================================
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