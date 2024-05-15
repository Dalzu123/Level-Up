//
//  Create_Account.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//
import SwiftUI
import Combine
import Foundation

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
