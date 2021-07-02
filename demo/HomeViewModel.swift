//
//  HomeViewModel.swift
//  demo
//
//  Created by Mark Angelo Hernandez on 27/06/2021.
//

import SwiftUI
import networkeeng

final class HomeViewModel: ObservableObject {
  @Published var networkConnection: Networkeeng.Connection = .none
  @Published var vpnProtocol: Networkeeng.VPNProtocol = .none

  private func initiateNotifications() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didRefreshInternetConnection),
      name: .didRefreshInternetConnection,
      object: nil)
  }

  init() {
    initiateNotifications()
    Networkeeng.shared.start()
  }

  @objc
  private func didRefreshInternetConnection(notification: NSNotification) {
    guard let networkStatus = notification.object as? Networkeeng.NetworkStatus
    else {
      return
    }

    DispatchQueue.main.async {
      self.networkConnection = networkStatus.connection
      self.vpnProtocol = networkStatus.vpnProtocol
    }
  }
}
