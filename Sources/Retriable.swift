//
//  Retriable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public typealias RetryBlock = () -> Void

public enum RetryPolicy {
    case none
    case retry
    case reschedule
}

protocol Retriable {
    var maxRetries: Int { get set }
    var retryPolicy: RetryPolicy { get set }
//    var retries: Int { get set }
    var retryBlock: RetryBlock { get set }
    mutating func retry()
}

//extension Retriable {
//    mutating func retry() {
//        retries += 1
//        retryBlock()
//    }
//}
