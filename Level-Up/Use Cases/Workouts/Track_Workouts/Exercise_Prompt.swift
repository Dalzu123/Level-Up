//
//  Exercise_Prompt.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/15/24.
//
import SwiftUI
import Combine
import Foundation

struct Exercise_Prompt: View {
    let exerciseType = ["--Select--","Cardio","Strength Training"]
    @State private var typeOfExerciseSelected = ""
    //@State private var typeOfWorkoutSelected = ""
    var body: some View {

        NavigationView {
            VStack {
                Image("ProgressLogo1")
                    .resizable() // Allows the image to be resized
                    .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                    .frame(width: 400, height: 200) // Sets the frame size of the image
                    .clipped()
                //Text("Hello, Gym Rat!")
                Text("Type of Exercise")
                Picker("", selection: $typeOfExerciseSelected)
                {
                    ForEach(exerciseType, id: \.self) {
                        Text($0)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.blue, lineWidth: 1)
                )
                if typeOfExerciseSelected == "Strength Training"
                { }
            }
        }
    }
}
struct Exercise_Prompt_Previews: PreviewProvider {
    static var previews: some View {
        Exercise_Prompt()
    }
    
}

