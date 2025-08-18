//
//  UserDefaultsStorageProtocol.swift
//
//
//
//

import Foundation

public protocol UserDefaultsStorageProtocol {
    func set<T>(_ value: T?, forKey key: String)
    func get<T>(forKey key: String) -> T?
    func remove(forKey key: String)
    func clearAll()
}
