import XCTest
@testable import AESEAD

final class AESEADTests: XCTestCase {
    
    
    
    func testEncryp1() throws {
        AESEAD.shared.setKeyAndIV(key: "testst1111", iv: "vvvv")
        let enOptional = try "akaioER".encryptWithAES()
        if let enOptional{
            XCTAssertEqual(enOptional, "ovrkk18P4nFb9I+BYq/HaA==")
        }
    }
    
    func testEncryp2() throws {
        AESEAD.shared.setKeyAndIV(key: "testst1111", iv: "vvv")
        let enOptional = try "akaioER".encryptWithAES()
        if let enOptional{
            XCTAssertNotEqual(enOptional, "ovrkk18P4nFb9I+BYq/HaA==")
        }
    }
    
    func testDecrypt() throws{
        AESEAD.shared.setKeyAndIV(key: "testst1111", iv: "vvvv")
        let enOptional:String = try "ovrkk18P4nFb9I+BYq/HaA==".decryptWithAES()
        
        XCTAssertEqual(enOptional, "akaioER")
    }
    
    
    func testDecryptJSON() throws{
        AESEAD.shared.setKeyAndIV(key: "testst1111", iv: "vvvv")
        let json:testJSON = try "EfKO2Nxc8lljEiVnsNIN8FNpS02vu0lc/tRVrNFv63g=".decryptJsonWithAES()
        
        XCTAssertEqual(json.testString, "suoie")
    }
    
    struct testJSON:Codable{
        let testString:String
    }
    
}
