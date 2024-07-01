//
//  New_Workout.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//
import SwiftUI
import Combine
import Foundation

struct New_Workout: View {
    @StateObject var apiService = PostWorkoutAPI()
    @State private var workoutTypeSelection = ""
    @State private var musclesInput: String = ""
    @State private var workoutsInput: String = ""
    @State private var setsInput1 = ""
    @State private var repsInput1 = ""
    @State private var repsInput2 = ""
    @State private var repsInput3 = ""
    @State private var setsInput: Int = 0
    @State private var repsInput: Int = 0
    @State private var weightInput: Double = 0.0
    @State private var distanceInput: Double = 0.0
    @State private var timeInput = ""
    @State private var selection = "Back"
    @State private var selection1 = "Deadlift"
    @State private var isButtonTapped: Bool = false
    @State private var apiResponse: String = ""
    @State private var weightMeasurementInput = ""
    @State private var name = "Frank Sinatra"
    @State private var dropSet = false
    @State private var darkMode = false
    @State private var cardioTypeSelected = ""
    //@State private var cardioTime = ""
    @State private var typeOfWorkoutSelected = ""
    @State private var username = ""
    

    
    
    
 
    let typeOfWorkout = ["--Select--","Traditional", "Super Set", "Drop Set"]
    
    let muscles = ["Select","Back", "Biceps", "Legs", "Chest", "Triceps","Shoulders","Abs"]
    //let sets = ["1","2","3","4","5","6"]
    let sets = Array(1...6)
    let reps = Array(1...20)
    
    let backWorkouts = ["Deadlift",
                        "Chin Up",
                        "Lat pull down cable",
                        "Bent over row",
                        "ISO row wide",
                        "T bar row","Wide pull up",
                        "RDL",
                        "Lat pull down machine",
                        "In bent over row",
                        "DB Bench row",
                        "Face pulls",
                        "Cable low row",
                        "Rear delts"]
    
    let legWorkouts = ["Squat",
                       "Lunge",
                       "Hip raise",
                       "Calf","Goblet Squat",
                       "Leg press",
                       "Leg extension",
                       "Quad curl",
                       "Hip abductor out",
                       "Hip abductor in"]
    
    let shoulderWorkouts = ["barbell Shoulder Press",
                            "Upright BB row",
                            "Trap shrug",
                            "Dumbbell lateral raise",
                            "Dumbbell forward raise", "Twist DB Shoulder press",
                            "Cable lateral raise",
                            "Machine Lateral raise",
                            "Plates raise/DB raise",
                            "Iso shoulder press"]
    let bicepWorkouts = ["Bar bicep curl",
                         "Rope Hammer curl",
                         "Incline Curl",
                         "Preacher curls","Dumbbell curl",
                         "Reverse curl",
                         "Bicep machine",
                         "Cable Curl",
                         "Concentration Curl",
                         "Drag Curl"]
    
    let chestWorkouts = ["Bench",
                         "Incline bench",
                         "Decline bench",
                         "Flyes/rear delt machine","DB bench",
                         "Incline iso press",
                         "Decline machine",
                         "Db Flye",
                         "Incline DB Flye",
                         "Cable Crossover"]
    
    let tricepWorkouts = ["Dip",
                          "Close grip bench",
                          "Seated overhead DB extension",
                          "Skullcrushers","Dips machine",
                          "Tricep machine",
                          "Cable push downs",
                          "Cable Overhead extension",
                          "Double DB extension laying down",
                          "Sideways cable extensión"]
    
    let abWorkouts = ["Crunches","Leg raise",
                      "Russian twist",
                      "Mountain climber",
                      "Seated in and outs",
                      "Deadman hang leg up",
                      "Crucifix",
                      "Star crunches",
                      "Plank",
                      "Side plank reach through",
                      "Bicycle"]
    
