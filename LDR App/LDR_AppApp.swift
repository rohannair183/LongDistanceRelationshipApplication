//
//  LDR_AppApp.swift
//  LDR App
//
//  Created by Rohan Nair on 2023-06-12.
//

import SwiftUI
import FirebaseCore
import SDWebImageSVGCoder



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
//    @AppStorage("AppState") var appState:AppState = AppState()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var stringArray = Array(repeating: "", count: 6)
//    @AppStorage("AppStateData") var appStateData: Data = Data()

    init() {
        setUpDependencies() // Initialize SVGCoder
    }
    
    var body: some Scene {
        WindowGroup {
              MainContent(appState:appState).preferredColorScheme(.light)
//            ProfilePicturePickerScreen()
//            GoalCardView(appState:AppState(), competetiveGoalCard: GoalCardModel.sampleCards[2])
            
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

// Initialize SVGCoder
private extension YourApp {
    
    func setUpDependencies() {
        SDImageCodersManager.shared.addCoder(SDImageSVGCoder.shared)
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
