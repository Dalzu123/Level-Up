//
//  Profile_View.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//
import SwiftUI
import Combine
import Foundation

struct ProfileView:View {
    @State private var firstName = ""
    @State private var lastName = ""
    
    var body: some View {
        Text("What are we doing today?")
        NavigationLink(destination: Exercise_Prompt()) {
            Text("Track Workout")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        NavigationLink(destination: ProgressHistory()) {
            Text("See Progress")
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
