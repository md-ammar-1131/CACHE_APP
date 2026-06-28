// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import '../bloc/cache_bloc.dart';
// import '../models/cache_engine.dart';

// class CalculatorTab extends StatefulWidget {
//   const CalculatorTab({Key? key}) : super(key: key);
//   @override
//   State<CalculatorTab> createState() => _CalculatorTabState();
// }

// class _CalculatorTabState extends State<CalculatorTab> {
//   final TextEditingController _hexController = TextEditingController(text: "1A2B3C");
//   AddressInfo? info;

//   void _calculate(CacheEngine engine) {
//     setState(() {
//       info = engine.decodeAddress(_hexController.text);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<CacheBloc, CacheState>(
//       builder: (context, state) {
//         if (state.engine == null) return const Center(child: CircularProgressIndicator());
        
//         return Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text("Enter 32-bit Memory Address (Hex)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               const SizedBox(height: 10),
//               Row(
//                 children: [
//                   Expanded(
//                     child: TextField(
//                       controller: _hexController,
//                       decoration: const InputDecoration(prefixText: "0x ", border: OutlineInputBorder()),
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   ElevatedButton(
//                     onPressed: () => _calculate(state.engine!),
//                     child: const Padding(padding: EdgeInsets.all(16.0), child: Text("Decode")),
//                   )
//                 ],
//               ),
//               const Divider(height: 40),
//              if (info != null) ...[
//                  // Now using the newly added addrHex and addrBin
//                  _buildResultCard("FULL ADDRESS", info!.addrHex, info!.addrBin, Colors.purple.shade100),
                 
//                  _buildResultCard("TAG", info!.tagHex, info!.tagBin, Colors.red.shade100),
//                  _buildResultCard("INDEX", info!.indexHex, info!.indexBin, Colors.green.shade100),
//                  _buildResultCard("OFFSET", info!.offsetHex, info!.offsetBin, Colors.blue.shade100),
//               ]
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildResultCard(String title, String hexStr, String binStr, Color color) {
//     return Card(
//       color: color,
//       child: ListTile(
//         title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
//         subtitle: Text("Binary: $binStr"),
//         trailing: Text("Hex: 0x$hexStr", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cache_bloc.dart';
import '../models/cache_engine.dart';

class CalculatorTab extends StatefulWidget {
  const CalculatorTab({Key? key}) : super(key: key);
  @override
  State<CalculatorTab> createState() => _CalculatorTabState();
}

class _CalculatorTabState extends State<CalculatorTab> {
  final TextEditingController _hexController = TextEditingController(text: "1A2B3C");
  AddressInfo? info;

  void _calculate(CacheEngine engine) {
    setState(() {
      info = engine.decodeAddress(_hexController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) {
        if (state.engine == null) {
          return const Center(child: CircularProgressIndicator(color: Colors.blueAccent));
        }

        return Container(
          // 1. Beautiful Dark Gradient Background
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1E2C), Color(0xFF12121A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter 32-bit Memory Address (Hex)",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      // 2. Modern Dark Input Field
                      child: TextField(
                        controller: _hexController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 16,
                        ),
                        decoration: InputDecoration(
                          prefixText: "0x ",
                          prefixStyle: const TextStyle(color: Colors.white54, fontSize: 16),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.05),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // 3. Styled Decode Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () => _calculate(state.engine!),
                      child: const Text("Decode", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    )
                  ],
                ),
                const SizedBox(height: 32),
                
                if (info != null) ...[
                  // 4. Accent Colored Result Cards for Dark Theme
                  _buildResultCard("FULL ADDRESS", info!.addrHex, info!.addrBin, Colors.purpleAccent),
                  _buildResultCard("TAG", info!.tagHex, info!.tagBin, Colors.redAccent),
                  _buildResultCard("INDEX", info!.indexHex, info!.indexBin, Colors.greenAccent),
                  _buildResultCard("OFFSET", info!.offsetHex, info!.offsetBin, Colors.blueAccent),
                ]
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultCard(String title, String hexStr, String binStr, Color accentColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF252534), // Dark grey card background
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: accentColor.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: accentColor,
              letterSpacing: 1.2,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              "Bin: $binStr",
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontFamily: 'monospace',
                fontSize: 13,
              ),
            ),
          ),
          trailing: Text(
            "0x$hexStr",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ),
    );
  }
}