//
//  Dispatchable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import UIKit

// TODO: Need to completely mangle what was done in RobotPajamas/Dispatcher because Swift 4.2
// still can't handle generics in protocols correctly - without some amount of type erasure

public typealias CompletionBlock<T> = (Result<T>) -> Void
public typealias ExecutionBlock<T> = ((Result<T>) -> Void) -> Void

protocol Dispatchable : Runnable, Cancellable, Retriable, Timeoutable /*Completable, Executable */{
    var id: String { get }
//    var completions: [Any] { get set }
    func addCompletion(_ completion: @escaping () -> Void)
}

//extension Dispatchable {
//    func execute() {
//        execution { (result) in
//            complete(result: result)
//        }
//    }
//}
