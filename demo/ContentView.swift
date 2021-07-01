//
//  ContentView.swift
//  demo
//
//  Created by Mark Angelo Hernandez on 27/06/2021.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    HomeView()
  }
}

#if DEBUG
  struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
      ContentView()
    }
  }
#endif
