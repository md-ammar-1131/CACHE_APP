// import 'package:cache_app/bloc/cache_state.dart';
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
//   final TextEditingController _hexController = TextEditingController(
//     text: "1A2B3C",
//   );
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
//         if (state.engine == null) {
//           return const Center(
//             child: CircularProgressIndicator(color: Colors.blueAccent),
//           );
//         }

//         return Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFF1E1E2C), Color(0xFF12121A)],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           // FIX 1: Wrap the whole view in a SingleChildScrollView to prevent vertical overflow
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Enter 32-bit Memory Address (Hex)",
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                     letterSpacing: 0.5,
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: TextField(
//                         controller: _hexController,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'monospace',
//                           fontSize: 16,
//                         ),
//                         decoration: InputDecoration(
//                           prefixText: "0x ",
//                           prefixStyle: const TextStyle(
//                             color: Colors.white54,
//                             fontSize: 16,
//                           ),
//                           filled: true,
//                           fillColor: Colors.white.withOpacity(0.05),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.white.withOpacity(0.1),
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: const BorderSide(
//                               color: Colors.blueAccent,
//                               width: 2,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 16),
//                     ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blueAccent,
//                         foregroundColor: Colors.white,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 24,
//                           vertical: 18,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         elevation: 4,
//                       ),
//                       onPressed: () => _calculate(state.engine!),
//                       child: const Text(
//                         "Decode",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 32),
//                 if (info != null) ...[
//                   InteractiveViewer(
//                     minScale: 0.5,
//                     maxScale: 3.0,
//                     panEnabled: true,
//                     scaleEnabled: true,
//                     child: _buildAddressDivision(
//                       info!.tagBin,
//                       info!.indexBin,
//                       info!.offsetBin,
//                     ),
//                   ),
//                   // FIX 2: Removed the duplicated set of result cards
//                   _buildResultCard(
//                     "FULL ADDRESS",
//                     info!.addrHex,
//                     info!.addrBin,
//                     Colors.purpleAccent,
//                   ),

//                   _buildResultCard(
//                     "TAG",
//                     info!.tagHex,
//                     info!.tagBin,
//                     Colors.redAccent,
//                   ),

//                   _buildResultCard(
//                     "INDEX",
//                     info!.indexHex,
//                     info!.indexBin,
//                     Colors.greenAccent,
//                   ),

//                   _buildResultCard(
//                     "OFFSET",
//                     info!.offsetHex,
//                     info!.offsetBin,
//                     Colors.blueAccent,
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildResultCard(
//     String title,
//     String hexStr,
//     String binStr,
//     Color accentColor,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 16),
//       decoration: BoxDecoration(
//         color: const Color(0xFF252534),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: accentColor.withOpacity(0.4), width: 1.5),
//         boxShadow: [
//           BoxShadow(
//             color: accentColor.withOpacity(0.15),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: ListTile(
//           title: Text(
//             title,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: accentColor,
//               letterSpacing: 1.2,
//             ),
//           ),
//           subtitle: Padding(
//             padding: const EdgeInsets.only(top: 8.0),
//             child: Text(
//               "Bin: $binStr",
//               style: TextStyle(
//                 color: Colors.white.withOpacity(0.7),
//                 fontFamily: 'monospace',
//                 fontSize: 13,
//               ),
//             ),
//           ),
//           trailing: Text(
//             "0x$hexStr",
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//               fontFamily: 'monospace',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget _divisionBox(String title, String bits, String value, Color color) {
//   return Container(
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//       color: color.withOpacity(.15),
//       borderRadius: BorderRadius.circular(10),
//       border: Border.all(color: color),
//     ),
//     child: Column(
//       children: [
//         Text(
//           title,
//           style: TextStyle(color: color, fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 4),
//         Text(bits, style: const TextStyle(color: Colors.white70, fontSize: 11)),
//         const SizedBox(height: 10),

//         // FIX 3: Wrapped the binary string in a FittedBox to automatically shrink
//         // the text instead of horizontally overflowing the screen bounds.
//         FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Text(
//             value,
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               color: Colors.white,
//               fontFamily: "monospace",
//               fontWeight: FontWeight.bold,
//               fontSize: 13,
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget _buildAddressDivision(String tag, String index, String offset) {
//   // FIX 4: Removed unnecessary SingleChildScrollView around the Container
//   return Container(
//     margin: const EdgeInsets.only(bottom: 25),
//     padding: const EdgeInsets.all(18),
//     decoration: BoxDecoration(
//       color: const Color(0xFF252534),
//       borderRadius: BorderRadius.circular(16),
//       border: Border.all(color: Colors.white24),
//     ),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "32-bit Address Division",
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         const SizedBox(height: 20),

//         Row(
//           children: [
//             Expanded(
//               child: _divisionBox(
//                 "TAG",
//                 "${tag.length} bits",
//                 tag,
//                 Colors.redAccent,
//               ),
//             ),

//             const SizedBox(width: 4),

//             Expanded(
//               child: _divisionBox(
//                 "INDEX",
//                 "${index.length} bits",
//                 index,
//                 Colors.greenAccent,
//               ),
//             ),

//             const SizedBox(width: 4),

//             Expanded(
//               child: _divisionBox(
//                 "OFFSET",
//                 "${offset.length} bits",
//                 offset,
//                 Colors.blueAccent,
//               ),
//             ),
//           ],
//         ),
//       ],
//     ),
//   );
// }
import 'package:cache_app/bloc/cache_state.dart';
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
  final TextEditingController _hexController = TextEditingController(
    text: "1A2B3C",
  );
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
          return const Center(
            child: CircularProgressIndicator(color: Colors.amberAccent),
          );
        }

        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1E1E2C), Color(0xFF12121A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
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
                      child: TextField(
                        controller: _hexController,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'monospace',
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          prefixText: "0x ",
                          prefixStyle: const TextStyle(
                            color: Colors.amberAccent,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.05),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: Colors.amberAccent,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amberAccent, 
                        foregroundColor: Colors.black87, 
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      onPressed: () => _calculate(state.engine!),
                      child: const Text(
                        "Decode",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (info != null) ...[
                  // Removed InteractiveViewer because stacked layout solves the sizing issue
                  _buildAddressDivision(
                    info!.tagBin,
                    info!.indexBin,
                    info!.offsetBin,
                  ),
                  
                  // Replaced dull greys with vibrant, distinct colors
                  _buildResultCard(
                    "FULL ADDRESS",
                    info!.addrHex,
                    info!.addrBin,
                    Colors.amberAccent,
                  ),

                  _buildResultCard(
                    "TAG",
                    info!.tagHex,
                    info!.tagBin,
                    Colors.pinkAccent,
                  ),

                  _buildResultCard(
                    "INDEX",
                    info!.indexHex,
                    info!.indexBin,
                    Colors.greenAccent,
                  ),

                  _buildResultCard(
                    "OFFSET",
                    info!.offsetHex,
                    info!.offsetBin,
                    Colors.cyanAccent,
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultCard(
    String title,
    String hexStr,
    String binStr,
    Color accentColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF252534),
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
                color: Colors.white.withOpacity(0.8),
                fontFamily: 'monospace',
                fontSize: 14,
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

// Updated division box to span horizontally and stack its contents neatly
Widget _divisionBox(String title, String bits, String value, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    decoration: BoxDecoration(
      color: color.withOpacity(.12),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withOpacity(0.6), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: color, 
                fontWeight: FontWeight.bold,
                fontSize: 15,
                letterSpacing: 1.5,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                bits, 
                style: TextStyle(
                  color: color, 
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "monospace",
              fontWeight: FontWeight.bold,
              fontSize: 18, // Increased size for readability
              letterSpacing: 2.0,
            ),
          ),
        ),
      ],
    ),
  );
}

// Updated to use a vertical Column instead of a single Row
Widget _buildAddressDivision(String tag, String index, String offset) {
  return Container(
    margin: const EdgeInsets.only(bottom: 30),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFF252534),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.2),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "32-bit Address Division",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 20),
        
        // Stacked vertically to prevent squishing
        _divisionBox(
          "TAG",
          "${tag.length} bits",
          tag,
          Colors.pinkAccent, 
        ),
        const SizedBox(height: 12),
        
        _divisionBox(
          "INDEX",
          "${index.length} bits",
          index,
          Colors.greenAccent, 
        ),
        const SizedBox(height: 12),
        
        _divisionBox(
          "OFFSET",
          "${offset.length} bits",
          offset,
          Colors.cyanAccent, 
        ),
      ],
    ),
  );
}