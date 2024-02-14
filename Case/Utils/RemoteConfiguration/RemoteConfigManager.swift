//
//  RemoteConfigManager.swift
//  Case
//
//  Created by Sevgi Toprak on 10.02.2024.
//

import Foundation
import FirebaseRemoteConfig

struct RemoteConfigManager {
    
    private static var remoteConfig: RemoteConfig = {
        let remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(fromPlist: "RemoteConfigDefaults")
        return remoteConfig
    }()
    
    static func configure(expirationDuration: TimeInterval = 3600.0) {
        remoteConfig.fetch(withExpirationDuration: expirationDuration) { status, error in
            if let error = error {
                print("Error fetching remote config: \(error.localizedDescription)")
                return
            }
            print("Received values from Remote Config")
            RemoteConfig.remoteConfig().activate(completion: nil)
        }
    }
    
    static func value(forKey key: RCKey) -> String? {
        guard let value = remoteConfig.configValue(forKey: key.rawValue).stringValue else {
            print("Value for key \(key.rawValue) not found in Remote Config")
            return nil
        }
        return value
    }
}
