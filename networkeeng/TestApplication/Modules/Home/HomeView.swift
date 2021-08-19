//
//  HomeView.swift
//  demo
//
//  Created by Mark Angelo Hernandez on 27/06/2021.
//

import SwiftUI
import UIKit

struct HomeView: View {
  @ObservedObject var viewModel = HomeViewModel()
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("👑 networkeeng")
        .font(.title)
        .fontWeight(.heavy)
        .accessibility(identifier: "homeViewTitle")
      
      ScrollView(showsIndicators: false) {
        HomeViewRow(
          title: "Internet connected via:",
          description: viewModel.connection.description
        )
        .accessibility(identifier: "homeViewRowConnection")
        HomeViewRow(
          title: "Connection status:",
          description: viewModel.connectionStatus.description
        )
        .accessibility(identifier: "homeViewRowConnectionStatus")
        HomeViewRow(
          title: "VPN protocol:",
          description: viewModel.vpnProtocol.rawValue
        )
        .accessibility(identifier: "homeViewRowVPNProtocol")
        Spacer()
      }
    }
  }
}

#if DEBUG
struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
#endif
