// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';
// // // import '../bloc/cache_bloc.dart';
// // // import '../models/enums.dart';
// // // import 'calculator_tab.dart';
// // // import 'simulator_tab.dart';

// // // class MainScreen extends StatefulWidget {
// // //   const MainScreen({Key? key}) : super(key: key);

// // //   @override
// // //   State<MainScreen> createState() => _MainScreenState();
// // // }

// // // class _MainScreenState extends State<MainScreen> {
// // //   // Configuration State
// // //   MappingType mapping = MappingType.setAssociative;
// // //   ReplacementPolicy replacement = ReplacementPolicy.lru;
// // //   WritePolicy write = WritePolicy.writeBack;
// // //   int ways = 4;

// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _rebuildCache();
// // //   }

// // //   void _rebuildCache() {
// // //     context.read<CacheBloc>().add(InitEngine(mapping, replacement, write, ways));
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return DefaultTabController(
// // //       length: 2,
// // //       child: Scaffold(
// // //         appBar: AppBar(
// // //           title: const Text("Advanced Cache Simulator"),
// // //           bottom: const TabBar(tabs: [
// // //             Tab(icon: Icon(Icons.calculate), text: "Address Calculator"),
// // //             Tab(icon: Icon(Icons.memory), text: "Visual Simulator"),
// // //           ]),
// // //         ),
// // //         drawer: _buildConfigDrawer(),
// // //         body: const TabBarView(
// // //           children: [
// // //             CalculatorTab(),
// // //             SimulatorTab(),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }

// // //   Widget _buildConfigDrawer() {
// // //     return Drawer(
// // //       child: ListView(
// // //         padding: const EdgeInsets.all(16),
// // //         children: [
// // //           const DrawerHeader(child: Center(child: Text("Cache Configuration", style: TextStyle(fontSize: 20)))),

// // //           const Text("Mapping Type", style: TextStyle(fontWeight: FontWeight.bold)),
// // //           DropdownButton<MappingType>(
// // //             value: mapping,
// // //             isExpanded: true,
// // //             items: MappingType.values.map((m) => DropdownMenuItem(value: m, child: Text(m.name))).toList(),
// // //             onChanged: (val) { setState(() => mapping = val!); _rebuildCache(); },
// // //           ),
// // //           const SizedBox(height: 16),

// // //           if (mapping == MappingType.setAssociative) ...[
// // //             const Text("Ways", style: TextStyle(fontWeight: FontWeight.bold)),
// // //             Slider(
// // //               value: ways.toDouble(), min: 2, max: 16, divisions: 7, label: "$ways Ways",
// // //               onChanged: (v) { setState(() => ways = v.toInt()); _rebuildCache(); },
// // //             ),
// // //             const SizedBox(height: 16),
// // //           ],

// // //           const Text("Replacement Policy", style: TextStyle(fontWeight: FontWeight.bold)),
// // //           DropdownButton<ReplacementPolicy>(
// // //             value: replacement, isExpanded: true,
// // //             items: ReplacementPolicy.values.map((r) => DropdownMenuItem(value: r, child: Text(r.name))).toList(),
// // //             onChanged: (val) { setState(() => replacement = val!); _rebuildCache(); },
// // //           ),
// // //           const SizedBox(height: 16),

// // //           const Text("Write Policy", style: TextStyle(fontWeight: FontWeight.bold)),
// // //           DropdownButton<WritePolicy>(
// // //             value: write, isExpanded: true,
// // //             items: WritePolicy.values.map((w) => DropdownMenuItem(value: w, child: Text(w.name))).toList(),
// // //             onChanged: (val) { setState(() => write = val!); _rebuildCache(); },
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
// // import 'package:cache_app/bloc/cache_event.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';
// // import '../bloc/cache_bloc.dart'; // Adjust these imports based on your folder structure
// // import '../models/enums.dart'; // Adjust these imports based on your folder structure
// // import 'calculator_tab.dart';
// // import 'simulator_tab.dart';

// // class MainScreen extends StatefulWidget {
// //   const MainScreen({Key? key}) : super(key: key);

// //   @override
// //   State<MainScreen> createState() => _MainScreenState();
// // }

// // class _MainScreenState extends State<MainScreen> {
// //   // Configuration State Controllers
// //   final TextEditingController _cacheSizeCtrl = TextEditingController(
// //     text: "1024",
// //   );
// //   final TextEditingController _blockSizeCtrl = TextEditingController(
// //     text: "16",
// //   );

// //   MappingType mapping = MappingType.setAssociative;
// //   ReplacementPolicy replacement = ReplacementPolicy.lru;
// //   WritePolicy write = WritePolicy.writeBack;
// //   int ways = 4;

// //   @override
// //   void initState() {
// //     super.initState();
// //     _rebuildCache(); // Initialize cache on startup
// //   }

// //   // Parses the text inputs and sends the event to the BLoC
// //   void _rebuildCache() {
// //     int cSize = int.tryParse(_cacheSizeCtrl.text) ?? 1024;
// //     int bSize = int.tryParse(_blockSizeCtrl.text) ?? 16;

// //     context.read<CacheBloc>().add(
// //       InitEngine(mapping, replacement, write, cSize, bSize, ways),
// //     );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //       length: 2,
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: const Text("Advanced Cache Simulator"),
// //           bottom: const TabBar(
// //             tabs: [
// //               Tab(icon: Icon(Icons.calculate), text: "Address Calculator"),
// //               Tab(icon: Icon(Icons.memory), text: "Visual Simulator"),
// //             ],
// //           ),
// //         ),
// //         drawer: _buildConfigDrawer(context),
// //         body: const TabBarView(children: [CalculatorTab(), SimulatorTab()]),
// //       ),
// //     );
// //   }

// //   Widget _buildConfigDrawer(BuildContext context) {
// //     return Drawer(
// //       child: ListView(
// //         padding: const EdgeInsets.all(16),
// //         children: [
// //           const DrawerHeader(
// //             child: Center(
// //               child: Text(
// //                 "Cache Configuration",
// //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //               ),
// //             ),
// //           ),

// //           // --- NEW: Cache & Block Size Inputs ---
// //           TextField(
// //             controller: _cacheSizeCtrl,
// //             keyboardType: TextInputType.number,
// //             decoration: const InputDecoration(
// //               labelText: "Cache Size (Bytes)",
// //               border: OutlineInputBorder(),
// //             ),
// //           ),
// //           const SizedBox(height: 16),
// //           TextField(
// //             controller: _blockSizeCtrl,
// //             keyboardType: TextInputType.number,
// //             decoration: const InputDecoration(
// //               labelText: "Block Size (Bytes)",
// //               border: OutlineInputBorder(),
// //             ),
// //           ),
// //           const SizedBox(height: 24),

// //           // --------------------------------------
// //           const Text(
// //             "Mapping Type",
// //             style: TextStyle(fontWeight: FontWeight.bold),
// //           ),
// //           DropdownButton<MappingType>(
// //             value: mapping,
// //             isExpanded: true,
// //             items: MappingType.values
// //                 .map((m) => DropdownMenuItem(value: m, child: Text(m.name)))
// //                 .toList(),
// //             onChanged: (val) => setState(() => mapping = val!),
// //           ),
// //           const SizedBox(height: 16),

// //           if (mapping == MappingType.setAssociative) ...[
// //             const Text("Ways", style: TextStyle(fontWeight: FontWeight.bold)),
// //             Slider(
// //               value: ways.toDouble(),
// //               min: 2,
// //               max: 16,
// //               divisions: 7,
// //               label: "$ways Ways",
// //               onChanged: (v) => setState(() => ways = v.toInt()),
// //             ),
// //             const SizedBox(height: 16),
// //           ],

// //           const Text(
// //             "Replacement Policy",
// //             style: TextStyle(fontWeight: FontWeight.bold),
// //           ),
// //           DropdownButton<ReplacementPolicy>(
// //             value: replacement,
// //             isExpanded: true,
// //             items: ReplacementPolicy.values
// //                 .map(
// //                   (r) => DropdownMenuItem(
// //                     value: r,
// //                     child: Text(r.name.toUpperCase()),
// //                   ),
// //                 )
// //                 .toList(),
// //             onChanged: (val) => setState(() => replacement = val!),
// //           ),
// //           const SizedBox(height: 16),

// //           const Text(
// //             "Write Policy",
// //             style: TextStyle(fontWeight: FontWeight.bold),
// //           ),
// //           DropdownButton<WritePolicy>(
// //             value: write,
// //             isExpanded: true,
// //             items: WritePolicy.values
// //                 .map((w) => DropdownMenuItem(value: w, child: Text(w.name)))
// //                 .toList(),
// //             onChanged: (val) => setState(() => write = val!),
// //           ),

// //           const SizedBox(height: 32),

// //           // Apply Button to trigger the rebuild
// //           // Apply Button to trigger the rebuild
// //           ElevatedButton(
// //             onPressed: () {
// //               _rebuildCache(); // 1. Update the math engine
// //               Navigator.pop(context); // 2. Safely close the drawer!
// //             },
// //             style: ElevatedButton.styleFrom(
// //               padding: const EdgeInsets.symmetric(vertical: 16),
// //             ),
// //             child: const Text(
// //               "Apply & Rebuild Cache",
// //               style: TextStyle(fontSize: 16),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cache_event.dart';
// import '../bloc/cache_bloc.dart';
// import '../models/enums.dart';
// import 'calculator_tab.dart';
// import 'simulator_tab.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   // Configuration State Controllers
//   final TextEditingController _cacheSizeCtrl = TextEditingController(text: "1024");
//   final TextEditingController _blockSizeCtrl = TextEditingController(text: "16");

//   // --- NEW: Latency Controllers ---
//   final TextEditingController _hitLatencyCtrl = TextEditingController(text: "1");
//   final TextEditingController _missLatencyCtrl = TextEditingController(text: "100");

//   MappingType mapping = MappingType.SetAssociative;
//   ReplacementPolicy replacement = ReplacementPolicy.lru;
//   WritePolicy write = WritePolicy.writeBack;
//   int ways = 4;

//   @override
//   void initState() {
//     super.initState();
//     _rebuildCache(); // Initialize cache on startup
//   }

//   // Parses the text inputs and sends the event to the BLoC
//   void _rebuildCache() {
//     int cSize = int.tryParse(_cacheSizeCtrl.text) ?? 1024;
//     int bSize = int.tryParse(_blockSizeCtrl.text) ?? 16;

//     // --- NEW: Parse latencies ---
//     int hLatency = int.tryParse(_hitLatencyCtrl.text) ?? 1;
//     int mLatency = int.tryParse(_missLatencyCtrl.text) ?? 100;

//     context.read<CacheBloc>().add(
//       // Ensure this matches the updated InitEngine constructor
//       InitEngine(mapping, replacement, write, cSize, bSize, ways, hLatency, mLatency),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Advanced Cache Simulator",style: TextStyle(fontWeight: FontWeight.bold),),
//           bottom: const TabBar(
//             tabs: [
//               Tab(icon: Icon(Icons.calculate), text: "Address Calculator"),
//               Tab(icon: Icon(Icons.memory), text: "Visual Simulator"),
//             ],
//           ),
//         ),
//         drawer: _buildConfigDrawer(context),
//         body: const TabBarView(children: [CalculatorTab(), SimulatorTab()]),
//       ),
//     );
//   }

//   Widget _buildConfigDrawer(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const DrawerHeader(
//             child: Center(
//               child: Text(
//                 "Cache Configuration",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),

//           // --- Cache & Block Size Inputs ---
//           TextField(
//             controller: _cacheSizeCtrl,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: ("Cache Size (Bytes)"),
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _blockSizeCtrl,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: "Block Size (Bytes)",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 24),

