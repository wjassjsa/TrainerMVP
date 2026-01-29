import SwiftUI

struct WorkoutDayView: View {
    @Binding var day: WorkoutDay
    @State private var showComplete = false

    var body: some View {
        List {
            ForEach($day.exercises) { $instance in
                NavigationLink(destination: ExerciseDetailView(exercise: instance.exercise)) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(instance.exercise.name).font(.headline)
                            Text("\(instance.sets)x \(instance.reps)").font(.subheadline).foregroundColor(.secondary)
                        }
                        Spacer()
                        Image(systemName: "chevron.right").foregroundColor(.gray)
                    }
                }
            }

            Section {
                Button(action: completeDay) {
                    HStack {
                        Image(systemName: day.completedDate == nil ? "circle" : "checkmark.circle.fill")
                            .foregroundColor(day.completedDate == nil ? .gray : .green)
                        Text(day.completedDate == nil ? "Marcar como feito" : "Concluído: \(formatDate(day.completedDate!))")
                        Spacer()
                    }
                }
            }
        }
        .navigationTitle(day.title)
    }

    func completeDay() {
        if day.completedDate == nil {
            day.completedDate = Date()
        } else {
            day.completedDate = nil
        }
    }

    func formatDate(_ date: Date) -> String {
        let f = DateFormatter()
        f.dateStyle = .short
        return f.string(from: date)
    }
}
