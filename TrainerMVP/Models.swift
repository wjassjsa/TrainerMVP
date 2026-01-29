import Foundation

struct UserProfile: Codable {
    var goal: String
    var level: String
    var equipment: [String]
    var availableDays: [Int] // 1..7
}

struct Exercise: Identifiable, Codable {
    let id: UUID
    let name: String
    let description: String
    let mediaName: String? // image or video asset name
    let defaultSets: Int
    let defaultReps: String
    let isPremium: Bool
}

struct ExerciseInstance: Identifiable, Codable {
    let id = UUID()
    let exercise: Exercise
    var sets: Int
    var reps: String
}

struct WorkoutDay: Identifiable, Codable {
    let id = UUID()
    let index: Int
    let title: String
    var exercises: [ExerciseInstance]
    var completedDate: Date?
}

struct WorkoutPlan: Identifiable, Codable {
    let id = UUID()
    var name: String
    var durationDays: Int
    var days: [WorkoutDay]
    var isPremium: Bool
}
