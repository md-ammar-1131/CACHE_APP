# Advanced Cache Architecture Simulator 🧠💻

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![BLoC](https://img.shields.io/badge/State_Management-BLoC-blue?style=for-the-badge)

A cycle-accurate CPU cache memory simulator and visualizer built with Flutter. This tool dynamically models how memory addresses are decoded and how data flows through a processor's cache based on configurable mapping techniques, write policies, and replacement algorithms.

Designed with a clean, monochrome dark-mode interface, this project serves as both an educational visualization tool for computer architecture students and a demonstration of robust mobile/desktop state management.

## 🚀 Features

* **Dynamic Address Decoding:** Converts 32-bit hexadecimal memory addresses into binary, automatically applying bitwise masks to split the address into **Tag**, **Index**, and **Offset** bits based on current cache configurations.
* **Configurable Architecture:**
  * **Mapping Types:** Direct-Mapped, N-way Set-Associative, and Fully-Associative.
  * **Cache Settings:** Adjustable overall Cache Size and Block/Line Size.
* **Cycle-Accurate Latency Tracking:** 
  * Calculates **Total Cycles** and **Average Memory Access Time (AMAT)**.
  * Accurately applies hit latency and memory fetch miss penalties.
* **Advanced Cache Policies:**
  * **Write-Back (with Write-Allocate):** Tracks `Valid` and `Dirty` bits. Applies write-back cycle penalties only when a dirty block is evicted.
  * **Write-Through (with No-Write-Allocate):** Accurately models write-around behavior where write misses bypass the cache and go straight to memory, preserving cache state.
  * **Eviction/Replacement Algorithms:** LRU (Least Recently Used), FIFO (First-In, First-Out), and Random.
* **Real-time State Visualization:** Explore active cache sets, view block data/metadata, and monitor an operation log of all Hits, Misses, and Evictions.

## 📸 Screenshots

| Login / Authentication | Home Feed |
| :---: | :---: |
| <img src="screenshots/IMG1.png" width="300" alt="MAIN SCREEN"/> | <img src="screenshots/IMG2.png" width="300" alt="LOGS"/> |

## 🛠️ Technical Stack & Architecture

* **Framework:** Flutter / Dart
* **State Management:** BLoC (Business Logic Component) + Equatable
* **UI Design:** Custom monochrome/dark theme utilizing Flutter Slivers and CustomScrollViews for responsive keyboard handling and fluid layout behavior.

### Why BLoC?
The application relies heavily on the **BLoC pattern** to strictly separate the complex, low-level hardware simulation logic (the `CacheEngine`) from the UI presentation layer. State changes (like cache hits, evictions, or configuration updates) are triggered via discrete events, ensuring the UI stays perfectly synchronized with the underlying mathematical models without unnecessary widget rebuilds.

## 💻 Getting Started

### Prerequisites
* Flutter SDK (v3.0.0 or higher)
* Dart SDK

### Installation

1. Clone the repository:
   ```bash
   git clone [https://github.com/yourusername/advanced-cache-simulator.git](https://github.com/yourusername/advanced-cache-simulator.git)
