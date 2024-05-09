//
//  ShoppingView.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import SwiftUI

struct ShoppingView: View {
    let query: String
    
    @StateObject var viewModel = ShoppingViewModel()
    
    var columns: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.output.items, id: \.self) { item in
                        ShoppingItemView(item: item)
                            .onAppear {
                                if item == viewModel.output.items.last {
                                    viewModel.input.onSubmit.send(query)
                                }
                            }
                    }
                }
            }
            .navigationTitle("Shopping")
            .task {
                viewModel.input.onSubmit.send(query)
            }
        }
    }
}
