
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
  //-------------------------CACHE SET -------------
  class CacheSet {
    final int ways;
    List<CacheBlock> blocks;
    CacheSet(this.ways) : blocks = List.generate(ways, (_) => CacheBlock());
  }
  //---------------ADRESSES REQD-----------------
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
    //CACHE SPECIFICATIONS
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
        cache = List.generate(numSets, (_) => CacheSet(1));// SAYING SINGLE WAY 
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
      int indexMask = ((1 << indexBits) - 1) << offsetBits;//AS AFTER THE OFFSET BITS COMES THE INDEXBITS
      
      // Extract bits
      int offset = address & offsetMask;
      int index = (address & indexMask) >> offsetBits;//BASICALLY THE SET INDEX
      int tag = address >> (offsetBits + indexBits);
  //FULL ADDRESS VALUES ARE RETURNED BY ADDRINFO
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

//////////////////////////////////////////////////////////////ACCESS THAT BLOCK EITHER READ OR WRITE SAME THING FIRST ACCESS
    //this is fuction called whn you press the read or write in oprations log part of the app 
    bool access(String hexAddress, CacheAction action, String writeData) {
      globalTime++;
      int currentAccessLatency = 0; 
      
      AddressInfo info = decodeAddress(hexAddress);
      CacheSet set = cache[info.index];

      // 1. Lookup (Check for HIT)
      for (var block in set.blocks) {
        if (block.valid && block.tag == info.tag) {
          hits++;
          block.lastAccessTime = globalTime;
          currentAccessLatency += hitLatency; 
          
          if (action == CacheAction.write) {
            block.data = writeData;
            if (writePolicy == WritePolicy.writeBack) {
              block.dirty = true;
            } else {
              // Write-Through: Must write to memory immediately, adding memory latency
              currentAccessLatency += missLatency; /////////WRITEING TIME IS TAKEN AS SAME AS MISS LATENCY 
              _log("Mem Write: Write-Through synced to memory.");
            }
          }
          
          totalCycles += currentAccessLatency;
          _log("HIT: Address $hexAddress (Tag: 0x${info.tagHex}) | Latency: $currentAccessLatency cycles");
          return true;
        }
      }

      // 2. MISS & Replace
      misses++;
      currentAccessLatency += hitLatency + missLatency; // Time to check + Time to fetch

      // --- WRITE-THROUGH NO-WRITE-ALLOCATE LOGIC ---
      // If it's a Write Miss in a Write-Through cache, we write directly to memory 
      // and DO NOT bring the block into the cache.
      if (action == CacheAction.write && writePolicy == WritePolicy.writeThrough) {
        totalCycles += currentAccessLatency;
        _log("MISS: Address $hexAddress | Write-Around (Direct to Mem) | Latency: $currentAccessLatency cycles.");
        return false; // Exit early, do not replace blocks in cache
      }

      // --- WRITE-BACK WRITE-ALLOCATE LOGIC ---
      CacheBlock targetBlock = _findReplacementBlock(set);
      
      // Handle Write-Back Eviction
      if (targetBlock.valid && targetBlock.dirty && writePolicy == WritePolicy.writeBack) {
        currentAccessLatency += missLatency; // Penalty for writing dirty block to memory
        _log("EVICT: Wrote dirty block (Tag: 0x${targetBlock.tag.toRadixString(16).toUpperCase()}) back to Memory.");
      }

      totalCycles += currentAccessLatency;
      _log("MISS: Address $hexAddress | Latency: $currentAccessLatency cycles.");

      // Bring new block into cache
      targetBlock.valid = true;
      targetBlock.tag = info.tag;
      targetBlock.insertionTime = globalTime;// NEW BLOCK INSERTED WILL HAVE ITS INSERTED TIME AS CURENT TIME ONLY 
      targetBlock.lastAccessTime = globalTime;
      targetBlock.dirty = false;
      
      if (action == CacheAction.read) {
        targetBlock.data = "Mem[${info.tagHex}]"; //MEANS THE MEM DATE IS JUST SHOWN ELSE IF NOT READ THEN WE WILL FIRST LET IT COME FROM MEMORY AND THEN MAKE THERE A  DATA AS WEITEDATA
      } else { // Write-Back Write Miss (Write-Allocate)
        targetBlock.data = writeData;
        targetBlock.dirty = true; // Block is immediately modified AS TIHS ADDRESS IS MODIFIED
      }
      
      return false;
    }
//////////////////////////////////////////////////REPLACEMENT BLOCK FINDER//////////////////////////////////////
    CacheBlock _findReplacementBlock(CacheSet set) {
      // Seek empty block first
      for (var block in set.blocks) {
        if (!block.valid) return block;//if till not used
      }
      
      // Apply Random
      if (replacementPolicy == ReplacementPolicy.random) {
        return set.blocks[math.Random().nextInt(set.ways)];
      }
      
      // Apply LRU or FIFO
      CacheBlock target = set.blocks.first;
      for (var block in set.blocks) {
        if (replacementPolicy == ReplacementPolicy.lru && block.lastAccessTime < target.lastAccessTime) {
          target = block;//LEAST RECENTLY USED THAT IS LAST USED WILL BE REMOVED FIRST 
        } else if (replacementPolicy == ReplacementPolicy.fifo && block.insertionTime < target.insertionTime) {
          target = block;//FIFO  MEANS OLDEST ONE WILL BE REMOVED FIRST 
        }
      }
      return target;
    }

    void _log(String message) {
      actionLogs.insert(0, "[T:$globalTime] $message");
      if (actionLogs.length > 50) actionLogs.removeLast();// IF LOG IS FULL REMOVE LOG  
    }
  }