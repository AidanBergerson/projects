//
//  ContentView.swift
//  DarwinUserAuthConcept
//
//  Created by Aidan Bergerson on 6/27/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if viewModel.userSession != nil {
            ProfileView()
        } else {
            LoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
