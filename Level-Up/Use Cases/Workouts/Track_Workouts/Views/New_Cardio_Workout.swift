//
//  New_Cardio_Workout.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/15/24.
//

import SwiftUI
import Combine
import Foundation
let cardioWorkouts = ["Run", "Walk", "Ride","Swim", "Stair Stepper"]


struct New_Cardio_Workout: View {
    @State private var cardioWorkoutsSelection = ""
    @State private var cardioTime = Date()
    @State private var currentDate: Date?
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var miles: Int = 0
    @State var milesDecimal: Double = 0.0
    @State var milesDecimalCount = [".1", ".2", ".3", ".4", ".5", ".6", ".7", ".8",".9"]
    @State var distanceMeasurement = ""
    @State var distanceType = ["mi", "km"]
    @State var isButtonTapped = false
    @State var username = ""
    
    var body: some View {
        
        Text("Workout?")
            .bold()
        Picker("Select Exercise", selection: $cardioWorkoutsSelection)
        {
            ForEach(cardioWorkouts, id: \.self) {
                Text($0)
            }
        }
        VStack {
            Text("Distance:")
                .bold()
            HStack {
                Picker("", selection: $miles){
                    ForEach(0..<27, id: \.self) { i in
                        Text("\(i)")
                    }
                }.pickerStyle(WheelPickerStyle())
                Picker("", selection: $milesDecimal){
                    ForEach(milesDecimalCount, id: \.self) { i in
                        Text("\(i)")
                    }
                }.pickerStyle(WheelPickerStyle())
                Picker("", selection: $distanceMeasurement){
                    ForEach(distanceType, id: \.self) {
                        Text($0)
                    }
                }.pickerStyle(WheelPickerStyle())
            }//.padding(.horizontal)
            
            HStack {
                Picker("", selection: $hours){
                    ForEach(0..<27, id: \.self) { i in
                        Text("\(i) hours").tag(i)
                    }
                }.pickerStyle(WheelPickerStyle())
                Picker("", selection: $minutes){
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i) min").tag(i)
                    }
                }.pickerStyle(WheelPickerStyle())
                Picker("", selection: $seconds){
                    ForEach(0..<60, id: \.self) { i in
                        Text("\(i) seconds").tag(i)
                    }
                }.pickerStyle(WheelPickerStyle())
            }//.padding(.horizontal)
        }
        Text("Email (Will become Username)")
            .bold()
        TextField("Email", text: $username)
        //Submit workout via API call
        Button("Submit Workout") {
            isButtonTapped = true
            /*apiService.postData(name: <#T##String#>, muscles: <#T##String#>, Workout: <#T##String#>, Sets: <#T##Int#>, Reps: <#T##Int#>, Weight: <#T##Double#>)*/
            /*apiService.postData(name: name, muscles: musclesInput, Workout: workoutsInput, Sets: setsInput, Reps: repsInput, Weight: weightInput)
            */
            
        }
        .padding()
        .background(Color.black)
        .shadow(color: .gray, radius: 3, x: 0, y: 2)
        .border(Color.blue, width: 2)

    }
}


