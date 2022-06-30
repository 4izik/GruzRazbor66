//
//  NSErrorExtension.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 30.06.2022.
//

import Foundation

extension NSError {
    static func makeEror(description: String, code: Int = -1) -> NSError {
        return NSError(domain: "", code: code,
                       userInfo: [NSLocalizedDescriptionKey: description])
    }
}
