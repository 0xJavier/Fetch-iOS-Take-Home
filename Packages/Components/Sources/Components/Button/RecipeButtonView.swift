//
//  RecipeButtonView.swift
//  Components
//
//  Created by Javier Munoz on 1/8/25.
//

import SwiftUI

public struct RecipeButtonView: View {
    let title: String
    let tintColor: Color
    let action: () -> Void
    
    public init(title: String, tintColor: Color = .blue, action: @escaping () -> Void) {
        self.title = title
        self.tintColor = tintColor
        self.action = action
    }
    
    public var body: some View {
        Button(action: {action()}) {
            Text(title)
                .frame(maxWidth: .infinity)
        }
        .buttonStyle(.bordered)
        .tint(tintColor)
        .controlSize(.large)
    }
}

#Preview {
    RecipeButtonView(title: "Fetch Recipe Button", action: {})
}
