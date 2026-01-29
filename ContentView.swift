import SwiftUI

struct ContentView: View {
    @State private var plan = MockData.simplePlan()
    @State private var showSubscription = false
    @StateObject private var subscriptionManager = SubscriptionManager()

    var body: some View {
        NavigationView {
            List {
                Section("Seu Plano de Treino") {
                    ForEach(plan.days) { day in
                        NavigationLink(destination: WorkoutDayView(day: binding(for: day))) {
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(day.title).font(.headline)
                                    Text("\(day.exercises.count) exercícios").font(.subheadline).foregroundColor(.secondary)
                                }
                                Spacer()
                                if day.completedDate != nil {
                                    Image(systemName: "checkmark.circle.fill").foregroundColor(.green)
                                } else {
                                    Image(systemName: "circle").foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }

                Section("Biblioteca de Exercícios") {
                    ForEach(MockData.exercises) { ex in
                        NavigationLink(destination: ExerciseDetailView(exercise: ex)) {
                            HStack {
                                Image(systemName: "dumbbell.fill").foregroundColor(.blue)
                                VStack(alignment: .leading) {
                                    Text(ex.name).font(.headline)
                                    Text(ex.description).font(.caption).foregroundColor(.secondary).lineLimit(1)
                                }
                                Spacer()
                                if ex.isPremium && !subscriptionManager.isSubscribed {
                                    Text("Premium").font(.caption2).foregroundColor(.orange).padding(4).overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.orange))
                                }
                            }
                        }
                    }
                }

                Section {
                    Button(action: { showSubscription = true }) {
                        Text("🔓 Desbloquear Premium")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
            }
            .navigationTitle("TrainerMVP")
            .sheet(isPresented: $showSubscription) {
                SubscriptionView(isPresented: $showSubscription, subscriptionManager: subscriptionManager)
            }
        }
    }

    private func binding(for day: WorkoutDay) -> Binding<WorkoutDay> {
        guard let idx = plan.days.firstIndex(where: { $0.id == day.id }) else {
            fatalError("Day not found")
        }
        return $plan.days[idx]
    }
}

struct SubscriptionView: View {
    @Binding var isPresented: Bool
    @ObservedObject var subscriptionManager: SubscriptionManager

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Premium Unlocked")
                    .font(.title).bold()

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Image(systemName: "star.fill").foregroundColor(.orange)
                        Text("Acesso a todos os exercícios Premium")
                    }
                    HStack {
                        Image(systemName: "star.fill").foregroundColor(.orange)
                        Text("Planos personalizados avançados")
                    }
                    HStack {
                        Image(systemName: "star.fill").foregroundColor(.orange)
                        Text("Sem anúncios")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)

                Text("R$9,99/mês ou R$79,99/ano")
                    .font(.headline)

                Button(action: {
                    subscriptionManager.startFreeTrial()
                    isPresented = false
                }) {
                    Text("Começar Teste Grátis (7 dias)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }

                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Fechar") { isPresented = false }
                }
            }
        }
    }
}
