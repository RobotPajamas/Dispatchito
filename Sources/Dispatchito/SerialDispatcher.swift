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
    private var queue = SynchronizedArray<Dispatchable>()
    private let executionHandler: DispatchQueue
    private let dispatchHandler: DispatchQueue
    private let concurrencyQueue = DispatchQueue(label: "com.robotpajamas.Dispatchito.SerialDispatcher")
    
    private var isStarted: Bool = false
    
    public init(executeOn executeQueue: DispatchQueue = DispatchQueue.main,
                dispatchOn dispatchQueue: DispatchQueue = DispatchQueue.main) {
        self.executionHandler = executeQueue
        self.dispatchHandler = dispatchQueue
    }
    
    // TODO: Put timeout in here?
    private func execute(_ item: Dispatchable) {
        executionHandler.async {
            item.run()
        }
    }
    
    public func start() {
        concurrencyQueue.sync { isStarted = true }
        dispatchNext()
    }
    
    public func stop() {
        concurrencyQueue.sync { isStarted = false }
    }
    
    public func clear() {
        active = nil
        queue.removeAll()
    }
    
    public func count() -> Int {
        return queue.count
    }
    
    public func enqueue(item: Dispatchable) {
        item.addCompletion({
            self.dispatchNext()
        })
        queue.append(item)
        
//        concurrencyQueue.sync {
            if active == nil {
                dispatchNext()
            }
//        }
    }
    
    private func dispatchNext() {
        var result = false
        concurrencyQueue.sync { result = isStarted }
        guard result == true else {
            print ("Not started")
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
                }
            }
            
            dispatchHandler.asyncAfter(deadline: .now() + Double(a.timeout), execute: cancel)
            execute(a)
        }
    }
    
    
}
