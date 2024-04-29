//
//  Recents.swift
//  ExpenseManager
//
//  Created by Madiyar Ali on 29.04.2024.
//

import SwiftUI
import SwiftData

struct Recents: View {
    // View Properties
    @State private var selectedCategory: Category = .expense
    
    @Namespace private var animation
    @Query(sort: [SortDescriptor(\Transaction.dateAdded, order: .reverse)], animation: .snappy) private var transactions: [Transaction]
    var body: some View {
        GeometryReader{
            let size = $0.size
            
            NavigationStack{
                ScrollView(.vertical){
                    LazyVStack(spacing: 10, pinnedViews: [.sectionHeaders]){
                        Section{
                            CardView(
                                income: total(transactions, category: .income),
                                expense: total(transactions, category: .expense)
                            )
                            
                            CustomSegmentedControl()
                                .padding(.bottom, 10)
                            
                            ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                                NavigationLink(value: transaction) {
                                    TransactionCardView(transaction: transaction)
                                }
                                .buttonStyle(.plain)
                            }
                        } header:{
                            HeaderView(size)
                        }
                    }
                    .padding(15)
                }
                .background(.gray.opacity(0.15))
                .navigationDestination(for: Transaction.self) { transaction in
                    TransactionView(editTransaction: transaction)
                }
            }
        }
    }
    
    @ViewBuilder
    func HeaderView(_ size: CGSize ) -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome!")
                    .font(.title.bold())
            })
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            NavigationLink {
                TransactionView()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45, height: 45)
                    .background(appTint.gradient, in: .circle)
                    .contentShape(.circle )
            }
        }
        
        .padding(.bottom, 5)
        .background{
            VStack(spacing: 0, content: {
                Rectangle()
                    .fill(.ultraThinMaterial)
                Divider()
            })
            .padding(.horizontal, -15)
            .padding(.top, -(safeArea.top + 15))
        }
    }
    
    @ViewBuilder
    func CustomSegmentedControl() -> some View {
        HStack(spacing: 0) {
            ForEach(Category.allCases, id: \.rawValue) { category in
                Text(category.rawValue)
                    .hSpacing()
                    .padding(.vertical, 10)
                    .background{
                        if category == selectedCategory {
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy) {
                            selectedCategory = category
                        }
                    }
            }
        }
        .background(.gray.opacity(0.15), in: .capsule)
        .padding(.top, 5)
    }
}
