// // import 'package:cache_app/bloc/cache_event.dart';
// // import 'package:cache_app/bloc/cache_state.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../bloc/cache_bloc.dart';
// // import '../models/enums.dart';

// // class CacheStatsBoard extends StatelessWidget {
// //   const CacheStatsBoard({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<CacheBloc, CacheState>(
// //       builder: (context, state) {
// //         if (state.engine == null) {
// //           return const Center(child: Text("Initialize the Cache in the Drawer"));
// //         }

// //         final engine = state.engine!;

// //         // Calculate Hit Rate for extra flair
// //         int totalAccesses = engine.hits + engine.misses;
// //         double hitRate = totalAccesses == 0 ? 0 : (engine.hits / totalAccesses) * 100;

// //         return Card(
// //           margin: const EdgeInsets.all(12),
// //           elevation: 4,
// //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
// //           child: Padding(
// //             padding: const EdgeInsets.all(16.0),
// //             child: Wrap(
// //               spacing: 20,
// //               runSpacing: 12,
// //               alignment: WrapAlignment.spaceEvenly,
// //               children: [
// //                 _buildStatItem("Hits", engine.hits.toString(), Colors.white),
// //                 _buildStatItem("Misses", engine.misses.toString(),  Colors.white),
// //                 _buildStatItem("Hit Rate", "${hitRate.toStringAsFixed(1)}%",  Colors.white),

// //                 // --- NEW LATENCY STATS ---
// //                 _buildStatItem("Total Cycles", engine.totalCycles.toString(), Colors.white),
// //                 _buildStatItem("AMAT", "${engine.amat.toStringAsFixed(2)} cyc", Colors.white),
// //               ],
// //             ),
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // Helper widget to make the stats look clean and uniform
// //   Widget _buildStatItem(String label, String value, Color color) {
// //     return Column(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         Text(
// //           label,
// //           style: const TextStyle(
// //             fontSize: 14,
// //             fontWeight: FontWeight.w500,
// //             color: Colors.grey,
// //           ),
// //         ),
// //         const SizedBox(height: 4),
// //         Text(
// //           value,
// //           style: TextStyle(
// //             fontSize: 20,
// //             fontWeight: FontWeight.bold,
// //             color: color,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }

// // class SimulatorTab extends StatelessWidget {
// //   const SimulatorTab({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     // DefaultTabController manages the swipeable tabs for mobile screens
// //     return DefaultTabController(
// //       length: 2,
// //       child: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [Color(0xFF1E1E2C), Color(0xFF12121A)],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: Column(
// //           children: [
// //             const CacheStatsBoard(),
// //             const Divider(),
// //             const TabBar(
// //               indicatorColor: Colors.cyanAccent,
// //               labelColor: Colors.cyanAccent,
// //               unselectedLabelColor: Colors.white54,
// //               tabs: [
// //                 Tab(icon: Icon(Icons.settings_input_component), text: "CONTROLS & LOGS"),
// //                 Tab(icon: Icon(Icons.memory), text: "CACHE SETS"),
// //               ],
// //             ),
// //             Expanded(
// //               child: TabBarView(
// //                 children: [
// //                   // PAGE 1: Input and Logs
// //                   _ControlsAndLogsView(),
// //                   // PAGE 2: Cache Sets Visualizer
// //                   _CacheSetsView(),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ----------------------------------------------------
// // // PAGE 1: Controls and Logs
// // // ----------------------------------------------------
// // class _ControlsAndLogsView extends StatefulWidget {
// //   @override
// //   State<_ControlsAndLogsView> createState() => _ControlsAndLogsViewState();
// // }

// // class _ControlsAndLogsViewState extends State<_ControlsAndLogsView> {
// //   final TextEditingController _addrController = TextEditingController();
// //   final TextEditingController _dataController = TextEditingController();
// //   final ScrollController _logScrollController = ScrollController();

