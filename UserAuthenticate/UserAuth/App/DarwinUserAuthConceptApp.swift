//
//  DarwinUserAuthConceptApp.swift
//  DarwinUserAuthConcept
//
//  Created by Aidan Bergerson on 6/27/23.
//

import SwiftUI
import Firebase

@main
struct DarwinUserAuthConceptApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var viewModel = AuthViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
