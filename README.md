# README for AESEAD Swift Package

## Introduction

AESEAD is a Swift package that simplifies AES encryption and decryption in your Swift projects. It offers a simple interface to encrypt strings, decrypt strings, and decrypt JSON data using AES encryption standard. The package relies on the CommonCrypto library to perform the cryptographic operations.

## Installation

### Swift Package Manager

You can install AESEAD using the [Swift Package Manager](https://swift.org/package-manager/). Add the package to the dependencies section of your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/Sunalamye/AEDEAD.git", .upToNextMajor(from: "1.0.0"))
]
```

Don't forget to add "AESEAD" to your target as a dependency:

```swift
targets: [
    .target(
        name: "AESEAD",
        dependencies: ["AESEAD"]),
]
```

## Usage

### Setting Up Key and Initialization Vector (IV)

Before you start encrypting or decrypting data, you need to set the key and optionally the initialization vector (IV) that will be used for the cryptographic operations:

```swift
import AESEAD

AESEAD.shared.setKeyAndIV(key: "yourEncryptionKey", iv: "yourInitializationVector")
```

### Encrypting a String

To encrypt a string, use the `encryptWithAES()` method from the `String` extension:

```swift
do {
    let encryptedText = try "YourTextToEncrypt".encryptWithAES()
    print("Encrypted Text: \(encryptedText ?? "")")
} catch {
    print("Encryption Error: \(error)")
}
```

### Decrypting a String

To decrypt a string that was encrypted using AES, use the `decryptWithAES()` method from the `String` extension:

```swift
do {
    let decryptedText = try "YourEncryptedText".decryptWithAES()
    print("Decrypted Text: \(decryptedText)")
} catch {
    print("Decryption Error: \(error)")
}
```

### Decrypting a JSON String

To decrypt a JSON string that was encrypted using AES, use the `decryptJsonWithAES()` method from the `String` extension:

```swift
struct MyData: Codable {
    var property1: String
    var property2: Int
}

do {
    let decryptedData: MyData = try "YourEncryptedJson".decryptJsonWithAES()
    print("Decrypted JSON: \(decryptedData)")
} catch {
    print("Decryption Error: \(error)")
}
```

## Error Handling

AESEAD throws specific errors in case something goes wrong during the encryption/decryption process. You can catch and handle these errors by using a do-catch statement. The errors are defined in the `AESEAD.DecryptionError` enumeration.

## Dependencies

- CommonCrypto

## License

Specify your license here. For example, MIT.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## Contact

Your Name - sunalamye@pm.me

Project Link: [https://github.com/Sunalamye/AEDEAD](https://github.com/Sunalamye/AEDEAD)
