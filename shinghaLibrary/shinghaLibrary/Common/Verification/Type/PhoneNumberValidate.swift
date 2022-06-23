//
//  PhoneNumberValidate.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

enum PhoneNumberValidate: BaseValidate {
    static func verification(text: String) -> ValidateError? {
        if validatePredicate(text, format: "^01([0-9])([0-9]{3,4})([0-9]{4})$") {
            return nil
        }
        return .phoneNumber
    }
}
