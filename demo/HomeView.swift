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
      Text("Internet connected via:")
        .fontWeight(.regular)
      Text(viewModel.networkConnection.description)
        .fontWeight(.heavy)
      Text("VPN protocol:")
        .fontWeight(.regular)
      Text(viewModel.vpnProtocol.rawValue)
        .fontWeight(.heavy)
      Spacer()
    }
    .frame(maxWidth: .infinity)
  }
}

#if DEBUG
  struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView()
    }
  }
#endif