// //   void _triggerAction(BuildContext context, CacheAction action) {
// //     if (_addrController.text.isNotEmpty) {
// //       context.read<CacheBloc>().add(PerformAction(
// //             _addrController.text,
// //             action,
// //             _dataController.text.isEmpty ? "Data" : _dataController.text,
// //           ));

// //       // Optionally hide keyboard after action
// //       FocusScope.of(context).unfocus();
// //     }
// //   }

// //   @override
// //   void dispose() {
// //     _addrController.dispose();
// //     _dataController.dispose();
// //     _logScrollController.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<CacheBloc, CacheState>(
// //       builder: (context, state) {
// //         if (state.engine == null) {
// //           return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
// //         }
// //         final engine = state.engine!;

// //         return Padding(
// //           padding: const EdgeInsets.all(20),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.stretch,
// //             children: [
// //               // Stats
// //               Container(
// //                 padding: const EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   color: Colors.white.withOpacity(0.05),
// //                   borderRadius: BorderRadius.circular(8),
// //                 ),
// //                 child: Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                   children: [
// //                     _buildStat("HITS", engine.hits,  Colors.white),
// //                     _buildStat("MISSES", engine.misses,  Colors.white),
// //                   ],
// //                 ),
// //               ),
// //               const SizedBox(height: 24),

// //               // Inputs
// //               _buildDarkTextField(
// //                 controller: _addrController,
// //                 label: "Address (Hex)",
// //                 icon: Icons.memory,
// //               ),
// //               const SizedBox(height: 16),
// //               _buildDarkTextField(
// //                 controller: _dataController,
// //                 label: "Write Data",
// //                 icon: Icons.edit_document,
// //               ),
// //               const SizedBox(height: 24),

