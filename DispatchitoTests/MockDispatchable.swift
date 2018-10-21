//
//  MockDispatchable.swift
//  DispatchitoTests
//
//  Created by Suresh Joshi on 2018-10-21.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

import Dispatchito

class MockDispatchable : Dispatchable {
    
    
    public var id: String = "mockId"
    public var isCancelled: Bool = false
    public var maxRetries: Int = 3
    public var retryPolicy: RetryPolicy = .none
    public var retryBlock: RetryBlock = {}
    public var timeout: Int = 1
    
    func addCompletion(_ completion: @escaping () -> Void) {
        
    }
    
    func run() {
        
    }
    
    
    
    func retry() {
        
    }

    
    func timedOut() {
        isTimedOut = true
    }
    
    // For testing
    var isTimedOut = false
    
//    override val id: String
//    get() = "MockId"
//
//    override fun run() {
//
//    }
//
//    override var isCancelled: Boolean = false
//    override val completions: MutableList<CompletionBlock<*>> = mutableListOf()
//    override val execution: ExecutionBlock<*>
//    get() = {}
//    override var state: State = State.READY
//    override val retryPolicy: RetryPolicy = RetryPolicy.NONE
//    override var retries: Int = 0
//    override val maxRetries: Int = 2
//    override var retry: () -> Unit = {}
//
//    override var timeout: Int = 42
//
//    override fun timedOut() {
//    isTimedOut = true
//    }
//
//    // Test checks
//    var isTimedOut = false
    
}
