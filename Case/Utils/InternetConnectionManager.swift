//
//  InternetConnectionManager.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation
import Network

class InternetConnectionManager {
    static let shared = InternetConnectionManager()
    
    private let monitor = NWPathMonitor()
    private var isInternetAvailable = false
    
    private init() {
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { path in
            self.isInternetAvailable = path.status == .satisfied
            print("Internet is \(self.isInternetAvailable ? "available" : "not available")")
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func isInternetAccessible() -> Bool {
        return isInternetAvailable
    }
}
