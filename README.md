# SwiftUtilities

A small, lightweight, focused Swift package that provides simple protocols and concrete managers for storing string values in the Keychain and typed values in UserDefaults.

This package exposes two protocols:
- `KeychainStorageProtocol` — a minimal API for saving, retrieving, and deleting `String` values in the system Keychain.
- `UserDefaultsStorageProtocol` — a small, typed wrapper around `UserDefaults` for set/get/remove/clearAll operations.

Concrete implementations are provided:
- `KeychainStorageManager` — wrapper around Keychain to store sensitive data securely.
- `UserDefaultsManager` — wrapper around `Foundation.UserDefaults` for storing non-sensitive, lightweight data.

---

## Features

- Minimal, testable protocols to make dependency injection and mocking easy.
- Simple, secure(`Keychain`), type-safe(`UserDefaults`) and well-scoped implementations that cover common storage needs.
- Easy-to-use API to save(set), retrieve(get), and delete(clear all) values

---

## Installation

### Swift Package Manager

```swift
// In your Package.swift:
.package(url: "https://github.com/himanshu-arun-patwardhan/SwiftUtilities.git", from: "1.0.1")
```

Or add it to your project using Xcode:

1. Go to **File > Swift Packages > Add Package Dependency...**
2. Enter: `https://github.com/himanshu-arun-patwardhan/SwiftUtilities.git`
3. Follow the prompts to select the latest version.

---

## Contributing

Contributions, bug reports, and enhancements are welcome. Please open issues or pull requests for features, bug fixes, or enhancements. Before submitting, ensure your code is well-tested and follows the code style.

---

## Contact

For questions, issues, or support, open a GitHub issue or contact [Himanshu Arun Patwardhan](https://github.com/himanshu-arun-patwardhan).

---
