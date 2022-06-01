//
//  SmoothWalkerApp.swift
//  SmoothWalker
//
//  Created by travis hayes on 5/31/22.
//

import SwiftUI

@main
struct SmoothWalkerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(stepModel: StepModel())
        }
    }
}
