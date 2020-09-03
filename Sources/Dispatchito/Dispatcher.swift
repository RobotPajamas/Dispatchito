//
//  Dispatcher.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public protocol Dispatcher {
    func clear()
    func count() -> Int
    func enqueue(item: Dispatchable)
    func start()
    func stop()
}
