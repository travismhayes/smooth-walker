//
//  HealthStore.swift
//  SmoothWalker
//
//  Created by travis hayes on 5/31/22.
//

import Foundation
import HealthKit

// TODO: move to a seperate file
extension Date {
    static func mondayAtTwelveAm() -> Date {
        return Calendar(identifier: .iso8601)
            .date(from: Calendar(identifier: .iso8601)
            .dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
}

// wrapper for hkhealthkit
class HealthStore {
    
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateStep(completion: @escaping (HKStatisticsCollection?) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        // Starting from a week ago
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        // Anchor is when day will the day start, what time?
        let anchorDate = Date.mondayAtTwelveAm()
        // calculate daily
        let daily = DateComponents(day: 1)
        // allows us to query the data for the sample we need.
        let predict = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predict, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query?.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        // execute the query
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
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
