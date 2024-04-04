//
//  String+Extension.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/22.
//

import Foundation

extension String {
    func formattedNumber() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        guard let number = Int(self) else {
            return nil // 숫자로 변환할 수 없는 경우 nil 반환
        }
        
        return formatter.string(from: NSNumber(value: number))
    }
    
    func containsSpecialCharacters() -> Bool {
        // 특수 문자가 포함되어 있는지 여부를 정규 표현식으로 검사
        let regex = ".*[$#%@]"
        return self.range(of: regex, options: .regularExpression) != nil
    }
    
    func containsNumbers() -> Bool {
        // 숫자가 포함되어 있는지 여부를 정규 표현식으로 검사
        let regex = ".*[0-9].*"
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
