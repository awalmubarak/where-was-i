//
//  DataStore.swift
//  Where was I
//
//  Created by Mubarak Awal on 17/02/2019.
//  Copyright © 2019 Mubarak Awal. All rights reserved.
//

import Foundation

struct StorageKeys {
    static let storedLat = "storedLatitude"
    static let storedLong = "storedLongitude"
}

class DataStore {
    func getDefaults()->UserDefaults{
        return UserDefaults.standard
    }
    
    func saveLocation(lat: String, long: String){
        let defaults = getDefaults()
        defaults.setValue(lat, forKey: StorageKeys.storedLat)
        defaults.setValue(long, forKey: StorageKeys.storedLong)
        defaults.synchronize()
        print(lat + " " + long)
    }
    
    func getLastLocation()->VisitedPoint?{
        let defaults = getDefaults()
        if let lat = defaults.string(forKey: StorageKeys.storedLat){
            if let long = defaults.string(forKey: StorageKeys.storedLong){
                return VisitedPoint(lat: lat, long: long)
            }
        }
        return nil
    }
}
