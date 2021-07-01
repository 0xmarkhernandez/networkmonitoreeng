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
    Text(viewModel.networkConnection.description)
  }
}

#if DEBUG
  struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
      HomeView()
    }
  }
#endif
