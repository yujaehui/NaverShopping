//
//  ShoppingItemView.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import SwiftUI

struct ShoppingItemView: View {
    
    let item: Item
    
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 10) {
            AsyncImage(url: URL(string: item.image)) { data in
                switch data {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 100)
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .background(.gray)
                        .clipShape(.rect(cornerRadius: 10))
                case .failure( _):
                    Image(systemName: "slash.circle")
                        .resizable()
                        .aspectRatio(1, contentMode: .fill)
                        .clipShape(.rect(cornerRadius: 10))
                @unknown default:
                    Text("...")
                }
            }
            Text(item.brand)
                .font(.caption)
                .foregroundStyle(.gray)
                .lineLimit(1)
            Text(Helpers.shared.removeHTMLTags(from: item.title))
                .font(.callout)
                .fontWeight(.bold)
                .lineLimit(2)
            Text(Helpers.shared.formatCurrency(item.lprice))
                .font(.callout)
                .lineLimit(1)
        }
        .padding()
    }
}
