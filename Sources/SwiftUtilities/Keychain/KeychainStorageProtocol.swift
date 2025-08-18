//
//  KeychainStorageProtocol.swift
//
//
//
//

import Foundation

public protocol KeychainStorageProtocol {
    func save(_ value: String, for key: String)
    func get(for key: String) -> String?
    func delete(for key: String)
}
