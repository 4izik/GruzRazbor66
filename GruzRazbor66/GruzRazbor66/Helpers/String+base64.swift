//
//  String+base64.swift
//  GruzRazbor66
//
//  Created by Михаил Бобров on 04.07.2022.
//

import Foundation

extension String {
    
    func decodeBase64() -> String? {
        guard let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    
    func encodeBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    
}
