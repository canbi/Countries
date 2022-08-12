//
//  CountryRow.swift
//  Countries
//
//  Created by Can Bi on 12.08.2022.
//

import SwiftUI

struct CountryRow: View {
    var action: () -> Void
    var favoriteAction: () -> Void
    var color: Color
    var countryName: String
    var isFavorited: Bool
    
    var body: some View {
        HStack {
            Button(action: action) {
                Group {
                    Text(countryName)
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                }
                .padding(.vertical, 12)
                .padding(.horizontal)
            }
            
            Button(action: favoriteAction){
                Image(systemName: isFavorited ? "heart.fill" : "heart")
                    .padding(.vertical, 12)
                    .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(color)
        )
        .tint(.primary)
        .contentShape(Rectangle())
    }
}
