import SwiftUI

struct ExerciseDetailView: View {
    let exercise: Exercise

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Placeholder for image/video
                Rectangle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ))
                    .frame(height: 240)
                    .overlay(
                        VStack {
                            Image(systemName: "video.fill").font(.system(size: 40)).foregroundColor(.white)
                            Text("Demonstração em vídeo").foregroundColor(.white).font(.caption)
                        }
                    )
                    .cornerRadius(8)

                Text(exercise.name)
                    .font(.title2).bold()

                Text(exercise.description)
                    .foregroundColor(.secondary)

                Divider()

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Series").bold()
                        Spacer()
                        Text("\(exercise.defaultSets)")
                    }
                    HStack {
                        Text("Repetições").bold()
                        Spacer()
                        Text(exercise.defaultReps)
                    }
                    HStack {
                        Text("Dificuldade").bold()
                        Spacer()
                        Text(exercise.isPremium ? "Avançado" : "Iniciante").foregroundColor(exercise.isPremium ? .orange : .green)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

                Spacer()
            }
            .padding()
        }
        .navigationTitle(exercise.name)
    }
}
