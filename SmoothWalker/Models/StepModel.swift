//
//  StepModel.swift
//  SmoothWalker
//
//  Created by travis hayes on 6/1/22.
//

import Foundation
import HealthKit

class StepModel : ObservableObject {
    @Published var steps : [Step] = [Step]()
    
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }

    func retrieveStepCount() {
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
                if success {
                    healthStore.calculateStep { statisticsCollection in
                        if let statisticsCollection = statisticsCollection {
                            self.updateStepModelFromStatistics(statisticsCollection)
                        }
                    }
                }
            }
        }
    }
    
    private func updateStepModelFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startDate, to: endDate) { (statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            let step = Step(count: Int(count ?? 0), date: statistics.startDate)
            self.steps.append(step)
        }
    }
}
