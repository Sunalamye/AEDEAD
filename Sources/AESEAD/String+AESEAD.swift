//
//  File.swift
//  
//
//  Created by Suoie on 2023/6/22.
//

import Foundation

extension String{
    public func encryptWithAES() throws -> String?{
        try AESEAD.shared.encryptWithAES(input: self)
    }
    
    public func decryptJsonWithAES<T:Codable>() throws -> T{
        try AESEAD.shared.decryptJsonWithAES(input: self)
    }
    
    public func decryptWithAES() throws -> String{
        try AESEAD.shared.decryptWithAES(input: self)
    }
    
    
}
