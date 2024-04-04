//
//  ProfileNameViewModel.swift
//  SeSACShopping
//
//  Created by eunseou on 4/3/24.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileNameViewModel {
    
    enum nickNameState: String {
        case none = "특수문자, 숫자 제외 2자이상 10자 미만으로 입력해주세요."
        case ok = "사용할 수 있는 닉네임이에요"
        case isCount = "2글자 이상 10글자 미만으로 설정해주세요"
        case isNumber = "닉네임에 숫자는 포함할 수 없어요"
        case isSpecial = "닉네임에 @,#,$,%는 포함할 수 없어요"
    }
    
    // input
    let name = PublishSubject<String>()
    
    // output
    var nameVaildateState = BehaviorSubject<nickNameState>(value: .none)
    let vaildateState = BehaviorSubject<Bool>(value: false)
    
    let disposeBag = DisposeBag()
    
    init() {
        
        name
            .withUnretained(self)
            .bind { owner, value in
                if value.isEmpty {
                    owner.nameVaildateState.onNext(.none)
                    owner.vaildateState.onNext(false)
                } else if value.count > 10 || value.count < 2 {
                    owner.nameVaildateState.onNext(.isCount)
                    owner.vaildateState.onNext(false)
                } else if value.containsSpecialCharacters() {
                    owner.nameVaildateState.onNext(.isSpecial)
                    owner.vaildateState.onNext(false)
                } else if value.containsNumbers() {
                    owner.nameVaildateState.onNext(.isNumber)
                    owner.vaildateState.onNext(false)
                } else {
                    owner.nameVaildateState.onNext(.ok)
                    owner.vaildateState.onNext(true)
                }
            }
            .disposed(by: disposeBag)
        
    }
}
