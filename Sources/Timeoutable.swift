//
//  Timeoutable.swift
//  Dispatchito
//
//  Created by Suresh Joshi on 2018-10-20.
//  Copyright © 2018 Robot Pajamas. All rights reserved.
//

protocol Timeoutable {
    var timeout: Int { get }// ms
    func timedOut()
}
