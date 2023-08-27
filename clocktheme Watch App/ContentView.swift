//
//  ContentView.swift
//  clocktheme Watch App
//
//  Created by unaivan on 26/08/23.
//

import SwiftUI

enum ContentViewStyle: Int, CaseIterable {
    case styleOne, styleTwo, styleThree
}

struct ContentView: View {
    @State private var currentPage = ContentViewStyle.styleOne
    
    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(ContentViewStyle.allCases, id: \.self) { style in
                getPageView(for: style)
                    .tag(style)
            }
        }.edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .gesture(
            DragGesture(minimumDistance: 50)
                .onChanged { gesture in
                    let translation = gesture.translation.width
                    if translation < 0 {
                        // Swiped left
                        withAnimation {
                            switchToNextStyle()
                        }
                    } else if translation > 0 {
                        // Swiped right
                        withAnimation {
                            switchToPreviousStyle()
                        }
                    }
                }
        ).edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true)
    }
    
    private func switchToNextStyle() {
        currentPage = ContentViewStyle(rawValue: (currentPage.rawValue + 1) % ContentViewStyle.allCases.count)!
    }
    
    private func switchToPreviousStyle() {
        currentPage = ContentViewStyle(rawValue: (currentPage.rawValue - 1 + ContentViewStyle.allCases.count) % ContentViewStyle.allCases.count)!
    }
    
    @ViewBuilder
    private func getPageView(for style: ContentViewStyle) -> some View {
        switch style {
            case .styleOne:
                StyleOne()
            case .styleTwo:
                StyleTwo()
            case .styleThree:
                StyleThree()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
