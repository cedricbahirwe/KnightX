//
//  ConnectivityManager.swift
//  TheMovieApp
//
//  Created by Cédric Bahirwe on 10/10/2022.
//

import Network

public class ConnectivityManager {
    private let monitor = NWPathMonitor()
    public static let shared = ConnectivityManager()
    private var connected: Bool

    public init() {
        self.connected = true
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.connected = true
            } else {
                self.connected = false
            }
        }
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }

    public func isConnected() -> Bool {
        return self.connected
    }
}
