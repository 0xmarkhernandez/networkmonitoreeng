//
//  Networkeeng.swift
//  Networkeeng
//
//  Created by Mark Angelo Hernandez on 27/06/2021.
//

import Foundation
import Network

private let bundleIdPrefix = "com.markangelohernandez.networkeeng"

extension Notification.Name {

  /// A notification when an app internet connection refreshes.
  public static let didRefreshInternetConnection =
    Notification.Name("\(bundleIdPrefix).DidRefreshInternetConnection")
}

public final class Networkeeng: NSObject {

  public enum Connection: CustomStringConvertible, CaseIterable {
    case none
    case unavailable, wifi, cellular

    public var description: String {
      switch self {
      case .cellular: return "Cellular"
      case .wifi: return "WiFi"
      case .unavailable: return "No Connection"
      case .none: return "None"
      }
    }
  }

  public enum ConnectionStatus: String, CaseIterable {
    case requiresConnection
    case satisfied
    case unsatisfied
    case unknown

    public var description: String {
      switch self {
      case .requiresConnection: return "Requires Connection"
      case .satisfied: return "Satisfied"
      case .unsatisfied: return "Unsatisfied"
      case .unknown: return "Unknown"
      }
    }
  }

  public enum VPNProtocol: String, CaseIterable {
    case ipsec
    case ppp
    case tan
    case tap
    case tun
    case none
  }

    public struct NetworkStatus: Equatable {
    public let connection: Connection
    public let status: ConnectionStatus
    public let vpnProtocol: VPNProtocol
  }

  public static let shared = Networkeeng()

  public var networkStatus: NetworkStatus =
    NetworkStatus(
      connection: .none,
      status: .unsatisfied,
      vpnProtocol: .none)

  private let monitor = NWPathMonitor()
  private let vpnProtocols = VPNProtocol.allCases

  public override init() {}

  public func start() {
    let pathUpdateHandler = { (path: NWPath) in

      // Setting initial VPN protocol value to none.
      var vpnProtocol: VPNProtocol = .none

      let availableInterfaces = path.availableInterfaces
      if !availableInterfaces.isEmpty {
        let list = availableInterfaces.map { $0.debugDescription }
          .joined(separator: " | ")
        for vpnProtocolValue in self.vpnProtocols {
          let isVPNProtocol = list.contains(vpnProtocolValue.rawValue)
          if isVPNProtocol {
            vpnProtocol = vpnProtocolValue
          }
        }
      }

      var connection: Connection = .none
      if path.usesInterfaceType(.wifi) {
        connection = .wifi
      } else if path.usesInterfaceType(.cellular) {
        connection = .cellular
      } else {
        connection = .unavailable
      }

      var status: ConnectionStatus
      switch path.status {
      case .requiresConnection:
        status = .requiresConnection
      case .satisfied:
        status = .satisfied
      case .unsatisfied:
        status = .unsatisfied
      @unknown default:
        status = .unknown
      }

      let networkStatus = NetworkStatus(
        connection: connection,
        status: status,
        vpnProtocol: vpnProtocol)
      NotificationCenter.default.post(
        name: .didRefreshInternetConnection,
        object: networkStatus)
      self.networkStatus = networkStatus
    }

    monitor.pathUpdateHandler = pathUpdateHandler

    let queue = DispatchQueue.init(
      label: "\(bundleIdPrefix).reachability",
      qos: .background)

    monitor.start(queue: queue)
  }

  public func stop() {
    monitor.cancel()
  }
}