// //               // Action Buttons
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: ElevatedButton.icon(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.cyanAccent.withOpacity(0.2),
// //                         foregroundColor: Colors.cyanAccent,
// //                         padding: const EdgeInsets.symmetric(vertical: 16),
// //                       ),
// //                       onPressed: () => _triggerAction(context, CacheAction.read),
// //                       icon: const Icon(Icons.download),
// //                       label: const Text("READ"),
// //                     ),
// //                   ),
// //                   const SizedBox(width: 12),
// //                   Expanded(
// //                     child: ElevatedButton.icon(
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.orangeAccent.withOpacity(0.2),
// //                         foregroundColor: Colors.orangeAccent,
// //                         padding: const EdgeInsets.symmetric(vertical: 16),
// //                       ),
// //                       onPressed: () => _triggerAction(context, CacheAction.write),
// //                       icon: const Icon(Icons.upload),
// //                       label: const Text("WRITE"),
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               const SizedBox(height: 32),

// //               // Logs
// //               const Text(
// //                 "OPERATION LOGS",
// //                 style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 1),
// //               ),
// //               const SizedBox(height: 8),
// //               Expanded(
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.black26,
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                   child: ListView.builder(
// //                     controller: _logScrollController,
// //                     padding: const EdgeInsets.all(12),
// //                     itemCount: engine.actionLogs.length,
// //                     itemBuilder: (context, i) {
// //                       final log = engine.actionLogs[i];
// //                       final isHit = log.contains("HIT");
// //                       final isMiss = log.contains("MISS");
// //                       return Padding(
// //                         padding: const EdgeInsets.only(bottom: 6.0),
// //                         child: Text(
// //                           log,
// //                           style: TextStyle(
// //                             fontSize: 13,
// //                             fontFamily: 'monospace',
// //                             color: isHit ? Colors.greenAccent : (isMiss ? Colors.redAccent : Colors.white70),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                   ),
// //                 ),
// //               )
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   Widget _buildStat(String label, int value, Color color) {
// //     return Column(
// //       children: [
// //         Text(value.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
// //         Text(label, style: const TextStyle(fontSize: 12, color: Colors.white54)),
// //       ],
// //     );
// //   }

// //   Widget _buildDarkTextField({required TextEditingController controller, required String label, required IconData icon}) {
// //     return TextField(
// //       controller: controller,
// //       style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
// //       decoration: InputDecoration(
// //         labelText: label,
// //         labelStyle: const TextStyle(color: Colors.white54),
// //         prefixIcon: Icon(icon, color: Colors.white54, size: 20),
// //         filled: true,
// //         fillColor: Colors.white.withOpacity(0.05),
// //         enabledBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
// //         ),
// //         focusedBorder: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(8),
// //           borderSide: const BorderSide(color: Colors.cyanAccent),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // ----------------------------------------------------
// // // PAGE 2: Cache Sets Visualizer
// // // ----------------------------------------------------
// // class _CacheSetsView extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<CacheBloc, CacheState>(
// //       builder: (context, state) {
// //         if (state.engine == null) {
// //           return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
// //         }
// //         final engine = state.engine!;

// //         // CHECK WRITE POLICY HERE:
// //         final bool isWriteBack = engine.writePolicy == WritePolicy.writeBack;

// //         return ListView.builder(
// //           padding: const EdgeInsets.all(16),
// //           itemCount: engine.cache.length,
// //           itemBuilder: (context, setIndex) {
// //             return Container(
// //               margin: const EdgeInsets.only(bottom: 16),
// //               padding: const EdgeInsets.all(12),
// //               decoration: BoxDecoration(
// //                 color: Colors.white.withOpacity(0.03),
// //                 borderRadius: BorderRadius.circular(12),
// //                 border: Border.all(color: Colors.white.withOpacity(0.1)),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     "SET 0x${setIndex.toRadixString(16).toUpperCase()}",
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.bold,
// //                       color: Colors.white70,
// //                       letterSpacing: 1.5,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 12),
// //                   Wrap(
// //                     spacing: 12,
// //                     runSpacing: 12,
// //                     children: engine.cache[setIndex].blocks.map((block) {
// //                       // Dynamic Policy Metadata
// //                       String policyMeta = "";
// //                       if (engine.replacementPolicy == ReplacementPolicy.lru) {
// //                         policyMeta = "Access: T=${block.lastAccessTime}";
// //                       } else if (engine.replacementPolicy == ReplacementPolicy.fifo) {
// //                         policyMeta = "Inserted: T=${block.insertionTime}";
// //                       }

// //                       // ONLY show dirty styling if WriteBack policy is active
// //                       final bool isDirtyVisual = isWriteBack && block.dirty;

// //                       return AnimatedContainer(
// //                         duration: const Duration(milliseconds: 300),
// //                         padding: const EdgeInsets.all(12),
// //                         width: 160,
// //                         decoration: BoxDecoration(
// //                           color: block.valid ? const Color(0xFF252534) : Colors.black12,
// //                           border: Border.all(
// //                             color: isDirtyVisual
// //                                 ? Colors.redAccent
// //                                 : (block.valid ? Colors.cyanAccent.withOpacity(0.5) : Colors.white10),
// //                             width: isDirtyVisual ? 2 : 1,
// //                           ),
// //                           borderRadius: BorderRadius.circular(8),
// //                           boxShadow: block.valid
// //                               ? [
// //                                   BoxShadow(
// //                                     color: Colors.cyanAccent.withOpacity(0.1),
// //                                     blurRadius: 8,
// //                                   )
// //                                 ]
// //                               : [],
// //                         ),
// //                         child: Column(
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [
// //                             Row(
// //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                               children: [
// //                                 Text(
// //                                   "V: ${block.valid ? '1' : '0'}",
// //                                   style: TextStyle(
// //                                     color: block.valid ? Colors.greenAccent : Colors.grey,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                                 // ONLY render Dirty bit text if WriteBack policy is active
// //                                 if (isWriteBack)
// //                                   Text(
// //                                     "D: ${block.dirty ? '1' : '0'}",
// //                                     style: TextStyle(
// //                                       color: block.dirty ? Colors.redAccent : Colors.grey,
// //                                       fontWeight: FontWeight.bold,
// //                                     ),
// //                                   ),
// //                               ],
// //                             ),
// //                             const Divider(color: Colors.white24),
// //                             Text(
// //                               "Tag: ${block.tag == -1 ? '-' : '0x' + block.tag.toRadixString(16).toUpperCase()}",
// //                               style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
// //                             ),
// //                             Text(
// //                               "Data: ${block.data}",
// //                               style: const TextStyle(color: Colors.white70, fontSize: 12),
// //                               overflow: TextOverflow.ellipsis,
// //                             ),
// //                             const SizedBox(height: 6),
// //                             if (block.valid && policyMeta.isNotEmpty)
// //                               Container(
// //                                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
// //                                 decoration: BoxDecoration(
// //                                   color: Colors.white10,
// //                                   borderRadius: BorderRadius.circular(4),
// //                                 ),
// //                                 child: Text(
// //                                   policyMeta,
// //                                   style: const TextStyle(color: Colors.amberAccent, fontSize: 10),
// //                                 ),
// //                               )
// //                           ],
// //                         ),
// //                       );
// //                     }).toList(),
// //                   )
// //                 ],
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }
// import 'package:cache_app/bloc/cache_event.dart';
// import 'package:cache_app/bloc/cache_state.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cache_bloc.dart';
// import '../models/enums.dart';

// class CacheStatsBoard extends StatelessWidget {
//   const CacheStatsBoard({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CacheBloc, CacheState>(
//       builder: (context, state) {
//         if (state.engine == null) {
//           return const Center(child: Text("Initialize the Cache in the Drawer"));
//         }

//         final engine = state.engine!;

//         // Calculate Hit Rate for extra flair
//         int totalAccesses = engine.hits + engine.misses;
//         double hitRate = totalAccesses == 0 ? 0 : (engine.hits / totalAccesses) * 100;

//         return Card(
//           margin: const EdgeInsets.all(12),
//           elevation: 4,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Wrap(
//               spacing: 20,
//               runSpacing: 12,
//               alignment: WrapAlignment.spaceEvenly,
//               children: [
//                 _buildStatItem("Hits", engine.hits.toString(), Colors.white),
//                 _buildStatItem("Misses", engine.misses.toString(),  Colors.white),
//                 _buildStatItem("Hit Rate", "${hitRate.toStringAsFixed(1)}%",  Colors.white),

//                 // --- NEW LATENCY STATS ---
//                 _buildStatItem("Total Cycles", engine.totalCycles.toString(), Colors.white),
//                 _buildStatItem("AMAT", "${engine.amat.toStringAsFixed(2)} cyc", Colors.white),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   // Helper widget to make the stats look clean and uniform
//   Widget _buildStatItem(String label, String value, Color color) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.w500,
//             color: Colors.grey,
//           ),
//         ),
//         const SizedBox(height: 4),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class SimulatorTab extends StatelessWidget {
//   const SimulatorTab({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // DefaultTabController manages the swipeable tabs for mobile screens
//     return DefaultTabController(
//       length: 2,
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [Color(0xFF1E1E2C), Color(0xFF12121A)],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: Column(
//           children: [
//             const CacheStatsBoard(),
//             const Divider(),
//             const TabBar(
//               indicatorColor: Colors.cyanAccent,
//               labelColor: Colors.cyanAccent,
//               unselectedLabelColor: Colors.white54,
//               tabs: [
//                 Tab(icon: Icon(Icons.settings_input_component), text: "CONTROLS & LOGS"),
//                 Tab(icon: Icon(Icons.memory), text: "CACHE SETS"),
//               ],
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: [
//                   // PAGE 1: Input and Logs
//                   _ControlsAndLogsView(),
//                   // PAGE 2: Cache Sets Visualizer
//                   _CacheSetsView(),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // ----------------------------------------------------
// // PAGE 1: Controls and Logs
// // ----------------------------------------------------
// class _ControlsAndLogsView extends StatefulWidget {
//   @override
//   State<_ControlsAndLogsView> createState() => _ControlsAndLogsViewState();
// }

// class _ControlsAndLogsViewState extends State<_ControlsAndLogsView> {
//   final TextEditingController _addrController = TextEditingController();
//   final TextEditingController _dataController = TextEditingController();
//   final ScrollController _logScrollController = ScrollController();

//   void _triggerAction(BuildContext context, CacheAction action) {
//     if (_addrController.text.isNotEmpty) {
//       context.read<CacheBloc>().add(PerformAction(
//             _addrController.text,
//             action,
//             _dataController.text.isEmpty ? "Data" : _dataController.text,
//           ));

//       // Optionally hide keyboard after action
//       FocusScope.of(context).unfocus();
//     }
//   }

//   @override
//   void dispose() {
//     _addrController.dispose();
//     _dataController.dispose();
//     _logScrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CacheBloc, CacheState>(
//       builder: (context, state) {
//         if (state.engine == null) {
//           return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
//         }
//         final engine = state.engine!;

//         return Padding(
//           padding: const EdgeInsets.all(20),
//           // FIX: Replaced Column with CustomScrollView to allow keyboard panning
//           child: CustomScrollView(
//             slivers: [
//               SliverToBoxAdapter(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     // Stats
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.05),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildStat("HITS", engine.hits,  Colors.white),
//                           _buildStat("MISSES", engine.misses,  Colors.white),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // Inputs
//                     _buildDarkTextField(
//                       controller: _addrController,
//                       label: "Address (Hex)",
//                       icon: Icons.memory,
//                     ),
//                     const SizedBox(height: 16),
//                     _buildDarkTextField(
//                       controller: _dataController,
//                       label: "Write Data",
//                       icon: Icons.edit_document,
//                     ),
//                     const SizedBox(height: 24),

//                     // Action Buttons
//                     Row(
//                       children: [
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.cyanAccent.withOpacity(0.2),
//                               foregroundColor: Colors.cyanAccent,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             onPressed: () => _triggerAction(context, CacheAction.read),
//                             icon: const Icon(Icons.download),
//                             label: const Text("READ"),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.orangeAccent.withOpacity(0.2),
//                               foregroundColor: Colors.orangeAccent,
//                               padding: const EdgeInsets.symmetric(vertical: 16),
//                             ),
//                             onPressed: () => _triggerAction(context, CacheAction.write),
//                             icon: const Icon(Icons.upload),
//                             label: const Text("WRITE"),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 32),

//                     // Logs Header
//                     const Text(
//                       "OPERATION LOGS",
//                       style: TextStyle(color: Colors.white54, fontWeight: FontWeight.bold, letterSpacing: 1),
//                     ),
//                     const SizedBox(height: 8),
//                   ],
//                 ),
//               ),
//               // FIX: SliverFillRemaining takes up all remaining screen space for the logs
//               SliverFillRemaining(
//                 hasScrollBody: false,
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.black26,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: ListView.builder(
//                     controller: _logScrollController,
//                     padding: const EdgeInsets.all(12),
//                     itemCount: engine.actionLogs.length,
//                     itemBuilder: (context, i) {
//                       final log = engine.actionLogs[i];
//                       final isHit = log.contains("HIT");
//                       final isMiss = log.contains("MISS");
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 6.0),
//                         child: Text(
//                           log,
//                           style: TextStyle(
//                             fontSize: 13,
//                             fontFamily: 'monospace',
//                             color: isHit ? Colors.greenAccent : (isMiss ? Colors.redAccent : Colors.white70),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildStat(String label, int value, Color color) {
//     return Column(
//       children: [
//         Text(value.toString(), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
//         Text(label, style: const TextStyle(fontSize: 12, color: Colors.white54)),
//       ],
//     );
//   }

//   Widget _buildDarkTextField({required TextEditingController controller, required String label, required IconData icon}) {
//     return TextField(
//       controller: controller,
//       style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.white54),
//         prefixIcon: Icon(icon, color: Colors.white54, size: 20),
//         filled: true,
//         fillColor: Colors.white.withOpacity(0.05),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(8),
//           borderSide: const BorderSide(color: Colors.cyanAccent),
//         ),
//       ),
//     );
//   }
// }

// // ----------------------------------------------------
// // PAGE 2: Cache Sets Visualizer
// // ----------------------------------------------------
// class _CacheSetsView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CacheBloc, CacheState>(
//       builder: (context, state) {
//         if (state.engine == null) {
//           return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
//         }
//         final engine = state.engine!;

//         // CHECK WRITE POLICY HERE:
//         final bool isWriteBack = engine.writePolicy == WritePolicy.writeBack;

//         return ListView.builder(
//           padding: const EdgeInsets.all(16),
//           itemCount: engine.cache.length,
//           itemBuilder: (context, setIndex) {
//             return Container(
//               margin: const EdgeInsets.only(bottom: 16),
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.03),
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(color: Colors.white.withOpacity(0.1)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "SET 0x${setIndex.toRadixString(16).toUpperCase()}",
//                     style: const TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white70,
//                       letterSpacing: 1.5,
//                     ),
//                   ),
//                   const SizedBox(height: 12),
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 12,
//                     children: engine.cache[setIndex].blocks.map((block) {
//                       // Dynamic Policy Metadata
//                       String policyMeta = "";
//                       if (engine.replacementPolicy == ReplacementPolicy.lru) {
//                         policyMeta = "Access: T=${block.lastAccessTime}";
//                       } else if (engine.replacementPolicy == ReplacementPolicy.fifo) {
//                         policyMeta = "Inserted: T=${block.insertionTime}";
//                       }

//                       // ONLY show dirty styling if WriteBack policy is active
//                       final bool isDirtyVisual = isWriteBack && block.dirty;

//                       return AnimatedContainer(
//                         duration: const Duration(milliseconds: 300),
//                         padding: const EdgeInsets.all(12),
//                         width: 160,
//                         decoration: BoxDecoration(
//                           color: block.valid ? const Color(0xFF252534) : Colors.black12,
//                           border: Border.all(
//                             color: isDirtyVisual
//                                 ? Colors.redAccent
//                                 : (block.valid ? Colors.cyanAccent.withOpacity(0.5) : Colors.white10),
//                             width: isDirtyVisual ? 2 : 1,
//                           ),
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: block.valid
//                               ? [
//                                   BoxShadow(
//                                     color: Colors.cyanAccent.withOpacity(0.1),
//                                     blurRadius: 8,
//                                   )
//                                 ]
//                               : [],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.stajrt,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "V: ${block.valid ? '1' : '0'}",
//                                   style: TextStyle(
//                                     color: block.valid ? Colors.greenAccent : Colors.grey,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 // ONLY render Dirty bit text if WriteBack policy is active
//                                 if (isWriteBack)
//                                   Text(
//                                     "D: ${block.dirty ? '1' : '0'}",
//                                     style: TextStyle(
//                                       color: block.dirty ? Colors.redAccent : Colors.grey,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                               ],
//                             ),
//                             const Divider(color: Colors.white24),
//                             Text(
//                               "Tag: ${block.tag == -1 ? '-' : '0x' + block.tag.toRadixString(16).toUpperCase()}",
//                               style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
//                             ),
//                             Text(
//                               "Data: ${block.data}",
//                               style: const TextStyle(color: Colors.white70, fontSize: 12),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                             const SizedBox(height: 6),
//                             if (block.valid && policyMeta.isNotEmpty)
//                               Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white10,
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: Text(
//                                   policyMeta,
//                                   style: const TextStyle(color: Colors.amberAccent, fontSize: 10),
//                                 ),
//                               )
//                           ],
//                         ),
//                       );
//                     }).toList(),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
// }




import 'package:cache_app/bloc/cache_event.dart';
import 'package:cache_app/bloc/cache_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cache_bloc.dart';
import '../models/enums.dart';

class CacheStatsBoard extends StatelessWidget {
  const CacheStatsBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) {
        if (state.engine == null) {
          return const Center(
            child: Text("Initialize the Cache in the Drawer"),
          );
        }

        final engine = state.engine!;

        // Calculate Hit Rate for extra flair
        int totalAccesses = engine.hits + engine.misses;
        double hitRate = totalAccesses == 0
            ? 0
            : (engine.hits / totalAccesses) * 100;

        return Card(
          margin: const EdgeInsets.all(12),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 20,
              runSpacing: 12,
              alignment: WrapAlignment.spaceEvenly,
              children: [
                _buildStatItem("Hits", engine.hits.toString(), Colors.white),
                _buildStatItem(
                  "Misses",
                  engine.misses.toString(),
                  Colors.white,
                ),
                _buildStatItem(
                  "Hit Rate",
                  "${hitRate.toStringAsFixed(1)}%",
                  Colors.white,
                ),

                // --- NEW LATENCY STATS ---
                _buildStatItem(
                  "Total Cycles",
                  engine.totalCycles.toString(),
                  Colors.white,
                ),
                _buildStatItem(
                  "AMAT",
                  "${engine.amat.toStringAsFixed(2)} cyc",
                  Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }


  // Helper widget to make the stats look clean and uniform
  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}

class SimulatorTab extends StatelessWidget {
  const SimulatorTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // DefaultTabController manages the swipeable tabs for mobile screens
    return DefaultTabController(
      length: 2,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1E2C), Color(0xFF12121A)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const CacheStatsBoard(),
            const Divider(),
            const TabBar(
              indicatorColor: Colors.cyanAccent,
              labelColor: Colors.cyanAccent,
              unselectedLabelColor: Colors.white54,
              tabs: [
                Tab(
                  icon: Icon(Icons.settings_input_component),
                  text: "CONTROLS & LOGS",
                ),
                Tab(icon: Icon(Icons.memory), text: "CACHE SETS"),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // PAGE 1: Input and Logs
                  _ControlsAndLogsView(),
                  // PAGE 2: Cache Sets Visualizer
                  _CacheSetsView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// PAGE 1: Controls and Logs
// ----------------------------------------------------



class _ControlsAndLogsView extends StatefulWidget {
  @override
  State<_ControlsAndLogsView> createState() => _ControlsAndLogsViewState();
}

class _ControlsAndLogsViewState extends State<_ControlsAndLogsView> {
  final TextEditingController _addrController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();

  void _triggerAction(BuildContext context, CacheAction action) {
    if (_addrController.text.isNotEmpty) {
      context.read<CacheBloc>().add(
        // calling which action to perform 
        PerformAction(
          _addrController.text,
          action,
          _dataController.text.isEmpty ? "Data" : _dataController.text,
        ),
      );

      // Optionally hide keyboard after action
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _addrController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) {
        if (state.engine == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        }
        final engine = state.engine!;

        // FIX: Wrap everything in a SingleChildScrollView so the whole page scrolls
        // when the keyboard appears, preventing layout crashes.
        return SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Stats
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat("HITS", engine.hits, Colors.white),
                    _buildStat("MISSES", engine.misses, Colors.white),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Inputs
              _buildDarkTextField(
                controller: _addrController,
                label: "Address (Hex)",
                icon: Icons.memory,
              ),
              const SizedBox(height: 16),
              _buildDarkTextField(
                controller: _dataController,
                label: "Write Data",
                icon: Icons.edit_document,
              ),
              const SizedBox(height: 24),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent.withOpacity(0.2),
                        foregroundColor: Colors.cyanAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () =>
                          _triggerAction(context, CacheAction.read),
                      icon: const Icon(Icons.download),
                      label: const Text("READ"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orangeAccent.withOpacity(0.2),
                        foregroundColor: Colors.orangeAccent,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: () =>
                          _triggerAction(context, CacheAction.write),
                      icon: const Icon(Icons.upload),
                      label: const Text("WRITE"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Logs Header
              const Text(
                "OPERATION LOGS",
                style: TextStyle(
                  color: Colors.white54,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 8),

              Container(
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListView.builder(
                  shrinkWrap: true, // Let it size itself perfectly
                  physics:
                      const NeverScrollableScrollPhysics(), // Let the parent SingleChildScrollView handle the scrolling
                  padding: const EdgeInsets.all(12),
                  itemCount: engine.actionLogs.length,
                  itemBuilder: (context, i) {
                    final log = engine.actionLogs[i];
                    final isHit = log.contains("HIT");
                    final isMiss = log.contains("MISS");
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Text(
                        log,
                        style: TextStyle(
                          fontSize: 13,
                          fontFamily: 'monospace',
                          color: isHit
                              ? Colors.greenAccent
                              : (isMiss ? Colors.redAccent : Colors.white70),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white54),
        ),
      ],
    );
  }

  Widget _buildDarkTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      scrollPadding: const EdgeInsets.only(bottom: 150),
      style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54, size: 20),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.cyanAccent),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// PAGE 2: Cache Sets Visualizer
// ----------------------------------------------------
class _CacheSetsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) {
        if (state.engine == null) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          );
        }
        final engine = state.engine!;

        // CHECK WRITE POLICY HERE:
        final bool isWriteBack = engine.writePolicy == WritePolicy.writeBack;

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: engine.cache.length,
          itemBuilder: (context, setIndex) {
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "SET 0x${setIndex.toRadixString(16).toUpperCase()}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: engine.cache[setIndex].blocks.map((block) {
                      // Dynamic Policy Metadata
                      String policyMeta = "";
                      if (engine.replacementPolicy == ReplacementPolicy.lru) {
                        policyMeta = "Access: T=${block.lastAccessTime}";
                      } else if (engine.replacementPolicy ==
                          ReplacementPolicy.fifo) {
                        policyMeta = "Inserted: T=${block.insertionTime}";
                      }

                      // ONLY show dirty styling if WriteBack policy is active
                      final bool isDirtyVisual = isWriteBack && block.dirty;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(12),
                        width: 160,
                        decoration: BoxDecoration(
                          color: block.valid
                              ? const Color(0xFF252534)
                              : Colors.black12,
                          border: Border.all(
                            color: isDirtyVisual
                                ? Colors.redAccent
                                : (block.valid
                                      ? Colors.cyanAccent.withOpacity(0.5)
                                      : Colors.white10),
                            width: isDirtyVisual ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: block.valid
                              ? [
                                  BoxShadow(
                                    color: Colors.cyanAccent.withOpacity(0.1),
                                    blurRadius: 8,
                                  ),
                                ]
                              : [],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "V: ${block.valid ? '1' : '0'}",
                                  style: TextStyle(
                                    color: block.valid
                                        ? Colors.greenAccent
                                        : Colors.grey,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                // ONLY render Dirty bit text if WriteBack policy is active
                                if (isWriteBack)
                                  Text(
                                    "D: ${block.dirty ? '1' : '0'}",
                                    style: TextStyle(
                                      color: block.dirty
                                          ? Colors.redAccent
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                              ],
                            ),
                            const Divider(color: Colors.white24),
                            Text(
                              "Tag: ${block.tag == -1 ? '-' : '0x' + block.tag.toRadixString(16).toUpperCase()}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'monospace',
                              ),
                            ),
                            Text(
                              "Data: ${block.data}",
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            if (block.valid && policyMeta.isNotEmpty)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  policyMeta,
                                  style: const TextStyle(
                                    color: Colors.amberAccent,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
