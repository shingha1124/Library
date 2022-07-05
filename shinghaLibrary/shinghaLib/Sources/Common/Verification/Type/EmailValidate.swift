//
//  EmailVerification.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

enum EmailValidate: BaseValidate {
    static func verification(text: String) -> ValidateError? {
        if validatePredicate(text, format: "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}$") {
            return nil
        }
        return .email
    }
}
