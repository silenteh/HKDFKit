[![Build Status](https://travis-ci.org/silenteh/HKDFKit.svg?branch=master)](https://travis-ci.org/silenteh/HKDFKit)


HKDFKit Swift framework for both iOS and OS X
=======

HKDF utility in Swift for both iOS and OS X

This is a porting of Frederic Jacobs JKDFKit to Swift with the addition it supports also OS X

## Usage

[RFC5869](http://tools.ietf.org/html/rfc5869)-compliant key derivation function.

```Swift
let derivedData = HKDFKit.deriveKey(HKDFKit.Hash.SHA256, seed: aSeed, info: anInfo, salt: aSalt, outputSize: anOutputSize)
```
---

[TextSecure v2 protocol](https://github.com/WhisperSystems/TextSecure/wiki/ProtocolV2) uses different bounds for the HKDF function.

```Swift
let derivedData = let derivedData = HKDFKit.TextSecureV2deriveKey(HKDFKit.Hash.SHA256, seed: aSeed, info: anInfo, salt: aSalt, outputSize: anOutputSize)
```

## Documentation

API reference is available on [CocoaDocs](http://cocoadocs.org/docsets/HKDFKit).
 
## Installation

Add this line to your `Podfile`

```
pod 'HKDFKit', '~> version number'
```

## License

Licensed under the GPLv3: http://www.gnu.org/licenses/gpl-3.0.html
