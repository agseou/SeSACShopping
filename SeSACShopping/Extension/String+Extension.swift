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
}
