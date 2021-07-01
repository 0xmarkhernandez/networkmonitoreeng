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

  public enum Connection: CustomStringConvertible {
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

  enum VPNProtocols: String, CaseIterable {
    case ipsec
    case ppp
    case tan
    case tap
    case tun
  }

  public static let shared = Networkeeng()
  private let monitor = NWPathMonitor()
  private let vpnProtocols = VPNProtocols.allCases
  public var networkStatus: Networkeeng.Connection = .unavailable
  public var isConnectedToVPN: Bool = false

  #if TEST
    var testReachable: Bool?
  #endif

  public var isReachable: Bool {
    #if TEST
      return testReachable ?? (_networkStatus != Networkeeng.Connection.none)
    #else
      return networkStatus != .unavailable
    #endif
  }

  public override init() {}

  public func start() {
    let pathUpdateHandler = { (path: NWPath) in

      let availableInterfaces = path.availableInterfaces
      if !availableInterfaces.isEmpty {
        let list = availableInterfaces.map { $0.debugDescription }
          .joined(separator: " | ")
        for vpnProtocol in self.vpnProtocols {
          let isVPNProtocol = list.contains(vpnProtocol.rawValue)
          if isVPNProtocol {
            self.isConnectedToVPN = true
          }
        }
      }

      var status: Connection = .none
      if path.usesInterfaceType(.wifi) {
        status = .wifi
      } else if path.usesInterfaceType(.cellular) {
        status = .cellular
      } else {
        status = .unavailable
      }

      self.networkStatus = status
      NotificationCenter.default.post(
        name: .didRefreshInternetConnection,
        object: status)
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
