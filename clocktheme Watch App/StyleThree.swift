//
//  StyleThree.swift
//  clocktheme Watch App
//
//  Created by unaivan on 26/08/23.
//

import SwiftUI

struct StyleThree: View {
    @State private var currentMinutes: String = ""
    @State private var currentHours: String = ""
    
    @State private var chosenColor: Color = .green
    @State private var showModal = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, \nMMM d, \nyyyy"
        return formatter
    }()
    
    let hourFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        return formatter
    }()
    
    let minFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "mm"
        return formatter
    }()
    
    var body: some View {
        HStack{
            VStack(spacing: -150){
                Text(currentHours)
                    .font(.custom("ZenTokyoZoo-Regular", size: 190))
                    .foregroundColor(.white)
                HStack{
                    Text(currentMinutes)
                        .font(.custom("ZenTokyoZoo-Regular", size: 190))
                        .foregroundColor(chosenColor)
                }.onTapGesture {
                    showModal = true
                }
            }.padding(.leading, -15)
                .padding(.top, -50)
            
            VStack{
                Text("\(dateFormatter.string(from: Date()))")
                    .font(.system(size: 12, weight: .bold, design: .default))
                    .foregroundColor(chosenColor)
            }
        }
        .onAppear {
            // Start a timer to update the minutes every minute (60 seconds)
            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                currentMinutes = minFormatter.string(from: Date())
                currentHours = hourFormatter.string(from: Date())
            }
        }
        .sheet(isPresented: $showModal) {
            ColorPickerModalView(selectedColor: $chosenColor, showModal: $showModal)
        }
    }
}

