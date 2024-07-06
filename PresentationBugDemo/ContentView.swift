// By Dennis Müller

import SwiftUI

@Observable @MainActor
final class AppRouter {
  static let shared = AppRouter()

  var isShowingSheet = false
  let sheetRouter = SheetRouter()
}

@Observable @MainActor
final class SheetRouter {
  var path = NavigationPath()
  var isShowingOtherSheet = false

  func reset() {
    path = .init()
    isShowingOtherSheet = false
  }
}

struct ContentView: View {
  @Bindable var router = AppRouter.shared

  var body: some View {
    Button("Present") {
      router.sheetRouter.reset()
      router.isShowingSheet = true
    }
    .sheet(isPresented: $router.isShowingSheet) {
      SheetView(router: router.sheetRouter)
    }
  }
}

struct SheetView: View {
  @Bindable var router: SheetRouter

  var body: some View {
    NavigationStack(path: $router.path) {
      Button("Show Another Sheet") {
        router.isShowingOtherSheet = true
      }
      .sheet(isPresented: $router.isShowingOtherSheet) {
        Text("Hello, World!")
      }
    }
  }
}

#Preview {
  ContentView()
}
