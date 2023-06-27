//
//  File.swift
//  
//
//  Created by Suoie on 2023/6/22.
//

import Foundation

import CommonCrypto

public enum aesSize:Int{
    case aes128,aes192,aes256
       
       var size:Int{
           switch self{
           case .aes128:kCCKeySizeAES128
           case .aes192:kCCKeySizeAES192
           case .aes256:kCCKeySizeAES256
           }
       }
   }
extension Data {
    
    func aes(operation: CCOperation, key: String, iv: String,size:aesSize = .aes128) -> Data? {
        let keyLength = size_t(size.size)
        var keyBytes = [CChar](repeating: 0, count: keyLength + 1)
        _ = key.getCString(&keyBytes, maxLength: keyLength + 1, encoding: .utf8)

        let ivLength = size_t(size.size)
        var ivBytes = [CChar](repeating: 0, count: ivLength + 1)
        _ = iv.getCString(&ivBytes, maxLength: ivLength + 1, encoding: .utf8)

        let dataLength = Int(self.count)
        let dataBytes = UnsafeRawPointer((self as NSData).bytes).assumingMemoryBound(to: UInt8.self)

        let bufferLength = dataLength + size.size
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferLength)

        var numBytesEncrypted: size_t = 0
        let cryptStatus = CCCrypt(operation,
                                  CCAlgorithm(kCCAlgorithmAES),
                                  CCOptions(kCCOptionPKCS7Padding),
                                  keyBytes,
                                  keyLength,
                                  ivBytes,
                                  dataBytes,
                                  dataLength,
                                  buffer,
                                  bufferLength,
                                  &numBytesEncrypted)

        if cryptStatus == CCCryptorStatus(kCCSuccess) {
            return Data(bytes: buffer, count: numBytesEncrypted)
        }
        buffer.deallocate()
        return nil
    }
}
