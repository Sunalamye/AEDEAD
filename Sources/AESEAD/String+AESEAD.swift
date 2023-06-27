//
//  File.swift
//  
//
//  Created by Suoie on 2023/6/22.
//


import Foundation

extension String{
    
    /// Encrypts the string using AES encryption.
    /// - Returns: The encrypted string.
    /// - Throws: An error if the encryption fails.
    public func encryptWithAES() throws -> String?{
        try AESEAD.shared.encryptWithAES(input: self)
    }
    
    /// Decrypts the JSON string using AES encryption.
    /// - Returns: The decrypted object of type T.
    /// - Throws: An error if the decryption fails.
    public func decryptJsonWithAES<T:Codable>() throws -> T{
        try AESEAD.shared.decryptJsonWithAES(input: self)
    }
    
    /// Decrypts the string using AES encryption.
    /// - Returns: The decrypted string.
    /// - Throws: An error if the decryption fails.
    public func decryptWithAES() throws -> String{
        try AESEAD.shared.decryptWithAES(input: self)
    }
}

extension NSString {
    
    /// Encrypts the string using AES encryption.
    /// - Returns: The encrypted string.
    /// - Throws: An error if the encryption fails.
    public func encryptWithAES() throws -> String?{
        try AESEAD.shared.encryptWithAES(input: self as String)
    }
    
    /// Decrypts the JSON string using AES encryption.
    /// - Returns: The decrypted object of type T.
    /// - Throws: An error if the decryption fails.
    public func decryptJsonWithAES<T:Codable>() throws -> T{
        try AESEAD.shared.decryptJsonWithAES(input: self as String)
    }
    
    /// Decrypts the string using AES encryption.
    /// - Returns: The decrypted string.
    /// - Throws: An error if the decryption fails.
    public func decryptWithAES() throws -> String{
        try AESEAD.shared.decryptWithAES(input: self as String)
    }
}






