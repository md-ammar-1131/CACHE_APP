// import 'dart:math' as math;
// import 'enums.dart';

// class CacheBlock {
//   bool valid = false;
//   bool dirty = false;
//   int tag = -1;
//   int lastAccessTime = 0;
//   int insertionTime = 0;
//   String data = "Empty";
// }

// class CacheSet {
//   final int ways;
//   List<CacheBlock> blocks;
//   CacheSet(this.ways) : blocks = List.generate(ways, (_) => CacheBlock());
// }

// class AddressInfo {
//   final int tag, index, offset;
//   final String addr;
//   final String addrHex, addrBin; // Added fields

//   final String tagHex, indexHex, offsetHex, tagBin, indexBin, offsetBin;

//   AddressInfo({
//     required this.addr,
//     required this.addrHex, // Added parameter
//     required this.addrBin, // Added parameter
//     required this.tag, required this.index, required this.offset,
//     required this.tagHex, required this.indexHex, required this.offsetHex,
//     required this.tagBin, required this.indexBin, required this.offsetBin,
//   });
// }

// class CacheEngine {
//   final MappingType mappingType;
//   final ReplacementPolicy replacementPolicy;
//   final WritePolicy writePolicy;
  
//   final int cacheSize; 
//   final int blockSize; 
//   final int ways; 
//   final int addressBits; 

//   late int numSets;
//   late int offsetBits;
//   late int indexBits;
//   late int tagBits;

//   int globalTime = 0;
//   List<CacheSet> cache = [];
//   List<String> actionLogs = [];
//   int hits = 0;
//   int misses = 0;

//   CacheEngine({
//     required this.mappingType, 
//     required this.replacementPolicy,
//     required this.writePolicy, 
//     required this.cacheSize,
//     required this.blockSize, 
//     this.ways = 1, 
//     this.addressBits = 32,
//   }) {
//     int totalBlocks = cacheSize ~/ blockSize;
    
//     if (mappingType == MappingType.directMapped) {
//       numSets = totalBlocks;
//       cache = List.generate(numSets, (_) => CacheSet(1));
//     } else if (mappingType == MappingType.fullyAssociative) {
//       numSets = 1;
//       cache = [CacheSet(totalBlocks)];
//     } else {
//       numSets = totalBlocks ~/ ways;
//       cache = List.generate(numSets, (_) => CacheSet(ways));
//     }

//     offsetBits = (math.log(blockSize) / math.ln2).round();
//     indexBits = (math.log(numSets) / math.ln2).round();
//     tagBits = addressBits - indexBits - offsetBits;
//   }

//   AddressInfo decodeAddress(String hexAddress) {
//     // Convert hex string to integer
//     int address = int.parse(hexAddress.replaceAll("0x", ""), radix: 16);
    
//     // Create bitmasks
//     int offsetMask = (1 << offsetBits) - 1;
//     int indexMask = ((1 << indexBits) - 1) << offsetBits;
    
//     // Extract bits
//     int offset = address & offsetMask;
//     int index = (address & indexMask) >> offsetBits;
//     int tag = address >> (offsetBits + indexBits);

//     return AddressInfo(
//       addr: address.toString(), // Fixed the syntax here
//       addrHex: address.toRadixString(16).toUpperCase().padLeft(8, '0'), // Assuming 32-bit (8 hex chars)
//       addrBin: address.toRadixString(2).padLeft(addressBits, '0'), // Pads to 32 bits
//       tag: tag, index: index, offset: offset,
//       tagHex: tag.toRadixString(16).toUpperCase(),
//       indexHex: index.toRadixString(16).toUpperCase(),
//       offsetHex: offset.toRadixString(16).toUpperCase(),
//       tagBin: tag.toRadixString(2).padLeft(tagBits, '0'),
//       indexBin: index.toRadixString(2).padLeft(indexBits, '0'),
//       offsetBin: offset.toRadixString(2).padLeft(offsetBits, '0'),
//     );
//   }

//   bool access(String hexAddress, CacheAction action, String writeData) {
//     globalTime++;
//     AddressInfo info = decodeAddress(hexAddress);
//     CacheSet set = cache[info.index];

//     // 1. Lookup (Check for HIT)
//     for (var block in set.blocks) {
//       if (block.valid && block.tag == info.tag) {
//         hits++;
//         block.lastAccessTime = globalTime;
//         if (action == CacheAction.write) {
//           block.data = writeData;
//           if (writePolicy == WritePolicy.writeBack) block.dirty = true;
//         }
//         _log("HIT: Address $hexAddress (Tag: 0x${info.tagHex})");
//         return true;
//       }
//     }

