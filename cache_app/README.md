
# Project Title

A brief description of what this project does and who it's for

# 🧠 Cache Simulator

<p align="center">
  <b>An interactive CPU Cache Simulator built with Flutter & BLoC.</b><br>
  Learn, visualize, and experiment with cache memory concepts through an intuitive and modern interface.
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter">
  <img src="https://img.shields.io/badge/Dart-3.x-blue?logo=dart">
  <img src="https://img.shields.io/badge/BLoC-State%20Management-blue">
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS-success">
</p>

---

## 📖 About

**Cache Simulator** is a modern educational application built using **Flutter** and **BLoC State Management** to help students understand how CPU cache memory works.

Instead of simply displaying results, the simulator provides an interactive experience where users can configure cache parameters, simulate memory accesses, visualize cache contents, and observe how different cache organizations, replacement policies, and write strategies affect system performance.

Whether you're learning **Computer Organization & Architecture**, preparing for interviews, or teaching cache memory concepts, this application provides a practical way to understand cache behavior.

---

# ✨ Features

## ⚙️ Cache Configuration

Configure every major cache parameter before starting the simulation.

- Cache Size
- Block Size
- Set Size
- Number of Cache Lines
- Address Size
- Associativity

---

## 🧮 Address Calculator

A built-in calculator for cache address decomposition.

Supports:

- Binary ↔ Decimal ↔ Hexadecimal Conversion
- Tag Calculation
- Set Index Calculation
- Block Offset Calculation
- Memory Address Breakdown
- Cache Line Mapping

This makes it easy to understand how addresses are interpreted by different cache organizations.

---

## 🚀 Interactive Cache Simulation

Simulate memory accesses in real time.

Features include:

- Cache Hits
- Cache Misses
- Block Loading
- Block Replacement
- Memory Access Visualization
- Live Cache Updates

Every operation is reflected instantly on the cache table.

---

## 🏷 Cache Metadata

Each cache line displays important metadata including:

- ✅ Valid Bit
- 📝 Dirty Bit
- 🏷 Tag
- 📦 Stored Block

This helps users understand how cache entries are maintained internally.

---

## 🧩 Cache Organizations

Supports all three major cache organizations.

- Direct Mapped Cache
- Fully Associative Cache
- Set Associative Cache

Users can switch between them instantly from the settings menu.

---

## 🔄 Replacement Policies

Choose how cache blocks are replaced.

- Least Recently Used (LRU)
- First In First Out (FIFO)
- Random Replacement

---

## ✍️ Write Policies

Supports both write mechanisms used in modern processors.

- Write Back
- Write Through

---

## 🎨 Clean User Interface

- Material Design
- Responsive Layout
- Smooth Navigation
- Intuitive Controls
- Beginner Friendly

---

# 🛠 Tech Stack

- **Flutter**
- **Dart**
- **BLoC State Management**
- **Material Design**

---

# 🏗 Architecture

The project follows the **BLoC Architecture**, ensuring a clean separation between UI and business logic.

```
lib
│
├── blocs
│
├── models
│
├── screens
│
├── widgets
│
├── utils
│
└── main.dart
```

---

# 📱 Application Modules

### 🏠 Home

Configure cache parameters before simulation.

---

### 🧮 Calculator

Calculate:

- Binary
- Decimal
- Hexadecimal
- Tag
- Set Index
- Block Offset

---

### ⚡ Simulator

Visualize

- Cache Hits
- Cache Misses
- Cache Replacement
- Dirty Bit Updates
- Valid Bit Updates

---

### ⚙️ Settings Drawer

Configure

- Cache Organization
- Replacement Policy
- Write Policy

---

# 🎯 Educational Value

This simulator helps users understand:

- CPU Cache Memory
- Memory Hierarchy
- Address Translation
- Cache Mapping
- Replacement Algorithms
- Write Policies
- Cache Performance

Perfect for:

- Computer Organization & Architecture
- Operating Systems
- GATE Preparation
- University Labs
- Interview Preparation

---

# 📸 Screenshots

> Add screenshots here

```
assets/screenshots/home.png

assets/screenshots/calculator.png

assets/screenshots/simulator.png

assets/screenshots/settings.png
```

---

# 🚀 Getting Started

## Clone Repository

```bash
git clone https://github.com/yourusername/cache-simulator.git
```

## Navigate

```bash
cd cache-simulator
```

## Install Dependencies

```bash
flutter pub get
```

## Run

```bash
flutter run
```

---

# 🌟 Upcoming Features

This project is actively being improved.

Planned additions include:

- ✅ Multi-Level Cache (L1, L2, L3)
- 📊 Performance Dashboard
- 📈 Hit/Miss Statistics Graphs
- 📂 Import Memory Trace Files
- 📤 Export Simulation Reports (PDF/CSV)
- 💾 Save & Load Cache Configurations
- 🎬 Step-by-Step Simulation Animation
- 📚 Interactive Learning Mode
- 🎯 Challenge & Quiz Mode
- 🌙 Dark Mode
- 📱 Tablet/Desktop Responsive Layout
- 🔥 Cache Access History Timeline
- 🧠 Instruction Cache & Data Cache Simulation
- ⚡ Average Memory Access Time (AMAT) Calculator
- 📉 Performance Comparison Between Cache Organizations
- 🖥 Multi-Core Cache Simulation (Future Research)

---

# 💡 Why This Project?

Unlike traditional cache simulators, this application focuses on **interactive learning**.

Instead of only displaying the final cache state, users can observe every memory access and understand:

- Why a hit occurred
- Why a miss occurred
- Which block was replaced
- Why a replacement policy selected that block
- How dirty and valid bits change
- How write policies affect memory updates

This makes learning cache memory significantly easier and more engaging.

---

# 🤝 Contributing

Contributions are always welcome.

If you have ideas for:

- New replacement policies
- UI improvements
- Performance optimizations
- Educational features

Feel free to open an issue or submit a pull request.

---

# 📄 License

This project is licensed under the **MIT License**.

---

# ⭐ Support

If you found this project useful,

please consider giving it a ⭐ **Star** on GitHub.

It helps others discover the project and motivates future development.

---

<p align="center">
<b>Built with ❤️ using Flutter, Dart & BLoC</b>

Making Computer Architecture interactive, visual, and easy to understand.
</p>
