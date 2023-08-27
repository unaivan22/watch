//
//  StyleOne.swift
//  clocktheme Watch App
//
//  Created by unaivan on 26/08/23.
//

import SwiftUI

struct StyleOne: View {
    @State private var currentMinutes: String = ""
    @State private var currentHours: String = ""
    
    @State private var chosenColor: Color = .green
    @State private var showModal = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, \nMMM d"
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
    
    let dotColors: [Color] = [.green, .orange, .yellow]
    
    var body: some View {
        VStack(spacing: -50){
            HStack(spacing: 8){
                Text(currentHours)
                    .font(.custom("Oi-Regular", size: 72))
                    .foregroundColor(.white)
                Text("\(dateFormatter.string(from: Date()))")
                    .font(.system(size: 12, weight: .bold, design: .default))
                    .fontWeight(.bold)
                    .foregroundColor(chosenColor)
            }
            
            VStack{
                Text(currentMinutes)
                    .font(.custom("Oi-Regular", size: 72))
                    .foregroundColor(chosenColor)
            }.padding(.trailing, -50)
                .onTapGesture {
                    showModal = true
                }
            
            
        }.padding(.top, 20)
        .onAppear {
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


struct ColorPickerModalView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 6)
    let colors: [Color] = [.green, .orange, .yellow, .red, .white, .blue, .pink, .teal, .purple, .gray]
    @Binding var selectedColor: Color
    @Binding var showModal: Bool
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(colors, id: \.self) { color in
                    Button(action: {
                        selectedColor = color
                        showModal = false
                    }) {
                        Rectangle()
                            .foregroundColor(color)
                            .aspectRatio(1, contentMode: .fit)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}
