//
//  File.swift
//  
//
//  Created by Suoie on 2023/6/22.
//

import Foundation

import CommonCrypto

public enum AESKeySize:Int{
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
    func aesCrypt(operation: CCOperation, key: String, iv: String?, keySize: AESKeySize = .aes256) -> Data? {
        let keyLength = size_t(keySize.size)
        var keyBytes = [CChar](repeating: 0, count: keyLength + 1)
        _ = key.getCString(&keyBytes, maxLength: keyLength + 1, encoding: .utf8)
        
        let options = CCOptions(iv == nil ? kCCOptionECBMode : kCCOptionPKCS7Padding)
        var ivBytes: [CChar]?
        if let iv = iv, !iv.isEmpty {
            ivBytes = [CChar](repeating: 0, count: keyLength + 1)
            _ = iv.getCString(&ivBytes!, maxLength: keyLength + 1, encoding: .utf8)
        }

        let bufferSize = self.count + keySize.size
        var buffer = Data(count: bufferSize)

        var numBytesEncrypted: size_t = 0
        let cryptStatus = buffer.withUnsafeMutableBytes { bufferBytes in
            CCCrypt(operation,
                    CCAlgorithm(kCCAlgorithmAES),
                    options,
                    keyBytes, keyLength,
                    ivBytes,
                    (self as NSData).bytes, self.count,
                    bufferBytes.baseAddress, bufferSize,
                    &numBytesEncrypted)
        }

        if cryptStatus == kCCSuccess {
            buffer.removeSubrange(numBytesEncrypted...)
            return buffer
        } else {
            return nil
        }
    }
}
