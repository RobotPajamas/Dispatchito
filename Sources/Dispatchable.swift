//
//  Dispatchable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import UIKit

protocol Dispatchable : Runnable, Cancellable, Completable, Executable, Timeoutable, Retriable {
    var id: String { get }
}

extension Dispatchable {
    func execute() {
        execution { (result) in
            complete(result: result)
        }
    }
    
//    func complete(result: Result<Any>) {
//        <#code#>
//    }
}
