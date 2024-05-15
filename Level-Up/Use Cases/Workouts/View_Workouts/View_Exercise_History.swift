//
//  View_Exercise_History.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/15/24.
//
import SwiftUI
import Combine
import Foundation

struct ProgressHistory: View {
    @State private var progressStartDate = Date()
    @State private var progressEndDate = Date()
    var body: some View {
        Text("Which Muscle")
        Text("Which Workout?")
        DatePicker("Start Date", selection: $progressStartDate, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
        DatePicker("End Date", selection: $progressEndDate, displayedComponents: .date)
            .datePickerStyle(WheelDatePickerStyle())
    }
}
