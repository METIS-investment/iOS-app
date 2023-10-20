//
//  EventEmitting.swift
//  Metis
//
//  Created by Veronika Zelinkova on 20.10.2023.
//
import Combine

protocol EventEmitting {
    associatedtype Event

    var eventPublisher: AnyPublisher<Event, Never> { get }
}
