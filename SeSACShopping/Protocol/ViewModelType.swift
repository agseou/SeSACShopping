//
//  ViewModelType.swift
//  SeSACShopping
//
//  Created by eunseou on 4/13/24.
//

import Foundation
import RxSwift

protocol commonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
    var disposeBag: DisposeBag { get set }
    
}
