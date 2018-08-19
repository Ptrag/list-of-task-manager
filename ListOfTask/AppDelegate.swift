//
//  AppDelegate.swift
//  ListOfTask
//
//  Created by Pj on 15/07/2018.
//  Copyright © 2018 Pj. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(Realm.Configuration.defaultConfiguration.fileURL)
        

        do{
            _ = try Realm()
        } catch {
            print("Error initializing Realm \(error)")
        }
        
        return true
    }

}

