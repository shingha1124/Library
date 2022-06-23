//
//  BaseVerification.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

enum ValidateError: Error {
    case isEmpty
    case userId
    case lengthLimited
    case noCapitalLetters
    case noNumber
    case noSpecialCharacters
    case notMatch
    case email
    case phoneNumber
    
    var message: String {
        switch self {
        case .isEmpty:
            return ""
        case .userId:
            return "5~20자의 영문 소문자, 숫자와 특수기호(_)(-) 만 사용 가능합니다."
        case .lengthLimited:
            return "8자 이상 16자 이하로 입력해주세요."
        case .noCapitalLetters:
            return "영문 대문자를 최소 1자 이상 포함해주세요."
        case .noNumber:
            return "숫자를 최소 1자 이상 포함해주세요."
        case .noSpecialCharacters:
            return "특수문자를 최소 1자 이상 포함해주세요."
        case .notMatch:
            return "비밀번호가 일치하지 않습니다."
        case .email:
            return "이메일 주소를 다시 확인해주세요."
        case .phoneNumber:
            return "형식에 맞지 않는 번호입니다."
        }
    }
}

protocol BaseValidate {
    static func verification(text: String) -> ValidateError?
}

extension BaseValidate {
    //format에 있는 값만 사용하고 있는지?
    static func validatePredicate(_ text: String, format: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", format)
        return predicate.evaluate(with: text)
    }
    
    //pattern에 있는 값을 사용했는지?
    static func vaildateRegex(_ text: String, pattern: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: pattern) else {
            return false
        }
        
        let results = regex.matches(in: text, range: NSRange(text.startIndex..., in: text))
        return !results.isEmpty
    }
}
