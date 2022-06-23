//
//  PasswordVaildate.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

class PasswordVaildate: BaseValidate {
    static func verification(text: String) -> ValidateError? {
        if text.isEmpty {
            return .isEmpty
        }
        
        if validatePredicate(text, format: ".{8,16}") == false {
            return .lengthLimited
        }
        
        if vaildateRegex(text, pattern: "[A-Z]") == false {
            return .noCapitalLetters
        }
        
        if vaildateRegex(text, pattern: "[0-9]") == false {
            return .noNumber
        }
        
        if vaildateRegex(text, pattern: "[!@#$%^&*()_+=-]") == false {
            return .noSpecialCharacters
        }
        return nil
    }
}
