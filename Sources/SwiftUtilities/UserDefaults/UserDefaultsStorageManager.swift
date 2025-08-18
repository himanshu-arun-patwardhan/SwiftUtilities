//
//  UserDefaultsStorageManager.swift
//
//
//
//

import Foundation

public final class UserDefaultsManager: UserDefaultsStorageProtocol {
    private let defaults: UserDefaults
    
    public init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    public func set<T>(_ value: T?, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    public func get<T>(forKey key: String) -> T? {
        return defaults.value(forKey: key) as? T
    }
    
    public func remove(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    public func clearAll() {
        for key in defaults.dictionaryRepresentation().keys {
            defaults.removeObject(forKey: key)
        }
    }
}
