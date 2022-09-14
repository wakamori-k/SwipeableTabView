import SwiftUI

public struct SwipeableTabView<SelectionValue: Hashable, Content: View>: View {
    @Binding var selection: SelectionValue
    var titles: [SwipeableTabTitle<SelectionValue>]
    @ViewBuilder let content: () -> Content
    
    public init(selection: Binding<SelectionValue>,
                titles: [SwipeableTabTitle<SelectionValue>],
                @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.titles = titles
        self.content = content
    }
    
    public var body: some View {
        VStack {
            TitlesView(selection: $selection,
                       titles: titles)
            if !content().isEmptyView {
                ContentsView(selection: $selection,
                             content: content)
            }
        }
    }
}

// MARK: - Title
public struct SwipeableTabTitle<SelectionValue: Hashable>: Identifiable {
    public var id: SelectionValue { tag }
    public let tag: SelectionValue
    public let text: String
    
    public init(tag: SelectionValue, text: String) {
        self.tag = tag
        self.text = text
    }
}

struct TitlesView<SelectionValue: Hashable>: View {
    @Binding var selection: SelectionValue
    var titles: [SwipeableTabTitle<SelectionValue>]
    @Namespace var namespace
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                HStack {
                    Spacer()
                    
                    ForEach(titles) { title in
                        TitleView(selection: $selection,
                                  title: title,
                                  namespace: namespace)
                            .onTapGesture {
                                withAnimation {
                                    selection = title.id
                                }
                            }

                    }
                    
                    Spacer()
                }
                .onChange(of: selection) { i in
                    withAnimation {
                        proxy.scrollTo(i, anchor: .center)
                    }
                }
            }
        }
    }
}

struct TitleView<SelectionValue: Hashable>: View {
    @Binding var selection: SelectionValue
    let title: SwipeableTabTitle<SelectionValue>
    var namespace: Namespace.ID
    
    var body: some View {
        VStack(spacing: 0) {
            Text(title.text)
                .padding(.horizontal, 5)
                .padding(.bottom, 3)
                .foregroundColor(selection == title.id ? .black : .gray)
                
            if selection == title.id {
                Color.black
                    .frame(height: 2)
                    .matchedGeometryEffect(id: "UnderLine",
                                           in: namespace)
            } else {
                Color.clear.frame(height: 2)
            }
        }
        .frame(maxWidth: .infinity)
    }
}


// MARK: - Content
struct ContentsView<SelectionValue: Hashable, Content: View>: View {
    @Binding var selection: SelectionValue
    @ViewBuilder let content: () -> Content

    @State private var privateSelection: SelectionValue

    init(selection: Binding<SelectionValue>,
         @ViewBuilder content: @escaping () -> Content) {
        self._selection = selection
        self.content = content
        
        self._privateSelection = State(wrappedValue: selection.wrappedValue)
    }
    
    var body: some View {
        TabView(selection: $privateSelection, content: content)
            .animation(.linear(duration: 0))
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: privateSelection) { value in
                withAnimation {
                    selection = value
                }
            }
            .onChange(of: selection) { value in
                privateSelection = value
            }
    }
}
