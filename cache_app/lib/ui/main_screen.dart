// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
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
//   // Configuration State
//   MappingType mapping = MappingType.setAssociative;
//   ReplacementPolicy replacement = ReplacementPolicy.lru;
//   WritePolicy write = WritePolicy.writeBack;
//   int ways = 4;

//   @override
//   void initState() {
//     super.initState();
//     _rebuildCache();
//   }

//   void _rebuildCache() {
//     context.read<CacheBloc>().add(InitEngine(mapping, replacement, write, ways));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Advanced Cache Simulator"),
//           bottom: const TabBar(tabs: [
//             Tab(icon: Icon(Icons.calculate), text: "Address Calculator"),
//             Tab(icon: Icon(Icons.memory), text: "Visual Simulator"),
//           ]),
//         ),
//         drawer: _buildConfigDrawer(),
//         body: const TabBarView(
//           children: [
//             CalculatorTab(),
//             SimulatorTab(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildConfigDrawer() {
//     return Drawer(
//       child: ListView(
//         padding: const EdgeInsets.all(16),
//         children: [
//           const DrawerHeader(child: Center(child: Text("Cache Configuration", style: TextStyle(fontSize: 20)))),

//           const Text("Mapping Type", style: TextStyle(fontWeight: FontWeight.bold)),
//           DropdownButton<MappingType>(
//             value: mapping,
//             isExpanded: true,
//             items: MappingType.values.map((m) => DropdownMenuItem(value: m, child: Text(m.name))).toList(),
//             onChanged: (val) { setState(() => mapping = val!); _rebuildCache(); },
//           ),
//           const SizedBox(height: 16),

//           if (mapping == MappingType.setAssociative) ...[
//             const Text("Ways", style: TextStyle(fontWeight: FontWeight.bold)),
//             Slider(
//               value: ways.toDouble(), min: 2, max: 16, divisions: 7, label: "$ways Ways",
//               onChanged: (v) { setState(() => ways = v.toInt()); _rebuildCache(); },
//             ),
//             const SizedBox(height: 16),
//           ],

//           const Text("Replacement Policy", style: TextStyle(fontWeight: FontWeight.bold)),
//           DropdownButton<ReplacementPolicy>(
//             value: replacement, isExpanded: true,
//             items: ReplacementPolicy.values.map((r) => DropdownMenuItem(value: r, child: Text(r.name))).toList(),
//             onChanged: (val) { setState(() => replacement = val!); _rebuildCache(); },
//           ),
//           const SizedBox(height: 16),

//           const Text("Write Policy", style: TextStyle(fontWeight: FontWeight.bold)),
//           DropdownButton<WritePolicy>(
//             value: write, isExpanded: true,
//             items: WritePolicy.values.map((w) => DropdownMenuItem(value: w, child: Text(w.name))).toList(),
//             onChanged: (val) { setState(() => write = val!); _rebuildCache(); },
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cache_bloc.dart'; // Adjust these imports based on your folder structure
import '../models/enums.dart'; // Adjust these imports based on your folder structure
import 'calculator_tab.dart';
import 'simulator_tab.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Configuration State Controllers
  final TextEditingController _cacheSizeCtrl = TextEditingController(
    text: "1024",
  );
  final TextEditingController _blockSizeCtrl = TextEditingController(
    text: "16",
  );

  MappingType mapping = MappingType.setAssociative;
  ReplacementPolicy replacement = ReplacementPolicy.lru;
  WritePolicy write = WritePolicy.writeBack;
  int ways = 4;

  @override
  void initState() {
    super.initState();
    _rebuildCache(); // Initialize cache on startup
  }

  // Parses the text inputs and sends the event to the BLoC
  void _rebuildCache() {
    int cSize = int.tryParse(_cacheSizeCtrl.text) ?? 1024;
    int bSize = int.tryParse(_blockSizeCtrl.text) ?? 16;

    context.read<CacheBloc>().add(
      InitEngine(mapping, replacement, write, cSize, bSize, ways),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Advanced Cache Simulator"),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.calculate), text: "Address Calculator"),
              Tab(icon: Icon(Icons.memory), text: "Visual Simulator"),
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
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const DrawerHeader(
            child: Center(
              child: Text(
                "Cache Configuration",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // --- NEW: Cache & Block Size Inputs ---
          TextField(
            controller: _cacheSizeCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Cache Size (Bytes)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _blockSizeCtrl,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Block Size (Bytes)",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),

          // --------------------------------------
          const Text(
            "Mapping Type",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton<MappingType>(
            value: mapping,
            isExpanded: true,
            items: MappingType.values
                .map((m) => DropdownMenuItem(value: m, child: Text(m.name)))
                .toList(),
            onChanged: (val) => setState(() => mapping = val!),
          ),
          const SizedBox(height: 16),

          if (mapping == MappingType.setAssociative) ...[
            const Text("Ways", style: TextStyle(fontWeight: FontWeight.bold)),
            Slider(
              value: ways.toDouble(),
              min: 2,
              max: 16,
              divisions: 7,
              label: "$ways Ways",
              onChanged: (v) => setState(() => ways = v.toInt()),
            ),
            const SizedBox(height: 16),
          ],

          const Text(
            "Replacement Policy",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton<ReplacementPolicy>(
            value: replacement,
            isExpanded: true,
            items: ReplacementPolicy.values
                .map(
                  (r) => DropdownMenuItem(
                    value: r,
                    child: Text(r.name.toUpperCase()),
                  ),
                )
                .toList(),
            onChanged: (val) => setState(() => replacement = val!),
          ),
          const SizedBox(height: 16),

          const Text(
            "Write Policy",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          DropdownButton<WritePolicy>(
            value: write,
            isExpanded: true,
            items: WritePolicy.values
                .map((w) => DropdownMenuItem(value: w, child: Text(w.name)))
                .toList(),
            onChanged: (val) => setState(() => write = val!),
          ),

          const SizedBox(height: 32),

          // Apply Button to trigger the rebuild
          // Apply Button to trigger the rebuild
          ElevatedButton(
            onPressed: () {
              _rebuildCache(); // 1. Update the math engine
              Navigator.pop(context); // 2. Safely close the drawer!
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              "Apply & Rebuild Cache",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