//     // 2. MISS & Replace
//     misses++;
//     _log("MISS: Address $hexAddress.");
//     CacheBlock targetBlock = _findReplacementBlock(set);
    
//     // Handle Write-Back Eviction
//     if (targetBlock.valid && targetBlock.dirty && writePolicy == WritePolicy.writeBack) {
//       _log("EVICT: Wrote dirty block (Tag: 0x${targetBlock.tag.toRadixString(16)}) back to Memory.");
//     }

//     targetBlock.valid = true;
//     targetBlock.tag = info.tag;
//     targetBlock.insertionTime = globalTime;
//     targetBlock.lastAccessTime = globalTime;
//     targetBlock.dirty = false;
    
//     if (action == CacheAction.read) {
//       targetBlock.data = "Mem[${info.tagHex}]"; 
//     } else {
//       targetBlock.data = writeData;
//       if (writePolicy == WritePolicy.writeBack) targetBlock.dirty = true;
//     }
//     return false;
//   }

//   CacheBlock _findReplacementBlock(CacheSet set) {
//     // Seek empty block first
//     for (var block in set.blocks) {
//       if (!block.valid) return block;
//     }
    
//     // Apply Random
//     if (replacementPolicy == ReplacementPolicy.random) {
//       return set.blocks[math.Random().nextInt(set.ways)];
//     }
    
//     // Apply LRU or FIFO
//     CacheBlock target = set.blocks.first;
//     for (var block in set.blocks) {
//       if (replacementPolicy == ReplacementPolicy.lru && block.lastAccessTime < target.lastAccessTime) {
//         target = block;
//       } else if (replacementPolicy == ReplacementPolicy.fifo && block.insertionTime < target.insertionTime) {
//         target = block;
//       }
//     }
//     return target;
//   }

//   void _log(String message) {
//     actionLogs.insert(0, "[T:$globalTime] $message");
//     if (actionLogs.length > 50) actionLogs.removeLast(); 
//   }
// }
import 'dart:math' as math;

import 'package:cache_app/models/enums.dart';



// --- CACHE STRUCTURES ---
class CacheBlock {
  bool valid = false;
  bool dirty = false;
  int tag = -1;
  int lastAccessTime = 0;
  int insertionTime = 0;
  String data = "Empty";
}

class CacheSet {
  final int ways;
  List<CacheBlock> blocks;
  CacheSet(this.ways) : blocks = List.generate(ways, (_) => CacheBlock());
}

class AddressInfo {
  final int tag, index, offset;
  final String addr;
  final String addrHex, addrBin;
  final String tagHex, indexHex, offsetHex, tagBin, indexBin, offsetBin;

  AddressInfo({
    required this.addr,
    required this.addrHex,
    required this.addrBin,
    required this.tag, required this.index, required this.offset,
    required this.tagHex, required this.indexHex, required this.offsetHex,
    required this.tagBin, required this.indexBin, required this.offsetBin,
  });
}

// --- CACHE ENGINE ---
class CacheEngine {
  final MappingType mappingType;
  final ReplacementPolicy replacementPolicy;
  final WritePolicy writePolicy;
  
  final int cacheSize; 
  final int blockSize; 
  final int ways; 
  final int addressBits; 

  // Latency fields
  final int hitLatency;
  final int missLatency;

  late int numSets;
  late int offsetBits;
  late int indexBits;
  late int tagBits;

  int globalTime = 0;
  int totalCycles = 0; // Tracks total time taken by all memory accesses
  List<CacheSet> cache = [];
  List<String> actionLogs = [];
  int hits = 0;
  int misses = 0;

  CacheEngine({
    required this.mappingType, 
    required this.replacementPolicy,
    required this.writePolicy, 
    required this.cacheSize,
    required this.blockSize, 
    this.ways = 1, 
    this.addressBits = 32,
    this.hitLatency = 1,     // Default 1 cycle
    this.missLatency = 100,  // Default 100 cycles
  }) {
    int totalBlocks = cacheSize ~/ blockSize;
    
    if (mappingType == MappingType.DirectMapped) {
      numSets = totalBlocks;
      cache = List.generate(numSets, (_) => CacheSet(1));
    } else if (mappingType == MappingType.FullyAssociative) {
      numSets = 1;
      cache = [CacheSet(totalBlocks)];
    } else {
      numSets = totalBlocks ~/ ways;
      cache = List.generate(numSets, (_) => CacheSet(ways));
    }

    offsetBits = (math.log(blockSize) / math.ln2).round();
    indexBits = (math.log(numSets) / math.ln2).round();
    tagBits = addressBits - indexBits - offsetBits;
  }

