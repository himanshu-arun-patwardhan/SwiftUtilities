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

## Usage Example

> ### Keychain storage

This section documents the storing of token in the keychain and helpers required for testable abstraction.

#### Components

- `TokenStoreKeys`
  - A small enum of string constants used as key names when saving tokens to keychain storage.
  - Example: `TokenStoreKeys.accessToken` is the key used for the access token.

```swift
enum TokenStoreKeys {
    static let accessToken = "accessToken"
}
```  


- `TokenStoreProtocol`
  - Contract for a token store.
  - Exposes a mutable `accessToken: String?` and a `clearAll()` method.

```swift
protocol TokenStoreProtocol {
    var accessToken: String? { get set }
    
    func clearAll()
}
```


- `TokenStore`
  - A `final` singleton implementing `TokenStoreProtocol`.
  - Uses a `KeychainStorageProtocol` implementation (by default `KeychainStorageManager`) to persist the token securely.
  - Behaviour:
    - Reading `accessToken` forwards to the underlying keychain storage.
    - Setting `accessToken` saves to keychain; setting to `nil` deletes the key.
    - `clearAll()` deletes the stored access token.
   

```swift
final class TokenStore: TokenStoreProtocol {
    static let shared = TokenStore()
    ///
    private let storage: KeychainStorageProtocol
    
    // MARK: -
    init(storage: KeychainStorageProtocol = KeychainStorageManager()) {
        self.storage = storage
    }
    
    // MARK: -
    var accessToken: String? {
        get { storage.get(for: TokenStoreKeys.accessToken) }
        set {
            if let value = newValue {
                storage.save(value, for: TokenStoreKeys.accessToken)
            } else {
                storage.delete(for: TokenStoreKeys.accessToken)
            }
        }
    }

    // MARK: -
    func clearAll() {
        storage.delete(for: TokenStoreKeys.accessToken)
    }
}
```


- `TokenService`
  - An `@MainActor` `ObservableObject` wrapper around a `TokenStoreProtocol` instance.
  - Intended to be used by networking code to save tokens returned from an auth endpoint.
  - Contains a convenience method to persist a token into the store.

The snippet shows a `saveToken(accessToken: String)` method that should save the passed-in token to the store. A concise implementation:

```swift
@MainActor
class TokenService: ObservableObject {
    private var tokenStore: TokenStoreProtocol = TokenStore.shared

    // MARK: -
    private func saveToken(accessToken: String) {
        tokenStore.accessToken = accessToken
    }
}
```

##
> ### UserDefaults storage
This section documents the storing of user-information in the UserDefaults and helpers required for testable abstraction.

#### Components

- `UserInfoStoreKeys`
  - A small enum of string constants used as key names when saving user-information to UserDefaults.
  - Example: `UserInfoStoreKeys.userId` is the key used for the userId.

```swift
enum UserInfoStoreKeys {
    static let userId = "userId"
    static let username = "username"
}
```  


- `UserInfoStoreProtocol`
  - Contract for a user-information store.
  - Exposes a mutable `userId: int?` `username: String?` and a `clearAll()` method.

```swift
protocol UserInfoStoreProtocol {
    var userId: Int? { get set }
    var username: String? { get set }
    
    func clearAll()
}
```


- `UserInfoStore`
  - A `final` singleton implementing `UserInfoStoreProtocol`.
  - Uses a `UserDefaultsStorageProtocol` implementation (by default `UserDefaultsManager`) to persist the user-information.
  - Behaviour:
    - Reading `userId`, `username` forwards to the underlying UserDefaults.
    - Setting `userId`, `username` saves to UserDefaults; setting to `nil` deletes the key.
    - `clearAll()` deletes the stored user-information.
   

```swift
truct UserInfoStore: UserInfoStoreProtocol {
    static let shared = UserInfoStore()
    ///
    private let storage: UserDefaultsStorageProtocol
    
    // MARK: -
    init(store: UserDefaultsStorageProtocol = UserDefaultsManager()) {
        self.storage = store
    }
    
    // MARK: -
    var userId: Int? {
        get { storage.get(forKey: UserInfoStoreKeys.userId) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.userId) }
    }
    
    var username: String? {
        get { storage.get(forKey: UserInfoStoreKeys.username) }
        set { storage.set(newValue, forKey: UserInfoStoreKeys.username) }
    }

    // MARK: -
    func clearAll() {
        storage.clearAll()
    }
}
```


- `UserInfoService`
  - An `@MainActor` `ObservableObject` wrapper around a `UserInfoStoreProtocol` instance.
  - Intended to be used by networking code to save user-information returned from an api endpoint.
  - Contains a convenience method to persist a user-information into the UserDefaults.

The snippet shows a `saveUserInfo(userId: String, username: String)` method that should save the passed-in user-information to the UserDefaults. A concise implementation:

```swift
@MainActor
class UserInfoService: ObservableObject {
    private var userInfoStore: UserInfoStoreProtocol = UserInfoStore.shared
    
    // MARK: -
    private func saveUserInfo(userId: String, username: String) {
        userInfoStore.userId = userId
        userInfoStore.username = username
    }
}
```
