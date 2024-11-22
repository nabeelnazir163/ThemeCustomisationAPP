//
//  Bindable.swift
//  ThemeCustomisationApp
//
//  Created by Nabeel Nazir on 22/11/2024.
//

import Foundation

class Bindable<T> {
	var value: T {
		didSet {
			observers.forEach { observer in
				observer.value(value)
			}
		}
	}

	// Use a struct to track the observer and its identifier
	private var observers = [Observer<T>]()
	private var nextID = 0

	init(_ value: T) {
		self.value = value
	}

	// Bind the observer to the value and return an ID for unbinding
	@discardableResult
	func bind(_ observer: @escaping (T) -> Void) -> Int {
		let id = nextID
		nextID += 1
		observers.append(Observer(id: id, value: observer))
		observer(value) // Call observer with current value immediately
		return id
	}

	// Unbind the observer using its ID
	func unbind(id: Int) {
		observers.removeAll { $0.id == id }
	}

	// Helper struct to track each observer
	private struct Observer<U> {
		let id: Int
		let value: (U) -> Void
	}
}