    let weightMeasurement = ["Lbs","Kg"]
    var body: some View {
        //@State private var typeOfWorkoutSelected = ""
        NavigationView {
            VStack {
               /* Image("ProgressLogo1")
                    .resizable() // Allows the image to be resized
                    .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                    .frame(width: 400, height: 200) // Sets the frame size of the image
                    .clipped()
                    */
                    
                    Text("Type of Strength Training")
                        .padding(.top, 10)
                    Picker("", selection: $typeOfWorkoutSelected)
                    {
                        ForEach(typeOfWorkout, id: \.self) {
                            Text($0)
                        }
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.blue, lineWidth: 1)
                    )

                        Text("Which muscle?")
                        Picker("Select Muscle", selection: $musclesInput) {
                            ForEach(muscles, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.blue, lineWidth: 1)
                        )
                        //.clipShape(RoundedRectangle(cornerRadius: 8))
                        
                        //.pickerStyle(.menu)
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        // .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/,width: 1)
                        
                        if musclesInput == "Back" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(backWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        } else if musclesInput == "Chest" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(chestWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                            .border(Color.blue,width: 1)
                        } else if musclesInput == "Legs" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(legWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        } else if musclesInput == "Triceps" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(tricepWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        } else if musclesInput == "Biceps" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(bicepWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }else if musclesInput == "Shoulders" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(shoulderWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }else if musclesInput == "Abs" {
                            Text("Which workout?")
                            Picker("Select Workout", selection: $workoutsInput) {
                                ForEach(abWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .imageScale(.large)
                            .foregroundColor(.accentColor)
                        }
                        
                        //Sets textbox
                        HStack {
                            Text("Sets")
                                .foregroundColor(.blue) // Customize label color if needed
                                .font(.headline)
                            Picker("", selection: $setsInput) {
                                ForEach(sets, id: \.self) {
                                    sets in
                                    Text("\(sets)")
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .padding()
                            // } ( Removing the end of the HStack )
                            
                            //Reps textbox
                            //HStack { ( Removing the beginning of this HStack )
                            Text("Reps")
                                .foregroundColor(.blue) // Customize label color if needed
                                .font(.headline)
                            Picker("", selection: $repsInput) {
                                ForEach(reps, id: \.self) {
                                    reps in
                                    Text("\(reps)")
                                }
                            }
                            .pickerStyle(.menu)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.blue, lineWidth: 1)
                            )
                            .padding()
                        }
                        
                        //Weight checkbox
                        HStack {
                            Text("Weight")
                                .foregroundColor(.blue) // Customize label color if needed
                                .font(.headline)
                            TextField("Weight", text: Binding(
                                get: { "" },
                                set: {
                                    if let newValue = Double($0) {
                                        weightInput = newValue
                                    }
                                }
                            ))
                            .padding()
                            // }
                            //Weight measurement picklist
                            Text("Lbs or KGs?" )
                                .padding(.top,10)
                            Picker("Select Weight Measurement", selection: $weightMeasurementInput) {
                                ForEach(weightMeasurement, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.menu)
                            //.padding()
                        }
                Text("Email (Will become Username)")
                TextField("Email", text: $username)
                        //Submit workout via API call
                        Button("Submit Workout") {
                            isButtonTapped = true
                            /*apiService.postData(name: <#T##String#>, muscles: <#T##String#>, Workout: <#T##String#>, Sets: <#T##Int#>, Reps: <#T##Int#>, Weight: <#T##Double#>)*/
                            apiService.postData(name: name, ExerciseType: typeOfWorkoutSelected, muscles: musclesInput, Workout: workoutsInput, Sets: setsInput, Reps: repsInput, Weight: weightInput, weightMeasurement: weightMeasurementInput, username: username)
                            
                            
                        }
                        .padding()
                        .background(Color.black)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)
                        .border(Color.blue, width: 2)
                        
                       /* if let responseData = apiService.responseData {
                            // Display data from the API response
                        }*/
                        
                        if isButtonTapped{
                            /*Text("Muscle: \(musclesInput),Workout: \(workoutsInput), Sets: \(setsInput), Reps: \(repsInput), Weight: \(weightInput)")
                             .font(.title)
                             .padding()
                             */
                            if($setsInput.wrappedValue > 0 && $repsInput.wrappedValue > 0 && $weightInput.wrappedValue > 0.0){
                                let results3 = (Double($setsInput.wrappedValue) * Double($repsInput.wrappedValue) * $weightInput.wrappedValue)
                                
                                Text("Weight moved this Workout \(String(format: "%.2f", results3)) \(weightMeasurementInput)")
                            }
                            
                        }
                        
                }
                                                        
                        }
                    }
                    
                }

    

        
        
        

