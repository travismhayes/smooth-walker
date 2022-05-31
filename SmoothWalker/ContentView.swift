//
//  ContentView.swift
//  SmoothWalker
//
//  Created by travis hayes on 5/31/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    private var healthStore: HealthStore?
    
    init() {
        healthStore = HealthStore()
    }
    
    var body: some View {
        Text("Hello, world!").padding()
        .onAppear() {
            if let healthStore = healthStore {
                healthStore.requestAuthorization { success in
                    
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
