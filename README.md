<p align="center">
<img src="https://user-images.githubusercontent.com/9291685/160267304-b5f4832e-bdc2-4a39-b745-330722cfd344.gif" width="300"/>
</p>


**SwipeableTabView** is a tab view built using SwiftUI that can be swiped horizontally.

## Installation
Please install **SwipeableTabView** via Swift Package Manager.

## Usage

**SwipeableTabView** can be used in much the same way as the SwiftUI [TabView](https://developer.apple.com/documentation/swiftui/tabview).
Please set an array of SwipeableTabTitle structure instances.

```swift
import SwiftUI
import SwipeableTabView

struct ContentView: View {
    @State var selection: Int = 0
    let titles: [SwipeableTabTitle<Int>] = [
        .init(tag: 0, text: "Tab\(0)"),
        .init(tag: 1, text: "Tab\(1)"),
        .init(tag: 2, text: "Tab\(2)"),
    ]

    var body: some View {
        SwipeableTabView(selection: $selection,
                         titles: titles) {
            ForEach(titles) { title in
                Text(title.text)
                    // Set same value as SwipeableTabTitle's tag.
                    .tag(title.tag)
            }
        }
    }
}
```