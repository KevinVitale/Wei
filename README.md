# Wei

## A micro-framework for working with $ETH cryptocurrency

> _Note: Requires Swift 5.2+_

## TL;DR

Take any `String`, `Integer`, or `Float` and instanteously convtert it to _Wei_:

  - `1(as: .ether)`;
  - `"1"(as: .ether)`;  
  - `1.0(as: .ether)`;  
  
Convert _Wei_ between denominations:

`1(as: .gwei).to(.wei) // 1000000 WEI`

## Test Examples

```swift

/** Given this array of values:
let value = [
    [ "wei"   :"1" ],
    [ "kwei"  :"1" ],
    [ "mwei"  :"1" ],
    [ "gwei"  :"1" ],
    [ "micro" :"1" ],
    [ "milli" :"1" ],
    [ "ether" :"1" ],
]
 */

Test Case '-[WeiTests.WeiTests testDenominationCodable]' started.
"1" WEI   is: 1 WEI
"1" KWEI  is: 1000 WEI
"1" MWEI  is: 1000000 WEI
"1" GWEI  is: 1000000000 WEI
"1" MICRO is: 1000000000000 WEI
"1" MILLI is: 1000000000000000 WEI
"1" ETHER is: 1000000000000000000 WEI
```

```swift
func testWei() {
    XCTAssertEqual( 5(as: .wei), "0.000000000000000005"(as: .ether))
    XCTAssertEqual( "79992437899999999995"(as: .wei), "79.992437899999999995"(as: .ether))
    XCTAssertEqual("1.5"(as: .ether).hexString, "0x14d1120d7b160000")
    XCTAssertEqual(1.5(as: .ether).hexString, "0x14d1120d7b160000")
    XCTAssertEqual(0x0234c8a3397aab58(as: .wei), 158972490234375000(as: .wei))
    XCTAssertEqual("0x0234c8a3397aab58"(as: .wei), 158972490234375000(as: .wei).to(.ether))
    XCTAssertEqual("0x0234c8a3397aab58"(as: .wei), 0.158972490234375(as: .ether))
    XCTAssertEqual("1.355"(as: .wei), "0.000000000000000001355"(as: .ether))
    XCTAssertEqual(1.0(as: .gwei), 1000000000(as: .wei))
    XCTAssertEqual(10_000(as: .gwei), 0.00001(as: .ether))
}
```

# License
```
Copyright (c) 2019 Kevin J. Vitale

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do so, 
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all 
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A 
PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT 
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION 
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE 
OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```
