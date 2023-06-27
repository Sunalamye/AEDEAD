//
//  File.swift
//
//
//  Created by Suoie on 2023/6/22.
//

import Foundation
import CommonCrypto

public
class AESEAD {
    
    ///AES 解碼失敗
    public enum DecryptionError: Error {
        case dataEncodingFailed
        case decryptionFailed
        case stringConversionFailed
        case unescapedStringFailed
        case dataConversionFailed
        case jsonDecodingFailed
        case missingKey
    }
    
    public static let shared = AESEAD()
    
    var key: String?
    var iv: String?
    
    private init() {}
    
    public func setKeyAndIV(key: String,iv: String?) {
        self.key = key
        self.iv = iv
    }
    
    func encryptWithAES(input: String) throws -> String? {
        guard let key = key else {
            throw DecryptionError.missingKey
        }
        guard let data = input.data(using: .utf8),
              let encryptedData = data.aes(operation: CCOperation(kCCEncrypt), key: key, iv: iv ?? "") else {
            return nil
        }
        let baseStr = encryptedData.base64EncodedString()
        return baseStr
    }
    
    func decryptWithAES(input: String) throws -> String {
        guard let key = key else {
            throw DecryptionError.missingKey
        }
        guard let data = Data(base64Encoded: input) else {
            throw DecryptionError.dataEncodingFailed
        }
        
        guard let decryptedData = data.aes(operation: CCOperation(kCCDecrypt), key: key, iv: iv ?? "") else {
            throw DecryptionError.decryptionFailed
        }
        
        guard let decryptedStr = String(data: decryptedData, encoding: .utf8) else {
            throw DecryptionError.stringConversionFailed
        }
        
        guard let unescapedStr = decryptedStr.applyingTransform(.init("Any-Hex"), reverse: true) else {
            throw DecryptionError.unescapedStringFailed
        }
        
        return unescapedStr
    }
    
    func decryptJsonWithAES<T: Codable>(input: String) throws -> T {
        let unescapedStr = try decryptWithAES(input: input)
        guard let data = unescapedStr.data(using: .utf8) else {
            throw DecryptionError.dataConversionFailed
        }
        let config = try JSONDecoder().decode(T.self, from: data)
        return config
    }
}

