//
//  SerialDispatcher.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import Foundation

public class SerialDispatcher : Dispatcher {
    
    private var active: Dispatchable? = nil
    private var queue: [Dispatchable] = []
    private let executionHandler: DispatchQueue
    private let dispatchHandler: DispatchQueue
    
    public init(executeOn: DispatchQueue, dispatchOn: DispatchQueue) {
        self.executionHandler = executeOn
        self.dispatchHandler = dispatchOn
    }
    
    func clear() {
        active = nil
        queue.removeAll()
    }
    
    func count() -> Int {
        return queue.count
    }
    
    func enqueue(item: Dispatchable) {
        var i = item
        i.completions.append { _ in
            self.dispatchNext()
        }
        queue.append(i)
        if active == nil {
            dispatchNext()
        }
    }
    
    private func dispatchNext() {
        active = queue.first
        if let a = active {
            let cancel = {
                // TODO: Check if this is doing what I think it is
                // Capture this current queueItem, and compare it against the active item in X seconds
                guard a.id == self.active?.id else {
                    return
                }
                self.active?.timedOut()
            }
            
            dispatchHandler.asyncAfter(deadline: .now() + Double(a.timeout), execute: cancel)
            executionHandler.async {
                a.run()
            }
        }
    }
    
    
}
