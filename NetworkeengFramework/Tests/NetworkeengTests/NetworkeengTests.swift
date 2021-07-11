    import XCTest
    @testable import Networkeeng

    final class NetworkeengTests: XCTestCase {
      func testNetworkeengConnection() {
        for value in Networkeeng.Connection.allCases {
          switch value {
          case .none:
            XCTAssertEqual(value.description, "None")
          case .unavailable:
            XCTAssertEqual(value.description, "No Connection")
          case .wifi:
            XCTAssertEqual(value.description, "WiFi")
          case .cellular:
            XCTAssertEqual(value.description, "Cellular")
          }
        }
      }

      func testNetworkeengConnectionStatus() {
        for value in Networkeeng.ConnectionStatus.allCases {
          switch value {
          case .requiresConnection:
            XCTAssertEqual(value.description, "Requires Connection")
          case .satisfied:
            XCTAssertEqual(value.description, "Satisfied")
          case .unsatisfied:
            XCTAssertEqual(value.description, "Unsatisfied")
          case .unknown:
            XCTAssertEqual(value.description, "Unknown")
          }
        }
      }

      func testNetworkeengVPNProtocol() {
        for value in Networkeeng.VPNProtocol.allCases {
          switch value {
          case .ipsec:
            XCTAssertEqual(value.rawValue, "ipsec")
          case .ppp:
            XCTAssertEqual(value.rawValue, "ppp")
          case .tan:
            XCTAssertEqual(value.rawValue, "tan")
          case .tap:
            XCTAssertEqual(value.rawValue, "tap")
          case .tun:
            XCTAssertEqual(value.rawValue, "tun")
          case .none:
            XCTAssertEqual(value.rawValue, "none")
          }
        }
      }
    }