  // Calculates Average Memory Access Time (AMAT)
  double get amat {
    int totalAccesses = hits + misses;
    if (totalAccesses == 0) return 0.0;
    
    double missRate = misses / totalAccesses;
    return hitLatency + (missRate * missLatency);
  }

  AddressInfo decodeAddress(String hexAddress) {
    // Convert hex string to integer
    int address = int.parse(hexAddress.replaceAll("0x", ""), radix: 16);
    
    // Create bitmasks
    int offsetMask = (1 << offsetBits) - 1;
    int indexMask = ((1 << indexBits) - 1) << offsetBits;
    
    // Extract bits
    int offset = address & offsetMask;
    int index = (address & indexMask) >> offsetBits;
    int tag = address >> (offsetBits + indexBits);

    return AddressInfo(
      addr: address.toString(),
      addrHex: address.toRadixString(16).toUpperCase().padLeft(8, '0'),
      addrBin: address.toRadixString(2).padLeft(addressBits, '0'),
      tag: tag, index: index, offset: offset,
      tagHex: tag.toRadixString(16).toUpperCase(),
      indexHex: index.toRadixString(16).toUpperCase(),
      offsetHex: offset.toRadixString(16).toUpperCase(),
      tagBin: tag.toRadixString(2).padLeft(tagBits, '0'),
      indexBin: index.toRadixString(2).padLeft(indexBits, '0'),
      offsetBin: offset.toRadixString(2).padLeft(offsetBits, '0'),
    );
  }

  bool access(String hexAddress, CacheAction action, String writeData) {
    globalTime++;
    int currentAccessLatency = 0; // Track latency for this specific access
    
    AddressInfo info = decodeAddress(hexAddress);
    CacheSet set = cache[info.index];

    // 1. Lookup (Check for HIT)
    for (var block in set.blocks) {
      if (block.valid && block.tag == info.tag) {
        hits++;
        block.lastAccessTime = globalTime;
        
        if (action == CacheAction.write) {
          block.data = writeData;
          if (writePolicy == WritePolicy.writeBack) block.dirty = true;
        }
        
        currentAccessLatency += hitLatency; 
        totalCycles += currentAccessLatency;
        
        _log("HIT: Address $hexAddress (Tag: 0x${info.tagHex}) | Latency: $currentAccessLatency cycles");
        return true;
      }
    }

    // 2. MISS & Replace
    misses++;
    
    // It takes 'hitLatency' to realize it's a miss, plus 'missLatency' to fetch from memory
    currentAccessLatency += hitLatency + missLatency; 

    CacheBlock targetBlock = _findReplacementBlock(set);
    
    // Handle Write-Back Eviction
    if (targetBlock.valid && targetBlock.dirty && writePolicy == WritePolicy.writeBack) {
      // We must write the dirty block to memory, costing another missLatency
      currentAccessLatency += missLatency; 
      _log("EVICT: Wrote dirty block (Tag: 0x${targetBlock.tag.toRadixString(16).toUpperCase()}) back to Memory. (+Write-back penalty)");
    }

    totalCycles += currentAccessLatency;
    _log("MISS: Address $hexAddress | Latency: $currentAccessLatency cycles.");

    targetBlock.valid = true;
    targetBlock.tag = info.tag;
    targetBlock.insertionTime = globalTime;
    targetBlock.lastAccessTime = globalTime;
    targetBlock.dirty = false;
    
    if (action == CacheAction.read) {
      targetBlock.data = "Mem[${info.tagHex}]"; 
    } else {
      targetBlock.data = writeData;
      if (writePolicy == WritePolicy.writeBack) targetBlock.dirty = true;
    }
    
    return false;
  }

  CacheBlock _findReplacementBlock(CacheSet set) {
    // Seek empty block first
    for (var block in set.blocks) {
      if (!block.valid) return block;
    }
    
    // Apply Random
    if (replacementPolicy == ReplacementPolicy.random) {
      return set.blocks[math.Random().nextInt(set.ways)];
    }
    
    // Apply LRU or FIFO
    CacheBlock target = set.blocks.first;
    for (var block in set.blocks) {
      if (replacementPolicy == ReplacementPolicy.lru && block.lastAccessTime < target.lastAccessTime) {
        target = block;
      } else if (replacementPolicy == ReplacementPolicy.fifo && block.insertionTime < target.insertionTime) {
        target = block;
      }
    }
    return target;
  }

  void _log(String message) {
    actionLogs.insert(0, "[T:$globalTime] $message");
    if (actionLogs.length > 50) actionLogs.removeLast(); 
  }
}