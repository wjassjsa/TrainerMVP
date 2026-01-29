import Foundation

struct MockData {
    static let exercises: [Exercise] = [
        Exercise(id: UUID(), name: "Push Up", description: "Classic push-up exercise. Start in plank position and lower your body until chest nearly touches the floor.", mediaName: nil, defaultSets: 3, defaultReps: "8-12", isPremium: false),
        Exercise(id: UUID(), name: "Squat", description: "Bodyweight squat. Stand with feet shoulder-width apart and lower your body.", mediaName: nil, defaultSets: 3, defaultReps: "10-15", isPremium: false),
        Exercise(id: UUID(), name: "Plank", description: "Hold the plank position. Engage core and keep body straight.", mediaName: nil, defaultSets: 3, defaultReps: "30s", isPremium: true),
        Exercise(id: UUID(), name: "Lunges", description: "Step forward and lower your back knee toward the ground.", mediaName: nil, defaultSets: 3, defaultReps: "10 per leg", isPremium: false),
        Exercise(id: UUID(), name: "Burpees", description: "Full body explosive exercise combining squat, plank, and jump.", mediaName: nil, defaultSets: 3, defaultReps: "8-10", isPremium: true)
    ]

    static func simplePlan() -> WorkoutPlan {
        let days = (1...7).map { i -> WorkoutDay in
            let exs = exercises.shuffled().prefix(3).map {
                ExerciseInstance(exercise: $0, sets: $0.defaultSets, reps: $0.defaultReps)
            }
            return WorkoutDay(index: i, title: "Dia \(i)", exercises: Array(exs), completedDate: nil)
        }
        return WorkoutPlan(name: "Plano 7 Dias", durationDays: 7, days: days, isPremium: false)
    }
}
