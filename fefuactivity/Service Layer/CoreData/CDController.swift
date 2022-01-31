import Foundation

class CDController {
    func fetch() throws -> [CDActivity] {
        let context = FEFUCoreDataContainer.instance.context

        let request = CDActivity.fetchRequest()

        let rawActivities = try context.fetch(request)

        return rawActivities
    }

    func saveActivity(_ distance: String,
                      _ duration: String,
                      _ activityType: String,
                      _ startDate: String,
                      _ startTime: String,
                      _ endTime: String) {

        let context = FEFUCoreDataContainer.instance.context

        let activity = CDActivity(context: context)

        activity.type = activityType
        activity.date = startDate
        activity.distance = distance
        activity.start = startTime
        activity.end = endTime
        activity.duration = duration

        FEFUCoreDataContainer.instance.saveContext()
    }
}
