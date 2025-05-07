//
//  iPatronusApp.swift
//  iPatronus
//
//  Created by Eduardo Herrera on 26/04/25.
//

import SwiftUI
import SwiftData
import Firebase

@main
struct iPatronusApp: App {
  
  // MARK: Properties and Vars
  
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject private var router = AppRouter(currentScreen: .splash)
  @StateObject private var loaderManager = LoaderManager.shared
  var iPatronusModelContainer: ModelContainer = {
    let schema = Schema([HouseEntity.self, CharacterEntity.self])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    
    do {
      return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
      fatalError("Could not create ModelContainer: \(error)")
    }
  }()
  
  // MARK: Lifecycle Methods and Vars
  
  var body: some Scene {
    WindowGroup {
      RootView()
        .environmentObject(router)
        .environmentObject(loaderManager)
        .modelContainer(iPatronusModelContainer)
    }
  }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    FirebaseApp.configure()
    return true
  }
}
