//
//  ContentView.swift
//  SwipeableTabViewDemoApp
//
//  Created by Kazumasa Wakamori on 2022/03/27.
//

import SwiftUI
import SwipeableTabView

struct ContentView: View {
    @State var selection: Int = 1
    let titles: [SwipeableTabTitle<Int>] = (0..<10).map { i in
        SwipeableTabTitle<Int>(tag: i, text: "Tab\(i)")
    }
    
    var body: some View {
        NavigationView {
            SwipeableTabView(selection: $selection,
                             titles: titles) {
                ForEach(titles) { title in
                    VStack {
                        Text(title.text)
                            .font(.title)
                            .tag(title.tag)
                        Spacer()
                    }
                }
            }
            .navigationTitle("SwipeableTabView")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
