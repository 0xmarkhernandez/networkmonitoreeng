//
//  HomeViewRow.swift
//  demo
//
//  Created by Mark Angelo Hernandez on 03/07/2021.
//

import SwiftUI

struct HomeViewRow: View {
  let title: String
  let description: String

  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(title)
          .fontWeight(.regular)
        Text(description)
          .fontWeight(.heavy)
      }
      Spacer()
    }
    .padding(.bottom)
    .padding(.horizontal)
  }
}

#if DEBUG
  struct HomeViewRow_Previews: PreviewProvider {
    static var previews: some View {
      HomeViewRow(
        title: "Title",
        description: "Description")
    }
  }
#endif
