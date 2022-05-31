//
//  HealthStore.swift
//  SmoothWalker
//
//  Created by travis hayes on 5/31/22.
//

import Foundation
import HealthKit

// wrapper for hkhealthkit
class HealthStore {
    
    var healthStore: HKHealthStore?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        // grab step count data
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        guard let healthStore = self.healthStore else {
            return completion(false)
        }

        // toShare = write data.
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(true)
        }
    }
}
