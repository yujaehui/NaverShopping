//
//  SearchView.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import SwiftUI

struct SearchView: View {
    @State private var query = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("Search")
            .searchable(text: $query, prompt: "Search for product...")
            .onSubmit(of: .search) { isSearching.toggle() }
            .sheet(isPresented: $isSearching) { ShoppingView(query: query) }
        }
    }
}

#Preview {
    SearchView()
}
