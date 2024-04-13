//
//  SceneDelegate.swift
//  SeSACShopping
//
//  Created by 은서우 on 2024/01/18.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        //UserState: 사용자의 첫 화면 결정하기 위해 필요한 요소
        //false라면 사용자가 처음 들어왔을것이고, 첫진입이후에는 true로 바꿔주자
        let value = UserDefaults.standard.bool(forKey: "UserState")
        
        if value == false {
            
            //코드를 통해 앱 시작 화면 설정
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            
            let sb = UIStoryboard(name: "Onboarding", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: OnboardingViewController.identifier) as! OnboardingViewController
            
            let nav = UINavigationController(rootViewController: vc)
            
            window?.rootViewController = nav
            window?.makeKeyAndVisible()
        } else {
            //코드를 통해 앱 시작 화면 설정
            guard let scene = (scene as? UIWindowScene) else { return }
            
            window = UIWindow(windowScene: scene)
            
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "MainTabBarContoroller") as! UITabBarController
            
            window?.rootViewController = vc
            window?.makeKeyAndVisible()
        }
    }
        
        func sceneDidDisconnect(_ scene: UIScene) {
            // Called as the scene is being released by the system.
            // This occurs shortly after the scene enters the background, or when its session is discarded.
            // Release any resources associated with this scene that can be re-created the next time the scene connects.
            // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        }
        
        func sceneDidBecomeActive(_ scene: UIScene) {
            // Called when the scene has moved from an inactive state to an active state.
            // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
            UIApplication.shared.applicationIconBadgeNumber = 0
            UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        }
        
        func sceneWillResignActive(_ scene: UIScene) {
            // Called when the scene will move from an active state to an inactive state.
            // This may occur due to temporary interruptions (ex. an incoming phone call).
        }
        
        func sceneWillEnterForeground(_ scene: UIScene) {
            // Called as the scene transitions from the background to the foreground.
            // Use this method to undo the changes made on entering the background.
        }
        
        func sceneDidEnterBackground(_ scene: UIScene) {
            // Called as the scene transitions from the foreground to the background.
            // Use this method to save data, release shared resources, and store enough scene-specific state information
            // to restore the scene back to its current state.
            
            // 1. 알림에 들어갈 컨텐츠
            let content = UNMutableNotificationContent()
            content.title = "SeSAC Shopping을 잊으셨나요!"
            content.body = "새로운 상품을 구경하세요!!!"
            content.badge = 1
            
            // 2. 컨텐츠를 언제 보낼지 트리거를 만들어줘요
            // 트리거는 로케이션, 타임인터벌, 캘린더 이 기준으로 만들 수 있어용
            var component = DateComponents()
            component.hour = 13
            component.minute = 30
            
            let calendatTrigger = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
            
            // 3. 요청
            let requset = UNNotificationRequest(identifier: "\(Date())", content: content, trigger: calendatTrigger)
            
            // 4. iOS System에 등록
            UNUserNotificationCenter.current().add(requset)
        }
        
        
    }
    
