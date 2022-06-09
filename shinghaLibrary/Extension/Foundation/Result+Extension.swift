//
//  Result+Extension.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/09.
//

import Foundation

extension Result {
    var value: Success? {
        guard case .success(let value) = self else {
            return nil
        }
        return value
    }

    var error: Failure? {
        guard case .failure(let error) = self else {
            return nil
        }
        return error
    }

    var isSuccess: Bool {
        if case .success = self {
            return true
        } else {
            return false
        }
    }

    var isFailure: Bool {
        !isSuccess
    }
}
