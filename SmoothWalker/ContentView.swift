//
//  ContentView.swift
//  SmoothWalker
//
//  Created by travis hayes on 5/31/22.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @ObservedObject var stepModel : StepModel
    
    var body: some View {
        NavigationView {
            List(stepModel.steps, id: \.id) { step in
                VStack(alignment: .leading) {
                    Text("\(step.count)")
                    Text(step.date, style: .date)
                        .opacity(0.5)
                }
            }
            .navigationTitle("Smooth Walker")
        }
        .onAppear() {
            stepModel.retrieveStepCount()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(stepModel: StepModel())
    }
}
