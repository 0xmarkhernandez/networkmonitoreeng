//
//  HomeView.swift
//  demo
//
//  Created by Mark Angelo Hernandez on 27/06/2021.
//

import SwiftUI

struct HomeView: View {
  @ObservedObject var vm = HomeViewModel()

  var body: some View {
    Text(vm.networkConnection.description)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
