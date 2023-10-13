//
//  ProfileView.swift
//  DarwinUserAuthConcept
//
//  Created by Aidan Bergerson on 6/27/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        if let user = viewModel.currentUser {
            Text("End of Concept!")
            
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
            }
            
            Button {
                print("Delete account...")
            } label: {
                Text("Delete Account")
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
