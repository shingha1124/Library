//
//  NetworkRepository.swift
//  shinghaLib
//
//  Created by seongha shin on 2022/06/09.
//

import Foundation

class NetworkRepository<Target: BaseTarget> {
    let provider = Provider<Target>()
}
