//
//  Login.swift
//  Level-Up
//
//  Created by Diego Alzugaray on 5/12/24.
//
import SwiftUI
import Combine
import Foundation

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
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
                    NavigationLink("Login") {
                    }
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

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
    
}

