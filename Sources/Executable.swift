//
//  Executable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public typealias ExecutionBlock<T> = ((Result<T>) -> Void) -> Void

protocol Executable {
    var execution: ExecutionBlock<Any> { get set }
    func execute()
}
