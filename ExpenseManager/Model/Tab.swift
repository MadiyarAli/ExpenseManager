//
//  Tab.swift
//  ExpenseManager
//
//  Created by Madiyar Ali on 29.04.2024.
//

import SwiftUI

enum Tab: String {
    case recents = "Recents"
    case charts = "Charts"
    
    @ViewBuilder
    var tabContent: some View {
        switch self {
        case .recents:
            Image(systemName: "calendar")
            Text(self.rawValue)
        case .charts:
            Image(systemName: "chart.bar.xaxis")
            Text(self.rawValue)
        }
    }
}

