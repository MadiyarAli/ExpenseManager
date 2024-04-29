//
//  CardView.swift
//  ExpenseManager
//
//  Created by Madiyar Ali on 29.04.2024.
//

import SwiftUI

struct CardView: View {
    var income: Double
    var expense: Double
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(.background)
            
            VStack(spacing: 0){
                HStack(spacing: 12){
                    Text("\(currencyString(income - expense))")
                        .font(.title.bold())
                }
                .padding(.bottom, 25)
                
                HStack(spacing: 0) {
                    ForEach(Category.allCases, id: \.rawValue) { category in
                        
                        HStack(spacing: 10){
                            
                            VStack(alignment: .leading, spacing: 4){
                                Text(category.rawValue)
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                                
                                Text(currencyString(category == .income ? income : expense, allowedDigits: 0))
                                    .font(.callout)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.primary)
                            }
                            if category == .income {
                                Spacer(minLength: 10)
                            }
                        }
                    }
                }
            }
            .padding([.horizontal, .bottom], 25)
            .padding(.top, 15)
        }
    }
}

