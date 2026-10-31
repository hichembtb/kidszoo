//
//  loginView.swift
//  kidsZoo
//
//  Created by hachemibtb on 26/7/2026.
//

import SwiftUI

struct loginView: View {
    // proeprty
  @State  var userName:String = ""
  @State  var password:String = ""
    @AppStorage("Paging") var paging:Int = 0
    @AppStorage("userName") var accountUserName:String = ""
    @AppStorage("userPassword") var accountPassword = ""
    
    //body
    var body: some View {
        ZStack{
            Image("background1")
                .resizable()
                .scaledToFill()
            
            VStack{
                Spacer()
                TextField("UserName", text: $userName)
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
                    .textContentType(UITextContentType.password)
                HStack{
                    Spacer()
                    Text("Forgot password?")
                        .padding(.top,20)
                        .padding(.trailing,20)
                }
                Button {
                    if userName != "" && password != ""  {
                        if userName == accountUserName && password == accountPassword {
                            paging = 3
                        } else {
                            print("account does not exist or wrong credentials")
                        }
                    } else {
                        print("please fill the fields")
                    }
                 
        
               
               
                } label: {
               Text("Go")
                        .font(.title)
                        .fontWeight(.bold)
                } .foregroundColor(.white)
                    .frame(width: 250,height: 50,alignment: .center)
                    .background(Color("4thColor"))
                    .cornerRadius(15)
                    .padding(.top,20)
                HStack{
                    Text("Dont have an account yet ? ")
                      
                    Button {
                        print("go to Sign up",paging)
                        paging = 1
                    } label: {
                     Text("Sign up")
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
    loginView()
}
