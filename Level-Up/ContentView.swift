//
//  ContentView.swift
//  Gym Workout
//
//  Created by Diego Alzugaray on 1/21/24.
//

/*import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}*/
//
// ContentView.swift
// Gym Workout App
//
// Created by Diego Alzugaray on 12/6/23.
//
import SwiftUI
import Combine
import Foundation
struct MusclesDataModel: Decodable {
  var MusclesID: Int
  var Muscles: String
}
class MusclesViewModel: ObservableObject {
  @Published var one: Int
  init(oneNumber: Int) {
    self.one = oneNumber
  }
}

struct PostDataResponse: Decodable {
    // Define the structure of the response data
    let message: String
    // Add other properties as needed
}

class APIViewModel: ObservableObject {
    var cancellables: Set<AnyCancellable> = []
    @Published var responseData: PostDataResponse?
    @Published var apiResponse = ""
    
    func getMusclesData() {
        // Replace with your API endpoint URL
        let apiUrl = URL(string: "http://71.191.77.247/")!
        
        
        // Create a URLRequest with the API URL
        var request = URLRequest(url: apiUrl)
        
        // Set the HTTP method to POST
        request.httpMethod = "GET"
        
        // Set the request body if there is data to send
        //if let postData = postData {
        //    request.httpBody = postData
      //  }
        
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
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print("Response JSON: \(json)")
                } catch {
                    print("Error parsing JSON: \(error)")
                }
            }
        }

        // Resume the task to initiate the request
        task.resume()
        
      
    }
    
    func postData(name: String, muscles: String, Workout: String, Sets: Int, Reps: Int, Weight: Double) {
        // Replace with your API endpoint URL
        let apiUrl = URL(string: "http://71.191.77.247/workout")!
        
       /* let postData = try? JSONSerialization.data(withJSONObject: ["nameParam": "DiegoTest", "musclesParam" : "Shoulders", "WorkoutsParam": "Barbell Shoulder Press", "SetsParam" : 5, "RepsParam" : 5, "WeightParam": 105], options: [])*/
        
        let postData = try? JSONSerialization.data(withJSONObject: ["nameParam": name, "musclesParam" : muscles, "WorkoutsParam": Workout, "SetsParam" : Sets, "RepsParam" : Reps, "WeightParam": Weight], options: [])
        
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
    }
struct ContentView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var loginAttempt = false
    var body: some View {
        
        NavigationView {
            VStack {
                /*Image("ProgressLogo1")
                    .resizable() // Allows the image to be resized
                                .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                                .frame(width: 400, height: 200) // Sets the frame size of the image
                                .clipped()*/
                Text("Email")
                TextField("Email" ,text: $username)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Text("Password")
                SecureField("Password", text: $password)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
               /* NavigationLink(destination: ProfileView()) {
                    Button("Login")
                    {
                        
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                        
                }
                NavigationLink(destination: CreateAccountView()) {
                    Button("Create Account")
                    {
                        
                    }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                */
                NavigationLink("Login") {ProfileView()}
                    .padding(2.5)
                    .border(Color.blue, width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                    
                NavigationLink("Create Account") {CreateAccountView()}
                    .padding(2)
                    .border(Color.blue, width: 1)
                    .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
            }
            .navigationTitle("Login")
        }
    }
}

