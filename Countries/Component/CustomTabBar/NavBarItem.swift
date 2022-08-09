//
//  NavBarItem.swift
//  Countries
//
//  Created by Can Bi on 9.08.2022.
//

import Foundation
import SwiftUI

enum NavBarItem: Hashable {
    case home, saved
    
    var iconName: String {
        switch self {
        case .home: return "house"
        case .saved: return "heart.fill"
        }
    }
    
    var tabTitle: String {
        switch self {
        case .home: return " Home"
        case .saved: return " Saved"
        }
    }
    
    var tabColor: Color {
        switch self {
        case .home: return .blue
        case .saved: return .red
        }
    }
}
