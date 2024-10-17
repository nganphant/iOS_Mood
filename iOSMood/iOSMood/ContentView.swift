//
//  ContentView.swift
//  iOSMood
//
//  Created by Phan Thành Ngân on 2024/01/13.
//

import SwiftUI

struct ContentView: View {
    //add line 3
    @State private var heightText: String = ""
    @State private var weightText: String = ""
    @State private var bmiVal: Double = 0
    @State private var classification: String = ""
    
    var body: some View {
        
        VStack(){
            
            Text("BMI Calculator")
            TextField("Enter weight (in Kg)", text: $weightText)
                .textFieldStyle(.roundedBorder)
                .border(Color.black)
            TextField("Enter height (in meter)", text: $heightText)
                .textFieldStyle(.roundedBorder)
                .border(Color.black)
            
            Button(action: {
//                print("Input is \(weightText) and \(heightText)")
                guard let weight = Double(weightText) else { return }
                guard let height = Double(heightText) else { return }
                
                
                bmiVal = weight / (height * height);
                
                if bmiVal < 18.5 {
                    classification = "Too Gầy"
                } else {
                    classification = "Too Mập 2"
                }
            }, label: {
                Text("Go").padding(4)
            })
                .background(Color.blue)
                .foregroundColor(.white)
            
            Text("BMI: \(bmiVal, specifier: "%.1f"), \(classification)")
                .font(.title)
                .padding()
        }
        .padding()//apply default padding
    }
}

#Preview {
    ContentView()
}
