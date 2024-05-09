//
//  ViewModelType.swift
//  NaverShopping
//
//  Created by Jaehui Yu on 5/9/24.
//

import Foundation
import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    var cancellables: Set<AnyCancellable> { get set }
    associatedtype Input
    associatedtype Output
    var input: Input { get set }
    var output: Output { get set }
    func transform()
}
