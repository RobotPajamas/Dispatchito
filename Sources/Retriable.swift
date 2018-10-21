//
//  Retriable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

public enum RetryPolicy {
    case none
    case retry
    case reschedule
}

protocol Retriable {
    
}
