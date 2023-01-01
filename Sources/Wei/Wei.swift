import Foundation
import BigInt

@propertyWrapper
public struct Wei: Codable, Equatable, CustomDebugStringConvertible, ExpressibleByIntegerLiteral, ExpressibleByStringLiteral, ExpressibleByFloatLiteral {
  public init<T: StringProtocol>(wrappedValue: T, denomination: Denomination) {
    self.init(wrappedValue: String(wrappedValue), denomination: denomination)
  }
  
  public init<T: SignedInteger>(wrappedValue: T, denomination: Denomination) {
    self.init(wrappedValue: String(wrappedValue), denomination: denomination)
  }
  
  public init(stringLiteral value: StringLiteralType) {
    self.init(wrappedValue: String(value), denomination: .wei)
  }
  
  public init(integerLiteral value: Int) {
    self.init(wrappedValue: String(value), denomination: .wei)
  }
  
  public init(floatLiteral value: FloatLiteralType) {
    self.init(wrappedValue: String(value), denomination: .wei)
  }
  
  public init(wrappedValue: String, denomination: Denomination) {
    self.wrappedValue = wrappedValue
    self.denomination = denomination
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: Denomination.self)
    let denomination: Denomination! = container
      .allKeys
      .first
    
    guard denomination != nil else {
      throw DecodingError.dataCorrupted(.init(codingPath:[], debugDescription:""))
    }
    
    self.denomination = denomination
    self.wrappedValue = try container.decode(String.self, forKey: denomination)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: Denomination.self)
    try container.encode(wrappedValue, forKey: denomination)
  }
  
  private let denomination :Denomination
  private var amount       :Decimal? {
    Decimal(string: wrappedValue).map { $0 * denomination.decimal }
  }
  
  public var hexString :String {
    guard let bigInt = BInt(to(.wei).wrappedValue) else {
      return "0x"
    }
    return "0x" + bigInt.asString(radix: 16)
  }
  
  public var wrappedValue :String
  public var debugDescription: String {
    guard let amount = self.amount else {
      return "Invalid \"wrappedValue\": \(wrappedValue)"
    }
    
    return "\(amount / denomination.decimal) \(denomination.stringValue.uppercased())"
  }
  
  public func to(_ denomination: Wei.Denomination) -> Wei {
    Wei(wrappedValue: "\(amount! / denomination.decimal)", denomination: denomination)
  }
  
  public static func ==(lhs: Wei, rhs: Wei) -> Bool {
    lhs.to(.wei).amount == rhs.to(.wei).amount
  }
}

extension StringProtocol {
  public func callAsFunction(as denomination: Wei.Denomination) -> Wei {
    Wei(wrappedValue: self.stripHexIfNecessary(), denomination: denomination)
  }
  
  fileprivate func stripHexIfNecessary() -> Self {
    if starts(with: "0x"), let bigInt = BInt(String(dropFirst(2)), radix: 16), let description = bigInt.description as? Self {
      return description
    } else {
      return self
    }
  }
}

extension SignedInteger {
  public func callAsFunction(as denomination: Wei.Denomination) -> Wei {
    Wei(wrappedValue: self, denomination: denomination)
  }
}

extension Double {
  public func callAsFunction(as denomination: Wei.Denomination) -> Wei {
    Wei(wrappedValue: String(self), denomination: denomination)
  }
}

extension Wei {
  public enum Denomination: Comparable, CodingKey, CaseIterable {
    public static func < (lhs: Wei.Denomination, rhs: Wei.Denomination) -> Bool {
      lhs.decimal < rhs.decimal
    }
    
    case gas   //1
    case wei   //1
    case kwei  //1_000
    case mwei  //1_000_000
    case gwei  //1_000_000_000
    case micro //1_000_000_000_000
    case milli //1_000_000_000_000_000
    case ether //1_000_000_000_000_000_000
    
    var decimal: Decimal {
      switch self {
      case .gas   :fallthrough
      case .wei   :return 1
      case .kwei  :return 1e3
      case .mwei  :return 1e6
      case .gwei  :return 1e9
      case .micro :return 1e12
      case .milli :return 1e15
      case .ether :return 1e18
      }
    }
    
    public static let allKeys: [Denomination] = [
      .wei,
      .kwei,
      .mwei,
      .gwei,
      .micro,
      .milli,
      .ether,
    ]
  }
}
