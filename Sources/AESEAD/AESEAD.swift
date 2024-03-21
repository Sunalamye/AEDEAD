//
//  AESEAD.swift
//  MyLibrary
//
//  Created by Suoie on 2023/6/22.
//

import Foundation
import CommonCrypto

/// A class that provides AES encryption and decryption with AEAD.
public class AESEAD {

    
    /// AES decryption error types.
    public enum DecryptionError: Error {
        case dataEncodingFailed
        case decryptionFailed
        case stringConversionFailed
        case unescapedStringFailed
        case dataConversionFailed
        case jsonDecodingFailed
        case missingKey
    }
    
    /// Singleton instance of AESEAD.
    public static let shared = AESEAD()
    
    /// AES encryption and decryption key.
    var key: String?
    
    /// AES encryption and decryption iv.
    var iv: String?
    
    /// AES key size.
    var size: AESKeySize = .aes128
    
    private init() {}
    
    /// Set the AES encryption and decryption key and iv.
    ///
    /// - Parameters:
    ///   - key: The key used for AES encryption and decryption.
    ///   - iv: The iv used for AES encryption and decryption.
    public func setKeyAndIV(key: String, iv: String?) {
        self.key = key
        self.iv = iv
    }
    
    /// Set the AES key size.
    ///
    /// - Parameter size: The size of the AES key.
    public func setSize(size: AESKeySize) {
        self.size = size
    }
    
    /// Encrypts the input string using AES.
    ///
    /// - Parameter input: The string to be encrypted.
    /// - Returns: The encrypted string.
    /// - Throws: DecryptionError.missingKey if the key is not set, otherwise DecryptionError.dataEncodingFailed, DecryptionError.decryptionFailed, DecryptionError.stringConversionFailed, DecryptionError.unescapedStringFailed, or DecryptionError.dataConversionFailed.
    func encryptWithAES(input: String) throws -> String? {
        guard let key = key else {
            throw DecryptionError.missingKey
        }
        guard let data = input.data(using: .utf8),
              let encryptedData = data.aesCrypt(operation: CCOperation(kCCEncrypt), key: key, iv: iv, keySize: size) else {
            return nil
        }
        let baseStr = encryptedData.base64EncodedString()
        return baseStr
    }
    
    /// Decrypts the input string using AES.
    ///
    /// - Parameter input: The string to be decrypted.
    /// - Returns: The decrypted string.
    /// - Throws: DecryptionError.missingKey if the key is not set, otherwise DecryptionError.dataEncodingFailed, DecryptionError.decryptionFailed, DecryptionError.stringConversionFailed, DecryptionError.unescapedStringFailed, or DecryptionError.dataConversionFailed.
    func decryptWithAES(input: String) throws -> String {
        guard let key = key else {
            throw DecryptionError.missingKey
        }
        guard let data = Data(base64Encoded: input) else {
            throw DecryptionError.dataEncodingFailed
        }
        guard let decryptedData = data.aesCrypt(operation: CCOperation(kCCDecrypt), key: key, iv: iv, keySize: size) else {
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
    
    /// Decrypts the input string using AES and parses the result into the specified type.
    ///
    /// - Parameter input: The string to be decrypted.
    /// - Returns: The decrypted object of the specified type.
    /// - Throws: DecryptionError.missingKey if the key is not set, otherwise DecryptionError.dataEncodingFailed, DecryptionError.decryptionFailed, DecryptionError.stringConversionFailed, DecryptionError.unescapedStringFailed, DecryptionError.dataConversionFailed, or DecryptionError.jsonDecodingFailed.
    func decryptJsonWithAES<T: Codable>(input: String) throws -> T {
        let unescapedStr = try decryptWithAES(input: input)
        guard let data = unescapedStr.data(using: .utf8) else {
            throw DecryptionError.dataConversionFailed
        }
        let config = try JSONDecoder().decode(T.self, from: data)
        return config
    }
}
