//
//  ProfileNameViewModel.swift
//  SeSACShopping
//
//  Created by eunseou on 4/3/24.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileNameViewModel: commonViewModel {
    
    enum nickNameState: String {
        case none = "특수문자, 숫자 제외 2자이상 10자 미만으로 입력해주세요."
        case ok = "사용할 수 있는 닉네임이에요"
        case isCount = "2글자 이상 10글자 미만으로 설정해주세요"
        case isNumber = "닉네임에 숫자는 포함할 수 없어요"
        case isSpecial = "닉네임에 @,#,$,%는 포함할 수 없어요"
    }
    
    
    struct Input {
        let name: Observable<String>
    }
    
    struct Output {
        var nameVaildateState: Driver<nickNameState>
        let vaildateState: Driver<Bool>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let nicknameValid = BehaviorRelay(value: false)
        let nicknameValidState = BehaviorRelay<nickNameState>(value: .none)
        
        input.name
            .withUnretained(self)
            .bind { owner, value in
                if value.isEmpty {
                    nicknameValid.accept(false)
                    nicknameValidState.accept(.none)
                } else if value.count > 10 || value.count < 2 {
                    nicknameValid.accept(false)
                    nicknameValidState.accept(.isCount)
                } else if value.containsSpecialCharacters() {
                    nicknameValid.accept(false)
                    nicknameValidState.accept(.isSpecial)
                } else if value.containsNumbers() {
                    nicknameValid.accept(false)
                    nicknameValidState.accept(.isNumber)
                } else {
                    nicknameValid.accept(true)
                    nicknameValidState.accept(.ok)
                }
            }
            .disposed(by: disposeBag)
        
        return Output(nameVaildateState: nicknameValidState.asDriver(), vaildateState: nicknameValid.asDriver())
    }
}
