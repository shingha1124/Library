//
//  UserIdVelidate.swift
//  Signup
//
//  Created by seongha shin on 2022/03/31.
//

import Foundation

class UserIdVelidate: BaseValidate {
    static func verification(text: String) -> ValidateError? {
        if text.isEmpty {
            return .isEmpty
        }
        if validatePredicate(text, format: "[A-Za-z0-9_-]{5,20}") {
            return nil
        }
        return .userId
    }
}
