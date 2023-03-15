//
//  Extensions.swift
//  
//
//  Created by Loic D on 15/03/2023.
//

import SwiftUI

extension View {
    func scrollableVStack() -> some View {
        GeometryReader { geo in
            ScrollView(.vertical) {
                self.padding(.horizontal, 20).padding(.top, 20).padding(.bottom, 20).frame(minHeight: geo.size.height)
            }.frame(width: geo.size.width)
        }
    }
    
    func shadowed(radius: CGFloat = 4, y: CGFloat = 4) -> some View {
        self
            .shadow(color: Color("ShadowColor", bundle: Bundle.module), radius: radius, x: 0, y: y)
    }
}

extension Text {
    func title() -> some View {
        self
            .font(.title)
            .fontWeight(.bold)
    }
    
    func subtitle() -> some View {
        self
            .font(.subheadline)
            .fontWeight(.bold)
    }
    
    func text() -> some View {
        self
            .font(.subheadline)
    }
    
    func buttonLabel() -> some View {
        self
            .font(.title)
            .foregroundColor(.white)
            .padding(.horizontal, 15).padding(.vertical, 8)
            .background(Color.accentColor.cornerRadius(10))
            .shadowed()
            .padding(5)
    }
}
