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

  private func initiateNotifications() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(didRefreshInternetConnection),
      name: .DidRefreshInternetConnection,
      object: nil)
  }

  init() {
    initiateNotifications()
    Networkeeng.shared.start()
  }

  @objc
  private func didRefreshInternetConnection(notification: NSNotification) {
    guard let connection = notification.object as? Networkeeng.Connection else {
      return
    }
    
    DispatchQueue.main.async {
      self.networkConnection = connection
    }
  }
}
