//
//  signupView.swift
//  kidsZoo
//
//  Created by hachemibtb on 26/7/2026.
//

import SwiftUI

struct signupView: View {
    // proeprty
  @State  var userName:String = ""
    @State  var childAge:String = ""
    @State  var country:String = ""
    @State  var password:String = ""
    @AppStorage("Paging") var paging:Int = 0
    @AppStorage("userName") var accountUserName:String = ""
    @AppStorage("userPassword") var accountPassword = ""

    var body: some View {
        ZStack{
            Image("background1")
                .resizable()
                .scaledToFill()
               
            VStack{
                Spacer().padding()
          
                TextField("UserName", text: $userName)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(15)
                    .padding(.horizontal,30)
                    .padding(.vertical)
                TextField("Child age", text: $childAge)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(15)
                    .padding(.horizontal,30)
                    .padding(.vertical)
                TextField("Country", text: $country)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(15)
                    .padding(.horizontal,30)
                    .padding(.vertical)
                    
                TextField("Password", text: $password)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(15)
                    .padding(.horizontal,30)
            
                Button {
                    if userName != "" && password != "" {
                        accountUserName = userName
                        accountPassword = password
                        paging = 0
                    }
                } label: {
               Text("Sign up")
                        .font(.title)
                        .fontWeight(.bold)
                } .foregroundColor(.white)
                    .frame(width: 250,height: 50,alignment: .center)
                    .background(Color("4thColor"))
                    .cornerRadius(15)
                    .padding(.top,20)
                HStack{
                    Text("Already have an account?")
                      
                    Button {
                        print("go to Login")
                        paging = 0
                    } label: {
                     Text("Login")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(Color("4thColor"))
                        
                    }

                }.padding(.top,20)
               
                
                Image("background2")
                    .resizable()
                    .scaledToFit()
           
              

            }
           
               
        }.edgesIgnoringSafeArea(.all)
    }
    }


#Preview {
    signupView()
}
