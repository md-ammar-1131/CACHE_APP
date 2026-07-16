// import '../models/enums.dart';

// abstract class CacheEvent {}

// class InitEngine extends CacheEvent {
//   final MappingType mapping;
//   final ReplacementPolicy replacement;
//   final WritePolicy write;
//   final int cacheSize;  
//   final int blockSize;  
//   final int ways;

//   InitEngine(
//     this.mapping, 
//     this.replacement, 
//     this.write, 
//     this.cacheSize, 
//     this.blockSize, 
//     this.ways
//   );
// }

// class PerformAction extends CacheEvent {
//   final String hexAddress;
//   final CacheAction action;
//   final String data;

//   PerformAction(this.hexAddress, this.action, this.data);
// }
import '../models/enums.dart';

abstract class CacheEvent {}

class InitEngine extends CacheEvent {
  final MappingType mapping;
  final ReplacementPolicy replacement;
  final WritePolicy write;
  final int cacheSize;
  final int blockSize;
  final int ways;
  
  // --- LATENCY PARAMETERS ---
  final int hitLatency;
  final int missLatency;

  InitEngine(
    this.mapping, 
    this.replacement, 
    this.write, 
    this.cacheSize, 
    this.blockSize, 
    this.ways,
    this.hitLatency,
    this.missLatency,  
  );
}

class PerformAction extends CacheEvent {
  final String hexAddress;
  final CacheAction action;
  final String data;

  PerformAction(this.hexAddress, this.action, this.data);
}