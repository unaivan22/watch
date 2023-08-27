//
//  StyleTwo.swift
//  clocktheme Watch App
//
//  Created by unaivan on 26/08/23.
//
import SwiftUI

struct StyleTwo: View {
    @State private var currentMinutes: String = ""
    @State private var currentHours: String = ""
    @State private var currentSeconds: String = ""
    
    @State private var chosenColor: Color = .green
    @State private var showModal = false
    
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
    
    let secFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "ss"
        return formatter
    }()
    
        
        var body: some View {
            VStack(spacing: -30){
                HStack{
                    Text(currentHours)
                        .font(.custom("MoiraiOne-Regular", size: 100))
                        .foregroundColor(chosenColor)
                }
                .onTapGesture {
                    showModal = true
                }
                
                HStack{
                    Text(currentMinutes)
                        .font(.custom("MoiraiOne-Regular", size: 40))
                        .foregroundColor(.white)
                    Text(":")
                        .font(.system(size: 12, weight: .bold, design: .default))
                        .foregroundColor(.green)
                    Text(currentSeconds)
                        .font(.custom("MoiraiOne-Regular", size: 40))
                        .foregroundColor(.white)
                }
            }
            .onAppear {
                // Start a timer to update the seconds every second
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    currentMinutes = minFormatter.string(from: Date())
                    currentHours = hourFormatter.string(from: Date())
                    currentSeconds = secFormatter.string(from: Date())
                }
            }
            .sheet(isPresented: $showModal) {
                ColorPickerModalView(selectedColor: $chosenColor, showModal: $showModal)
            }
        }
}
