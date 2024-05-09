//
//  ShoppingViewModel.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import Foundation
import Combine

class ShoppingViewModel: ViewModelType {
    
    var cancellables = Set<AnyCancellable>()
    
    var input = Input()
    @Published var output = Output()
    
    private var currentPage = 1
    private var isFetching = false
    
    init() {
        transform()
    }
}

extension ShoppingViewModel {
    struct Input {
        var onSubmit = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var items: [Item] = []
    }
    
    func transform() {
        input.onSubmit
            .sink { [weak self] query in
                guard let self = self else { return }
                Task {
                    try? await self.fetchShopping(query: query, start: self.currentPage)
                }
            }.store(in: &cancellables)
    }
    
    func fetchShopping(query: String, start: Int) async throws {
        guard !isFetching else { return } // 이미 요청 중인 경우 무시
        isFetching = true // 요청 중으로 표시
        
        do {
            let items = try await Network.shared.requestShoppingAPI(query: query, start: start)
            DispatchQueue.main.async {
                if start == 1 { // 첫 페이지인 경우 기존 아이템을 대체
                    self.output.items = items
                } else { // 새 페이지인 경우 기존 아이템에 추가
                    self.output.items.append(contentsOf: items)
                }
                self.isFetching = false // 요청 완료
                self.currentPage += 10 // 다음 페이지 번호 증가
            }
        }
        catch {
            DispatchQueue.main.async {
                self.output.items = []
                self.isFetching = false
            }
        }
    }
}