//           // --- NEW: Latency Inputs ---
//           const Text(
//             "Latency Settings",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           TextField(
//             controller: _hitLatencyCtrl,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: "Hit Latency (Cycles)",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 16),
//           TextField(
//             controller: _missLatencyCtrl,
//             keyboardType: TextInputType.number,
//             decoration: const InputDecoration(
//               labelText: "Miss Latency (Cycles)",
//               border: OutlineInputBorder(),
//             ),
//           ),
//           const SizedBox(height: 24),

//           // --- Mapping Type ---
//           const Text(
//             "Mapping Type",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           DropdownButton<MappingType>(
//             value: mapping,
//             isExpanded: true,
//             items: MappingType.values
//                 .map((m) => DropdownMenuItem(value: m, child: Text(m.name)))
//                 .toList(),
//             onChanged: (val) => setState(() => mapping = val!),
//           ),
//           const SizedBox(height: 16),

//           if (mapping == MappingType.SetAssociative) ...[
//             const Text("Ways", style: TextStyle(fontWeight: FontWeight.bold)),
//             Slider(
//               value: ways.toDouble(),
//               min: 2,
//               max: 16,
//               divisions: 7,
//               label: "$ways Ways",
//               onChanged: (v) => setState(() => ways = v.toInt()),
//             ),
//             const SizedBox(height: 16),
//           ],