struct CreateAccountView: View {
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var isSecondScreenActive = false
    @State private var testPasswords = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Image("ProgressLogo1")
                .resizable() // Allows the image to be resized
                .aspectRatio(contentMode: .fit) // Adjusts the aspect ratio of the image
                .frame(width: 400, height: 200) // Sets the frame size of the image
                .clipped()
            Text("Create Account")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Form {
                Section(header: Text("User Information")) {
                    TextField("First Name", text: $firstName)
                        .autocapitalization(.words)
                    TextField("Last Name", text: $lastName)
                        .autocapitalization(.words)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Password")) {
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
            }
            
            Button("Create Account") {
                testPasswords = true
                
                
            }
            if  testPasswords == true {
                if password == ""
                {
                    Text("Enter and confirm a password")
                        .foregroundStyle(.red)
                }
                
                // Implement account creation logic here
                /*
                 showAlert = true
                 .alert(isPresented: $showAlert) {
                 Alert(title: "Missing Password", message: Text("Enter a password and confirm it"), dismissButton: .default(Text("OK")))
                 }
                 //Alert(title: Text( "Insert a password and //confirm it"), isPresented = $showAlert)
                 }
                 else{
                 self.isSecondScreenActive = true
                 }*/
                //SecondScreen()
                
                // self.isSecondScreenActive = true
                
                /*) {
                 Text("Create Account")
                 .foregroundColor(.white)
                 .frame(maxWidth: .infinity)
                 .padding()
                 .background(Color.blue)
                 .cornerRadius(10)
                 .sheet(isPresented: $isSecondScreenActive) {
                 SecondScreen()
                 }
                 }*/
            }
            //.padding()
        }
        //   .navigationBarTitle("Sign Up", displayMode: .inline)
        //  }
    }
}
    struct ProfileView:View {
        @State private var firstName = ""
        @State private var lastName = ""
        
        var body: some View {
            Text("What are we doing today?")
            NavigationLink(destination: SecondScreen()) {
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
    
struct SecondScreen: View {
    @StateObject private var apiService = APIViewModel()
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
    @State private var isButtonTapeed: Bool = false
    @State private var apiResponse: String = ""
    @State private var weightMeasurementInput = ""
    @State private var name = "Frank Sinatra"
    @State private var dropSet = false
    @State private var darkMode = false
    @State private var cardioTypeSelected = ""
    //@State private var cardioTime = ""
    @State private var typeOfExerciseSelected = ""
    @State private var typeOfWorkoutSelected = ""
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
    
    
    
    let exerciseType = ["--Select--","Cardio","Strength Training"]
    let typeOfWorkout = ["--Select--","Traditional", "Super Set", "Drop Set"]
    let cardioWorkouts = ["Run", "Walk", "Ride","Swim", "Stair Stepper"]
    let muscles = ["Select","Back", "Biceps", "Legs", "Chest", "Triceps","Shoulders","Abs"]
    //let sets = ["1","2","3","4","5","6"]
    let sets = Array(1...6)
    //let reps = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20"]
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
                {
                    
                    
                    
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
                    //Toggle("Dark Mode", isOn: $darkMode)
                    //    .padding()
                    /*
                     Text("What are you doing today?")
                     Picker("", selection: $workoutTypeSelection) {
                     ForEach(workoutType, id: \.self) {
                     Text($0)
                     }
                     }
                     
                     if workoutTypeSelection == "Cardio" {
                     
                     Picker("", selection: $cardioTypeSelected) {
                     ForEach(cardioWorkouts,id: \.self) {
                     Text($0)
                     }
                     }
                     TextField("Time", text:$cardioTime)
                     
                     } else{
                     */
                    
                    /*Button("Get Muscles"){
                     isButtonTapeed = true
                     apiService.getMusclesData()
                     }
                     .overlay(
                     RoundedRectangle(cornerRadius: 5)
                     .stroke(Color.blue, lineWidth: 1)
                     )*/
                    //.border(Color.black, width: 1)
                    //if typeOfWorkoutSelected == "Traditional"
                   // {
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
                            )/*
                              TextField("Reps:", text: Binding(
                              get: { "\(repsInput)" },
                              set: {
                              if let newValue = Int($0) {
                              repsInput = newValue
                              }
                              }
                              ))*/
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
                        
                        //Submit workout via API call
                        Button("Submit Workout") {
                            isButtonTapeed = true
                            /*apiService.postData(name: <#T##String#>, muscles: <#T##String#>, Workout: <#T##String#>, Sets: <#T##Int#>, Reps: <#T##Int#>, Weight: <#T##Double#>)*/
                            self.currentDate = Date()
                            apiService.postData(name: name, muscles: musclesInput, Workout: workoutsInput, Sets: setsInput, Reps: repsInput, Weight: weightInput)
                            
                            
                        }
                        .padding()
                        .background(Color.black)
                        .shadow(color: .gray, radius: 3, x: 0, y: 2)
                        .border(Color.blue, width: 2)
                        
                        if let responseData = apiService.responseData {
                            // Display data from the API response
                        }
                        
                        if isButtonTapeed{
                            /*Text("Muscle: \(musclesInput),Workout: \(workoutsInput), Sets: \(setsInput), Reps: \(repsInput), Weight: \(weightInput)")
                             .font(.title)
                             .padding()
                             */
                            if($setsInput.wrappedValue > 0 && $repsInput.wrappedValue > 0 && $weightInput.wrappedValue > 0.0){
                                let results3 = (Double($setsInput.wrappedValue) * Double($repsInput.wrappedValue) * $weightInput.wrappedValue)
                                
                                Text("Weight moved this Workout \(String(format: "%.2f", results3)) \(weightMeasurementInput)")
                            }
                            
                            /* let Data1 = ("namesParam" + " : " + "Diego Alzugaray" + "," + "musclesParam" + " : " +  musclesInput + "," + "WorkoutsParam" + " : " + workoutsInput + "," + "SetsParam" + " : " + setsInput + "," + "RepsParam" + " : " +  repsInput + "," +  "WeightParam" +  " : " + "," + weightInput)
                             var muscleSelected = musclesInput
                             var workoutSelected = workoutsInput
                             var setsWritten = setsInput
                             var repsWritten = repsInput
                             var weighWritten = weightInput
                             let jsonData = JSONSerialization.data(withJSONObject: ["key": Data1])
                             apiService.postData()*/
                            
                        }
                        
                        //}
                        /*else if typeOfWorkoutSelected == "Drop Set" {
                         
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
                         
                         
                         Text("Add sets of dropset done here" )
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
                         
                         Text("Lbs or KGs?" )
                         .padding(.top,10)
                         Picker("Select Weight Measurement", selection: $weightMeasurementInput) {
                         ForEach(weightMeasurement, id: \.self) {
                         Text($0)
                         }
                         }
                         .pickerStyle(.menu)
                         
                         //TextField("0",text: $setsInput1)
                         //    .textFieldStyle(RoundedBorderTextFieldStyle())
                         
                         }
                         
                         Text("Add dropset weights lifted here" )
                         .padding(.top,10)
                         
                         HStack {
                         Text("6-8 reps: ")
                         .foregroundColor(.blue) // Customize label color if needed
                         .font(.headline)
                         TextField("0",text: $repsInput1)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         }
                         
                         HStack {
                         Text("10-12 reps: ")
                         .foregroundColor(.blue) // Customize label color if needed
                         .font(.headline)
                         TextField("0",text: $repsInput2)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         }
                         HStack {
                         Text("12-15 reps: ")
                         .foregroundColor(.blue) // Customize label color if needed
                         .font(.headline)
                         TextField("0",text: $repsInput3)
                         .textFieldStyle(RoundedBorderTextFieldStyle())
                         }
                         //Weight measurement picklist
                         /*Text("Lbs or Kgs?" )
                          .padding(.top,10)
                          Picker("Select Weight Measurement", selection: $weightMeasurementInput) {
                          ForEach(weightMeasurement, id: \.self) {
                          Text($0)
                          }
                          }
                          .pickerStyle(SegmentedPickerStyle())
                          //.padding()
                          */
                         //Submit workout via API call
                         Button("Submit Workout") {
                         isButtonTapeed = true
                         /*apiService.postData(name: <#T##String#>, muscles: <#T##String#>, Workout: <#T##String#>, Sets: <#T##Int#>, Reps: <#T##Int#>, Weight: <#T##Double#>)*/
                         
                         apiService.postData(name: name, muscles: musclesInput, Workout: workoutsInput, Sets: setsInput, Reps: repsInput, Weight: weightInput)
                         
                         
                         }
                         .padding()
                         .background(Color.black)
                         .shadow(color: .gray, radius: 3, x: 0, y: 2)
                         .border(Color.blue, width: 2)
                         
                         }
                         else if typeOfWorkoutSelected == "Super Set" {
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
                         /*TextField("Sets: ", text: Binding(
                          get: { "\(setsInput)" },
                          set: {
                          if let newValue = Int($0) {
                          setsInput = newValue
                          }
                          }
                          ))*/
                         //text: $setsInput)
                         .padding()
                         //} ( Removing the closing of this HStack )
                         
                         //Reps textbox
                         // HStack { ( Removing the Opening of this HStack )
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
                         )/*
                           TextField("Reps:", text: Binding(
                           get: { "\(repsInput)" },
                           set: {
                           if let newValue = Int($0) {
                           repsInput = newValue
                           }
                           }
                           ))*/
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
                         }
                         
                         //Submit workout via API call
                         Button("Submit Workout") {
                         isButtonTapeed = true
                         /*apiService.postData(name: <#T##String#>, muscles: <#T##String#>, Workout: <#T##String#>, Sets: <#T##Int#>, Reps: <#T##Int#>, Weight: <#T##Double#>)*/
                         
                         apiService.postData(name: name, muscles: musclesInput, Workout: workoutsInput, Sets: setsInput, Reps: repsInput, Weight: weightInput)
                         
                         
                         }
                         .padding()
                         .background(Color.black)
                         .shadow(color: .gray, radius: 3, x: 0, y: 2)
                         .border(Color.blue, width: 2)
                         
                         if let responseData = apiService.responseData {
                         // Display data from the API response
                         }
                         
                         if isButtonTapeed{
                         /*Text("Muscle: \(musclesInput),Workout: \(workoutsInput), Sets: \(setsInput), Reps: \(repsInput), Weight: \(weightInput)")
                          .font(.title)
                          .padding()
                          */
                         if($setsInput.wrappedValue > 0 && $repsInput.wrappedValue > 0 && $weightInput.wrappedValue > 0.0){
                         let results3 = (Double($setsInput.wrappedValue) * Double($repsInput.wrappedValue) * $weightInput.wrappedValue)
                         
                         Text("Weight moved this Workout \(String(format: "%.2f", results3)) \(weightMeasurementInput)")
                         }
                         
                         /* let Data1 = ("namesParam" + " : " + "Diego Alzugaray" + "," + "musclesParam" + " : " +  musclesInput + "," + "WorkoutsParam" + " : " + workoutsInput + "," + "SetsParam" + " : " + setsInput + "," + "RepsParam" + " : " +  repsInput + "," +  "WeightParam" +  " : " + "," + weightInput)
                          var muscleSelected = musclesInput
                          var workoutSelected = workoutsInput
                          var setsWritten = setsInput
                          var repsWritten = repsInput
                          var weighWritten = weightInput
                          let jsonData = JSONSerialization.data(withJSONObject: ["key": Data1])
                          apiService.postData()*/
                         
                         }
                         }*/
                        //  }
                }
                        else if typeOfExerciseSelected == "Cardio" {
                            Text("Workout")
                            Picker("Select Exercise", selection: $cardioWorkoutsSelection)
                            {
                                ForEach(cardioWorkouts, id: \.self) {
                                    Text($0)
                                }
                            }
                            Text("Distance")
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
                            }.padding(.horizontal)
                            
                            
                            
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
                            }.padding(.horizontal)
                            
                            
                        }
                    }
                    
                }
            }
        }
    

        
        
        
        struct ContentView_Previews: PreviewProvider {
            static var previews: some View {
                ContentView()
            }
            
        }
        /*struct LoginScreen: View {
         var body: some View {
         VStack {
         Text("This is the Second Screen!")
         .padding()
         
         /* NavigationLink(destination: ThirdScreen()) {
          Text("Go to Third Screen")
          .padding()
          .background(Color.green)
          .foregroundColor(.white)
          .cornerRadius(10)
          }*/
         }
         .navigationTitle("Second Screen")
         }
         }*/
        

