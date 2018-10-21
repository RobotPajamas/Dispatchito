//
//  SerialDispatcher.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import Foundation

//struct DispatchableBox {
//
//    let x: Any
//    let t: Any
//
//    init<T: Dispatchable>(_ erasure: T) {
//        x = erasure
//        t = T.self
//    }
//
//    func unbox<T: Dispatchable>() -> T {
//        return x as Dispatchable
//    }
//}

public class SerialDispatcher : Dispatcher {
    
    private var active: Dispatchable? = nil
    private var queue: [Dispatchable] = []
    private let executionHandler: DispatchQueue
    private let dispatchHandler: DispatchQueue
    
    public init(executeOn: DispatchQueue, dispatchOn: DispatchQueue) {
        self.executionHandler = executeOn
        self.dispatchHandler = dispatchOn
    }
    
    private func execute(_ item: Dispatchable) {
        executionHandler.async {
            item.run()
        }
    }
    
    func clear() {
        active = nil
        queue.removeAll()
    }
    
    func count() -> Int {
        return queue.count
    }
    
    func enqueue(item: Dispatchable) {
//        var i = item
        item.addCompletion({
            self.dispatchNext()
        })
//        i.completions.append { _ in
//            self.dispatchNext()
//        }
        queue.append(item)
        if active == nil {
            dispatchNext()
        }
    }
    
    private func dispatchNext() {
        guard !queue.isEmpty else {
            active = nil
            return
        }
        active = queue.removeFirst()
        if var a = active {
            let cancel = {
                // TODO: Check if this is doing what I think it is
                // Capture this current queueItem, and compare it against the active item in X seconds
                guard a.id == self.active?.id else {
                    return
                }
                self.active?.timedOut()
            }
            
            // Set retry action as per item's retry policy
            if (a.retryPolicy == .reschedule) {
                a.retryBlock = {
                    self.active = nil
                    // TODO: Is this enqueue adding more and more "dispatchNext" calls?
                    self.enqueue(item: a)
                }
            } else if (a.retryPolicy == .retry) {
                a.retryBlock = {
                    //                    it.execute()
                    self.execute(a)
                    // TODO: How to retry within the same context as the rest of the app?
                    // TODO: e.g. enqueue, but at the front of the queue - so the handlers all run?
                    self.dispatchHandler.asyncAfter(deadline: .now() + Double(a.timeout), execute: cancel)
//                    dispatchHandler.postDelayed(cancel, it.timeout * 1000L)
                }
            }
            
            dispatchHandler.asyncAfter(deadline: .now() + Double(a.timeout), execute: cancel)
            execute(a) // TODO: Put timeout in here?
        }
    }
    
    
}