//           // --- Replacement Policy ---
//           const Text(
//             "Replacement Policy",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           DropdownButton<ReplacementPolicy>(
//             value: replacement,
//             isExpanded: true,
//             items: ReplacementPolicy.values
//                 .map(
//                   (r) => DropdownMenuItem(
//                     value: r,
//                     child: Text(r.name.toUpperCase()),
//                   ),
//                 )
//                 .toList(),
//             onChanged: (val) => setState(() => replacement = val!),
//           ),
//           const SizedBox(height: 16),

//           // --- Write Policy ---
//           const Text(
//             "Write Policy",
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           DropdownButton<WritePolicy>(
//             value: write,
//             isExpanded: true,
//             items: WritePolicy.values
//                 .map((w) => DropdownMenuItem(value: w, child: Text(w.name)))
//                 .toList(),
//             onChanged: (val) => setState(() => write = val!),
//           ),
//           const SizedBox(height: 32),

//           // --- Apply Button ---
//           ElevatedButton(
//             onPressed: () {
//               _rebuildCache(); // 1. Update the math engine
//               Navigator.pop(context); // 2. Safely close the drawer!
//             },
//             style: ElevatedButton.styleFrom(
//               padding: const EdgeInsets.symmetric(vertical: 16),
//             ),
//             child: const Text(
//               "Apply & Rebuild Cache",
//               style: TextStyle(fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // It's good practice to dispose controllers when the widget is destroyed
//     _cacheSizeCtrl.dispose();
//     _blockSizeCtrl.dispose();
//     _hitLatencyCtrl.dispose();
//     _missLatencyCtrl.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cache_event.dart';
import '../bloc/cache_bloc.dart';
import '../models/enums.dart';
import 'calculator_tab.dart';
import 'simulator_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _cacheSizeCtrl = TextEditingController(
    text: "1024",
  );

  final TextEditingController _blockSizeCtrl = TextEditingController(
    text: "16",
  );

  final TextEditingController _hitLatencyCtrl = TextEditingController(
    text: "1",
  );

  final TextEditingController _missLatencyCtrl = TextEditingController(
    text: "100",
  );

  MappingType mapping = MappingType.SetAssociative;
  ReplacementPolicy replacement = ReplacementPolicy.lru;
  WritePolicy write = WritePolicy.writeBack;

  int ways = 4;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _rebuildCache();
    });
  }

  void _rebuildCache() {
    final int? cSize = int.tryParse(_cacheSizeCtrl.text);
    final int? bSize = int.tryParse(_blockSizeCtrl.text);
    final int? hLatency = int.tryParse(_hitLatencyCtrl.text);
    final int? mLatency = int.tryParse(_missLatencyCtrl.text);

    if (cSize == null ||
        bSize == null ||
        hLatency == null ||
        mLatency == null ||
        cSize <= 0 ||
        bSize <= 0 ||
        hLatency < 0 ||
        mLatency < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid configuration values."),
        ),
      );
      return;
    }

    if (cSize % bSize != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Cache size must be divisible by block size."),
        ),
      );
      return;
    }

    final int totalBlocks = cSize ~/ bSize;

    if (mapping == MappingType.SetAssociative && totalBlocks % ways != 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Number of cache blocks must be divisible by number of ways.",
          ),
        ),
      );
      return;
    }

    context.read<CacheBloc>().add(
      InitEngine(
        mapping,
        replacement,
        write,
        cSize,
        bSize,
        ways,
        hLatency,
        mLatency,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Cache Simulator",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            indicatorWeight: 3,
            tabs: [
              Tab(icon: Icon(Icons.calculate_outlined), text: "Calculator"),
              Tab(icon: Icon(Icons.memory_outlined), text: "Simulator"),
            ],
          ),
        ),
        drawer: _buildConfigDrawer(context),
        body: const TabBarView(children: [CalculatorTab(), SimulatorTab()]),
      ),
    );
  }

  Widget _buildConfigDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF171827), Color(0xFF0F101A)],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            SizedBox(height: 30),
            _sectionTitle("Cache Parameters"),

            _buildTextField(
              controller: _cacheSizeCtrl,
              label: "Cache Size",
              suffix: "Bytes",
              icon: Icons.storage_outlined,
            ),

            const SizedBox(height: 14),

            _buildTextField(
              controller: _blockSizeCtrl,
              label: "Block Size",
              suffix: "Bytes",
              icon: Icons.view_module_outlined,
            ),

            const SizedBox(height: 24),

            _sectionTitle("Latency Settings"),

            _buildTextField(
              controller: _hitLatencyCtrl,
              label: "Hit Latency",
              suffix: "Cycles",
              icon: Icons.flash_on_outlined,
            ),

            const SizedBox(height: 14),

            _buildTextField(
              controller: _missLatencyCtrl,
              label: "Miss Latency",
              suffix: "Cycles",
              icon: Icons.timer_outlined,
            ),

            const SizedBox(height: 24),

            _sectionTitle("Mapping Type"),

            _buildDropdown<MappingType>(
              value: mapping,
              icon: Icons.account_tree_outlined,
              items: MappingType.values,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    mapping = value;
                  });
                }
              },
              textBuilder: (value) => value.name,
            ),

            const SizedBox(height: 20),

            if (mapping == MappingType.SetAssociative) ...[
              _sectionTitle("Associativity"),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.08)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.layers_outlined,
                          size: 20,
                          color: Colors.white70,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          "Ways",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF4F46E5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "$ways-way",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      value: ways.toDouble(),
                      min: 2,
                      max: 16,
                      divisions: 7,
                      label: "$ways Ways",
                      onChanged: (v) => setState(() => ways = v.toInt()),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],

            _sectionTitle("Replacement Policy"),

            _buildDropdown<ReplacementPolicy>(
              value: replacement,
              icon: Icons.swap_vert_rounded,
              items: ReplacementPolicy.values,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    replacement = value;
                  });
                }
              },
              textBuilder: (value) => value.name.toUpperCase(),
            ),

            const SizedBox(height: 20),

            _sectionTitle("Write Policy"),

            _buildDropdown<WritePolicy>(
              value: write,
              icon: Icons.edit_outlined,
              items: WritePolicy.values,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    write = value;
                  });
                }
              },
              textBuilder: (value) => value.name,
            ),

            const SizedBox(height: 30),

            SizedBox(
              height: 54,
              child: ElevatedButton.icon(
                onPressed: () {
                  _rebuildCache();

                  Navigator.pop(context);
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text(
                  "Apply & Rebuild Cache",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F46E5),
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String suffix,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white60),
        suffixText: suffix,
        suffixStyle: const TextStyle(color: Colors.white54, fontSize: 12),
        prefixIcon: Icon(icon, color: Colors.white60),
        filled: true,
        fillColor: Colors.white.withOpacity(0.06),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF6366F1), width: 1.5),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T value,
    required IconData icon,
    required List<T> items,
    required ValueChanged<T?> onChanged,
    required String Function(T) textBuilder,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: DropdownButton<T>(
        value: value,
        isExpanded: true,
        underline: const SizedBox(),
        dropdownColor: const Color(0xFF202132),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Colors.white60,
        ),
        items: items
            .map(
              (item) => DropdownMenuItem<T>(
                value: item,
                child: Row(
                  children: [
                    Icon(icon, size: 19, color: Colors.white60),
                    const SizedBox(width: 10),
                    Text(
                      textBuilder(item),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  void dispose() {
    _cacheSizeCtrl.dispose();
    _blockSizeCtrl.dispose();
    _hitLatencyCtrl.dispose();
    _missLatencyCtrl.dispose();
    super.dispose();
  }
}
