

import SwiftUI

struct ContentView: View {

    @State private var selectedTab = 2

    var body: some View {
        Group {
            if #available(iOS 18.0, *) {

                TabView(selection: $selectedTab) {
                    Tab("Home", systemImage: "house.fill", value: 0) {
                        PlaceholderView(title: "Home", icon: "house.fill")
                    }

                    Tab("Track", systemImage: "clock", value: 1) {
                        PlaceholderView(title: "Track", icon: "clock")
                    }

                    Tab("Insights", systemImage: "chart.bar.fill", value: 2) {
                        InsightsView()
                    }

                    Tab("Add", systemImage: "plus", value: 3, role: .search) {
                        LoggingPlaceholderView()
                    }
                }

                .toolbarBackground(.hidden, for: .tabBar)
            } else {

                TabView(selection: $selectedTab) {
                    PlaceholderView(title: "Home", icon: "house.fill")
                        .tabItem { Label("Home", systemImage: "house.fill") }
                        .tag(0)

                    PlaceholderView(title: "Track", icon: "clock")
                        .tabItem { Label("Track", systemImage: "clock") }
                        .tag(1)

                    InsightsView()
                        .tabItem { Label("Insights", systemImage: "chart.bar.fill") }
                        .tag(2)

                    LoggingPlaceholderView()
                        .tabItem { Label("Add", systemImage: "plus") }
                }
                .toolbarBackground(.hidden, for: .tabBar)
            }
        }
        .preferredColorScheme(.light)
    }
}

// MARK: - Placeholder Views

struct PlaceholderView: View {
    let title: String
    let icon: String

    var body: some View {
        ZStack {
            Color(hex: "F8F9FB").ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: icon)
                    .font(.system(size: 60))
                    .foregroundColor(.gray.opacity(0.3))
                Text("\(title) Screen")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.gray.opacity(0.5))
                Text("Coming Soon")
                    .font(.system(size: 16))
                    .foregroundColor(.gray.opacity(0.4))
            }
        }
    }
}

struct LoggingPlaceholderView: View {
    var body: some View {
        ZStack {
            Color(hex: "F8F9FB").ignoresSafeArea()
            VStack(spacing: 20) {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(Color(hex: "9A84E8").opacity(0.6))
                Text("Logging Screen")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                Text("Capture your daily symptoms and activity levels.")
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
    }
}

#Preview {
    ContentView()
}
