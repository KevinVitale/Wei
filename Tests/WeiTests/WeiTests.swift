import XCTest
@testable import Wei

final class WeiTests: XCTestCase {
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
    
    func testDenominationCodable() throws {
        let value = [
            [ "wei"   :"1" ],
            [ "kwei"  :"1" ],
            [ "mwei"  :"1" ],
            [ "gwei"  :"1" ],
            [ "micro" :"1" ],
            [ "milli" :"1" ],
            [ "ether" :"1" ],
        ]
        
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        let data    = try encoder.encode(value)
        let amounts = try decoder.decode([Wei].self, from: data)
        amounts.enumerated().forEach { idx, amount in
            let denom = Wei.Denomination.allKeys[idx]
            let wei = amount.to(.wei)
            let cmp = "1"(as: denom).to(.wei)

            print("\"1\" \(denom.stringValue.uppercased()) is: \(wei)")
            XCTAssertEqual(wei, cmp)
        }
    }

    static var allTests = [
        ("testWei", testWei),
        ("testDenominationCodable", testDenominationCodable),
    ]
}
