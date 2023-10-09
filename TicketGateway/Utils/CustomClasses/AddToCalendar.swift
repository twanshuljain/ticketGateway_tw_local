//
//  AddToCalendar.swift
//  TicketGateway
//
//  Created by Apple on 10/08/23.
//
import EventKit
import UIKit

final class AddToCalendar {
    static let shared: AddToCalendar = AddToCalendar()
    let eventStore: EKEventStore = EKEventStore()
    var title: String?
    var startDate: Date = Date()
    var endDate: Date = Date()
    func addEvent(success: @escaping (Bool, String) -> Void,
                  failure: @escaping (Bool) -> Void) {
        eventStore.requestAccess(to: .event) { [self] (granted, error) in
            if (granted) && (error == nil) {
                print("granted \(granted)")
                let event: EKEvent = EKEvent(eventStore: eventStore)
                print("startDate----", startDate)
                print("endDate----", endDate)
                event.title = title
                event.startDate = startDate
                event.endDate = endDate
                event.notes = "This is a note"
                event.calendar = eventStore.defaultCalendarForNewEvents
                do {
                    try eventStore.save(event, span: .thisEvent)
                    print("Saved Event Successfully")
                } catch let error as NSError {
                    print("failed to save event with error: \(error)")
                }
                print("Saved Event")
                success(true, "")
            } else {
                print("failed to save event with error: \(String(describing: error)) or access not granted")
                navigateToSettings()
                failure(false)
            }
        }
    }
    func askPermission(completion: @escaping EKEventStoreRequestAccessCompletionHandler) {
        eventStore.requestAccess(
            to: .event,
            completion: { granted, error in
                completion(granted, error)
            }
        )
    }
    func navigateToSettings() {
        let alert = UIAlertController(title: "Calendar",
                                      message: "Please enable calendar permission from the settings.",
                                      preferredStyle: .alert)
        let settings = UIAlertAction(title: "Settings",
                                     style: .default,
                                     handler: { _ in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString) ?? URL(fileURLWithPath: ""))
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alert.addAction(settings)
        alert.addAction(cancel)
        DispatchQueue.main.async {
            let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            if let keyWindow = window {
                keyWindow.rootViewController?.present(alert, animated: true)
            }
        }
    }
}
