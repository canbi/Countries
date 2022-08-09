//
//  FullWidthButton.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import SwiftUI

struct FullWidthButton<Content: View>: View {
    @ViewBuilder var content: Content
    var action: () -> Void
    var color: Color
    
    var body: some View {
        Button {
            action()
        } label: {
            content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(color, lineWidth: 2)
            )
        }
        .tint(.primary)
        .contentShape(Rectangle())
    }
}
