//
//  Logger.swift
//
//
//
//

import Foundation
import os

public struct Logger {
    private static let subsystem = Bundle.main.bundleIdentifier ?? "com.yourapp.logger"
    
    public static func log(
        _ message: String,
        level: LogLevel = .info,
        category: LogCategory = .general,
        file: String = #file,
        function: String = #function,
        line: Int = #line
    ) {
#if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(level.rawValue)] [\(category)] \(fileName):\(line) → \(function)\n→ \(message)")
#else
        let log = OSLog(subsystem: subsystem, category: category.rawValue)
        os_log("%{public}@", log: log, type: level.osLogType, message)
#endif
    }
}
