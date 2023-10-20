//
//  main.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//

import UIKit

private func delegateClassName() -> AnyClass {
    NSClassFromString("TestAppDelegate") ?? AppDelegate.self
}

UIApplicationMain(CommandLine.argc, CommandLine.unsafeArgv, nil, NSStringFromClass(delegateClassName()))
