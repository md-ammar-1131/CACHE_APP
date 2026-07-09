// enum MappingType { directMapped, setAssociative, fullyAssociative }
// enum ReplacementPolicy { lru, fifo, random }
// enum WritePolicy { writeBack, writeThrough }
// enum CacheAction { read, write }
// --- ENUMS ---
enum MappingType { DirectMapped, FullyAssociative, SetAssociative }
enum ReplacementPolicy { lru, fifo, random }
enum WritePolicy { writeBack, writeThrough }
enum CacheAction { read, write }