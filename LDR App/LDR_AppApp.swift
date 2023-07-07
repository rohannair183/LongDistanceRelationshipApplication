//
//  LDR_AppApp.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-12.
//

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
}

@main
struct YourApp: App {
    @ObservedObject var appState = AppState()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var stringArray = Array(repeating: "", count: 6)

    var body: some Scene {
        WindowGroup {
            MainContent(appState:appState).preferredColorScheme(.light)
//                .onAppear {
//
//                            for family in UIFont.familyNames.sorted() {
//                                print("Family: \(family)")
//                                
//                                let names = UIFont.fontNames(forFamilyName: family)
//                                for fontName in names {
//                                    print("- \(fontName)")
//                                }
//                            }
//                        }
//                        .padding()
                    

//            CodeInputScreen(appState: appState)
            //                OnboardingScreen()
            //            let dummyUser = User(firstName: "John", lastName: "Doe", email: "Johndoe@gmail.com", partnerJoined: false)
            //            InvitePartnerScreen(user:dummyUser, registrationManager: RegistrationManager())
        }
    }
}

public extension EnvironmentValues {
    var isPreview: Bool {
        #if DEBUG
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
        #else
        return false
        #endif
    }
}
