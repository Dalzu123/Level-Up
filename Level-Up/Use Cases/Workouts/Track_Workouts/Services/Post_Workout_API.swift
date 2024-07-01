//
//  Post_Workout_API.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/15/24.
//
//
import SwiftUI
import Combine
import Foundation

struct PostDataResponse: Decodable {
    // Define the structure of the response data
    let message: String
    // Add other properties as needed
}

func postData(name: String, typeOfWorkoutSelected: String, muscles: String, Workout: String, Sets: Int, Reps: Int, Weight: Double, weightMeasurementInput: String, username: String) {
    // Replace with your API endpoint URL
    let apiUrl = URL(string: "http://71.191.77.247/workout")!
    
   /* let postData = try? JSONSerialization.data(withJSONObject: ["nameParam": "DiegoTest", "musclesParam" : "Shoulders", "WorkoutsParam": "Barbell Shoulder Press", "SetsParam" : 5, "RepsParam" : 5, "WeightParam": 105], options: [])*/
    
    let postData = try? JSONSerialization.data(withJSONObject: ["nameParam": name, "ExerciseTypeParam": typeOfWorkoutSelected, "musclesParam" : muscles, "WorkoutsParam": Workout, "SetsParam" : Sets, "RepsParam" : Reps, "WeightParam": Weight, "weightMeasurementParam": weightMeasurementInput, "usernameparam": username ], options: [])
    
    // Create a URLRequest with the API URL
    var request = URLRequest(url: apiUrl)
    
    // Set the HTTP method to POST
    request.httpMethod = "POST"
    
    // Set the request body if there is data to send
    if let postData = postData {
        request.httpBody = postData
}
    
    // Set the Content-Type header if applicable
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")

    // Create a URLSession task to perform the request
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
        // Handle the response or error here

        if let error = error {
            print("Error: \(error)")
            return
        }

        if let data = data {
            // Parse and handle the response data
            do {
                let json1 = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response JSON: \(json1)")
            } catch {
                print("Error parsing JSON: \(error)")
            }
        }
    }

    // Resume the task to initiate the request
    task.resume()
    
  
}

