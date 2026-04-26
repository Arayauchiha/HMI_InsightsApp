import SwiftUI
import Charts

// MARK: - Data Models (Change these → charts update automatically)

struct StabilitySeries: Identifiable {
    let id = UUID()
    let band: String
    let data: [(month: String, value: Double)]
}

let stabilitySeriesData: [StabilitySeries] = [
    StabilitySeries(band: "Band 1", data: [
        ("Jan", 0.15), ("Feb", 0.4), ("Mar", 1.2), ("Apr", 2.5), ("May", 3.2), ("Jun", 2.8), ("Jul", 1.5), ("Aug", 0.8), ("Sep", 1.2), ("Oct", 2.4), ("Nov", 3.5), ("Dec", 4.2)
    ]),
    StabilitySeries(band: "Band 2", data: [
        ("Jan", 0.1), ("Feb", 0.4), ("Mar", 1.3), ("Apr", 3.0), ("May", 3.8), ("Jun", 3.2), ("Jul", 2.0), ("Aug", 1.2), ("Sep", 1.8), ("Oct", 3.0), ("Nov", 4.0), ("Dec", 4.8)
    ]),
    StabilitySeries(band: "Band 3", data: [
        ("Jan", 0.1), ("Feb", 0.5), ("Mar", 1.5), ("Apr", 3.5), ("May", 4.5), ("Jun", 3.8), ("Jul", 2.5), ("Aug", 1.5), ("Sep", 2.2), ("Oct", 3.5), ("Nov", 4.5), ("Dec", 5.5)
    ])
]

struct CycleStabilityModel {
    static let rawData: [(month: String, lengths: [Double])] = [
        ("Jan", [23.5, 24, 24.5, 24]),
        ("Feb", [23, 25, 24, 26]),
        ("Mar", [22, 26, 28, 24, 30]),
        ("Apr", [20, 28, 32, 24, 34, 26]),
        ("May", [21, 27, 31, 25, 33]),
        ("Jun", [22, 26, 29, 24, 31]),
        ("Jul", [23, 25, 28, 26]),
        ("Aug", [24, 24, 27, 25]),
        ("Sep", [23, 25, 26, 24]),
        ("Oct", [22, 26, 28, 25, 30]),
        ("Nov", [21, 27, 29, 24, 32]),
        ("Dec", [20, 28, 31, 25, 33])
    ]

    static var stabilityScore: Int {
        let all = rawData.flatMap { $0.lengths }
        let n = Double(all.count)
        let mean = all.reduce(0, +) / n
        let variance = all.map { ($0 - mean) * ($0 - mean) }.reduce(0, +) / n
        let cv = sqrt(variance) / mean
        return max(0, min(100, Int((1 - cv) * 100)))
    }
}

struct WeightEntry: Identifiable {
    let id = UUID()
    let month: String
    let kg: Double
}

let weightData: [WeightEntry] = [
    WeightEntry(month: "Jan", kg: 30),
    WeightEntry(month: "Feb", kg: 38),
    WeightEntry(month: "Mar", kg: 35),
    WeightEntry(month: "Apr", kg: 70),
    WeightEntry(month: "May", kg: 55),
    WeightEntry(month: "Jun", kg: 48),
    WeightEntry(month: "Jul", kg: 52),
    WeightEntry(month: "Aug", kg: 65),
    WeightEntry(month: "Sep", kg: 58),
    WeightEntry(month: "Oct", kg: 45),
    WeightEntry(month: "Nov", kg: 50),
    WeightEntry(month: "Dec", kg: 48)
]

struct SymptomEntry: Identifiable {
    let id = UUID()
    let name: String
    let percentage: Double
    let color: String
    let fadeColor: String
}

let symptomData: [SymptomEntry] = [
    SymptomEntry(name: "Bloating", percentage: 31, color: "B4A8DA", fadeColor: "F5F2FF"),
    SymptomEntry(name: "Fatigue", percentage: 21, color: "E99597", fadeColor: "FFE4E4"),
    SymptomEntry(name: "Acne", percentage: 17, color: "6E8C82", fadeColor: "ECFFF9"),
    SymptomEntry(name: "Mood", percentage: 30, color: "F4C3C4", fadeColor: "FFF1F1")
]

struct CycleTrendEntry: Identifiable {
    let id: Int
    let month: String
    let totalDays: Int
    let follicularDays: Int
    let ovulationDays: Int
    let lutealDays: Int
    let periodDays: Int
    let postPeriodDays: Int
}

let cycleTrendData: [CycleTrendEntry] = [
    CycleTrendEntry(id: 0, month: "Jan", totalDays: 28, follicularDays: 8, ovulationDays: 6, lutealDays: 8, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 1, month: "Feb", totalDays: 30, follicularDays: 14, ovulationDays: 7, lutealDays: 3, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 2, month: "Mar", totalDays: 28, follicularDays: 6, ovulationDays: 8, lutealDays: 6, periodDays: 5, postPeriodDays: 3),
    CycleTrendEntry(id: 3, month: "Apr", totalDays: 32, follicularDays: 10, ovulationDays: 9, lutealDays: 6, periodDays: 7, postPeriodDays: 0),
    CycleTrendEntry(id: 4, month: "May", totalDays: 28, follicularDays: 11, ovulationDays: 6, lutealDays: 5, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 5, month: "Jun", totalDays: 28, follicularDays: 7, ovulationDays: 7, lutealDays: 8, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 6, month: "Jul", totalDays: 29, follicularDays: 9, ovulationDays: 8, lutealDays: 6, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 7, month: "Aug", totalDays: 27, follicularDays: 5, ovulationDays: 7, lutealDays: 9, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 8, month: "Sep", totalDays: 30, follicularDays: 13, ovulationDays: 6, lutealDays: 5, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 9, month: "Oct", totalDays: 28, follicularDays: 8, ovulationDays: 7, lutealDays: 7, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 10, month: "Nov", totalDays: 31, follicularDays: 12, ovulationDays: 8, lutealDays: 5, periodDays: 6, postPeriodDays: 0),
    CycleTrendEntry(id: 11, month: "Dec", totalDays: 28, follicularDays: 7, ovulationDays: 7, lutealDays: 8, periodDays: 6, postPeriodDays: 0)
]

struct LifestyleEntry: Identifiable {
    let id = UUID()
    let category: String
    let color: String
    let fadeOpacity: Double
    let blocks: [Double]
}

struct LifestylePoint: Identifiable {
    let id = UUID()
    let category: String
    let index: Int
    let value: Double
    let color: String
    let fadeOpacity: Double
}

let lifestyleData: [LifestyleEntry] = [
    LifestyleEntry(category: "Sleep", color: "9A84E8", fadeOpacity: 0.34, blocks: [0.9, 0.85, 0.8, 0.75, 0.9, 0.85, 0.0, 0.0]),
    LifestyleEntry(category: "Hydrate", color: "5A756D", fadeOpacity: 0.56, blocks: [0.3, 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]),
    LifestyleEntry(category: "Caffeine", color: "D87F81", fadeOpacity: 0.38, blocks: [0.6, 0.55, 0.5, 0.45, 0.0, 0.0, 0.0, 0.0]),
    LifestyleEntry(category: "Exercise", color: "B4A8DA", fadeOpacity: 0.52, blocks: [0.35, 0.3, 0.25, 0.0, 0.0, 0.0, 0.0, 0.0])
]

// MARK: - Main View

struct InsightsView: View {
    var body: some View {
        NavigationStack {
            ZStack {

                Color(hex: "F5FAF9").ignoresSafeArea()

                GeometryReader { geo in
                    Circle()
                        .fill(Color(hex: "E99597").opacity(0.18))
                        .frame(width: 156, height: 156)
                        .blur(radius: 60)
                        .position(x: geo.size.width * 0.7, y: 180)
                }
                .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 32) {
                        Section {
                            StabilitySummaryCard()
                        } header: {
                            Text("Stability Summary")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }

                        Section {
                            CycleTrendsSection()
                        } header: {
                            Text("Cycle Trends")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }

                        Section {
                            MetabolicTrendsCard()
                        } header: {
                            Text("Body & Metabolic Trends")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }

                        Section {
                            BodySignalsCard()
                        } header: {
                            Text("Body Signals")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }

                        Section {
                            LifestyleImpactCard()
                        } header: {
                            Text("Lifestyle Impact")
                                .font(.title2.bold())
                                .foregroundColor(.black)
                        }

                        Color.clear.frame(height: 100)
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 20)
                }
            }
            .navigationTitle("Insights")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Image(systemName: "circle.grid.2x2.fill")
                        .font(.system(size: 18))
                        .foregroundColor(Color(hex: "B4A8DA"))
                }
            }
        }
    }
}

// MARK: - 1. Stability Summary (Stacked Area Chart)

struct StabilitySummaryCard: View {
    private let score = CycleStabilityModel.stabilityScore

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("Based on your recent logs and symptom patterns.")
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(Color(hex: "7C7C7C"))
                .lineSpacing(4)

            VStack(alignment: .leading, spacing: 2) {
                Text("Stability Score")
                    .font(.system(size: 22, weight: .regular))
                    .foregroundColor(.black)
                Text("\(Int(score))%")
                    .font(.system(size: 38, weight: .bold))
                    .foregroundColor(.black)
            }

            StabilityStackedAreaChart()
                .frame(height: 200)
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.04), radius: 15, x: 0, y: 10)
    }
}

struct StabilityStackedAreaChart: View {
    var body: some View {
        Chart(stabilitySeriesData) { series in
            ForEach(series.data, id: \.month) { point in
                AreaMark(
                    x: .value("Month", point.month),
                    y: .value("Value", point.value),
                    stacking: .standard
                )
                .interpolationMethod(.catmullRom)
                .foregroundStyle(by: .value("Band", series.band))
            }
        }
        .chartForegroundStyleScale([
            "Band 1": Color(hex: "B4A8DA").opacity(0.6),
            "Band 2": Color(hex: "B4A8DA").opacity(0.4),
            "Band 3": Color(hex: "B4A8DA").opacity(0.25)
        ])
        .chartLegend(.hidden)
        .chartScrollableAxes(.horizontal)
        .chartXVisibleDomain(length: 4)
        .chartXScale(range: .plotDimension(startPadding: 0, endPadding: 0))
        .chartXAxis {
            AxisMarks { value in
                AxisValueLabel {
                    if let m = value.as(String.self) {
                        Text(m)
                            .font(.system(size: 13, weight: m == "Mar" ? .bold : .regular))
                            .foregroundColor(m == "Mar" ? .black : .gray)
                    }
                }
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [0, 4, 8, 12]) { value in
                AxisGridLine(stroke: StrokeStyle(lineWidth: 0.5))
                    .foregroundStyle(Color.gray.opacity(0.2))
                AxisValueLabel {
                    if let v = value.as(Int.self) {
                        Text("\(24 + v)d")
                            .font(.system(size: 12))
                            .foregroundStyle(Color.gray)
                    }
                }
            }
        }
        .overlay(alignment: .center) {

            GeometryReader { geo in
                let xPos = geo.size.width * 0.45

                Path { path in
                    path.move(to: CGPoint(x: xPos, y: 0))
                    path.addLine(to: CGPoint(x: xPos, y: geo.size.height - 22))
                }
                .stroke(Color.black.opacity(0.6), style: StrokeStyle(lineWidth: 2, dash: [4, 3]))

                Circle()
                    .fill(Color(hex: "6E8C82"))
                    .frame(width: 8, height: 8)
                    .position(x: xPos, y: geo.size.height * 0.5)

                StabilityTooltip()
                    .position(x: xPos, y: geo.size.height * 0.5 - 35)
            }
        }
    }
}

struct StabilityTooltip: View {
    var body: some View {
        VStack(spacing: 0) {
            Text("Stability\nImproving")
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.black)
                .cornerRadius(10)

            Triangle()
                .fill(Color.black)
                .frame(width: 12, height: 6)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.closeSubpath()
        return path
    }
}

// MARK: - 2. Cycle Trends (Stacked Capsules)

struct CycleTrendsSection: View {
    @State private var currentIndex: Int = 0
    private let maxBarHeight: CGFloat = 32 * 7
    private let barWidth: CGFloat = 58

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            ZStack {

                VStack(spacing: 0) {
                    Spacer()
                    ForEach(0..<4, id: \.self) { _ in
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 0.5, dash: [4, 4]))
                            .foregroundColor(Color.gray.opacity(0.1))
                            .frame(height: 0.5)
                        Spacer()
                    }
                }
                .frame(height: maxBarHeight)
                .padding(.top, 24)
                .padding(.horizontal, 24)

                ScrollViewReader { proxy in
                    ZStack {

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(cycleTrendData) { entry in
                                    CycleCapsule(entry: entry)
                                        .frame(width: barWidth)
                                        .id(entry.id)
                                }
                            }
                            .padding(.horizontal, 24)
                        }

                        .onAppear {
                            proxy.scrollTo(0, anchor: .leading)
                        }

                        HStack {

                            Button(action: {
                                if currentIndex > 0 {
                                    currentIndex -= 1
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        proxy.scrollTo(currentIndex, anchor: .leading)
                                    }
                                }
                            }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "B4A8DA"))
                                    .frame(width: 38, height: 38)
                                    .background(
                                        Circle()
                                            .stroke(Color(hex: "B4A8DA"), lineWidth: 2.5)
                                    )
                                    .background(Color(UIColor.systemBackground).opacity(0.8))
                                    .clipShape(Circle())
                            }
                            .opacity(currentIndex == 0 ? 0.2 : 1.0)

                            Spacer()

                            Button(action: {
                                if currentIndex < cycleTrendData.count - 1 {
                                    currentIndex += 1
                                    withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                                        proxy.scrollTo(currentIndex, anchor: .leading)
                                    }
                                }
                            }) {
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundColor(Color(hex: "B4A8DA"))
                                    .frame(width: 38, height: 38)
                                    .background(
                                        Circle()
                                            .stroke(Color(hex: "B4A8DA"), lineWidth: 2.5)
                                    )
                                    .background(Color(UIColor.systemBackground).opacity(0.8))
                                    .clipShape(Circle())
                            }
                            .opacity(currentIndex >= cycleTrendData.count - 1 ? 0.2 : 1.0)
                        }
                        .padding(.horizontal, 8)
                        .allowsHitTesting(true)
                    }
                }
            }
        }
        .padding(.vertical, 20)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

struct CycleCapsule: View {
    let entry: CycleTrendEntry
    private let barWidth: CGFloat = 22
    private let scale: CGFloat = 7
    private let maxTotalDays: CGFloat = 32

    private var barHeight: CGFloat {
        CGFloat(entry.totalDays) * scale
    }

    private var maxBarHeight: CGFloat {
        maxTotalDays * scale
    }

    var body: some View {
        VStack(spacing: 0) {

            Text("\(entry.totalDays)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.black)
                .padding(.bottom, 6)

            VStack(spacing: 0) {
                Spacer(minLength: 0)

                ZStack(alignment: .top) {

                    Capsule()
                        .fill(Color(hex: "B4A8DA"))
                        .frame(width: barWidth, height: barHeight)

                    Capsule()
                        .fill(Color(hex: "6E8C82"))
                        .frame(width: barWidth, height: CGFloat(entry.ovulationDays) * scale)
                        .offset(y: CGFloat(entry.follicularDays) * scale)

                    Capsule()
                        .fill(Color(hex: "E99597"))
                        .frame(width: barWidth, height: CGFloat(entry.periodDays) * scale)
                        .offset(y: CGFloat(entry.totalDays - entry.periodDays - entry.postPeriodDays) * scale)

                    PhaseIndicatorBadge(icon: "sun.max", color: Color(hex: "6E8C82"))
                        .offset(y: CGFloat(entry.follicularDays) * scale + (CGFloat(entry.ovulationDays) * scale) / 2 - 9)

                    PhaseIndicatorBadge(icon: "drop", color: Color(hex: "E99597"))
                        .offset(y: CGFloat(entry.totalDays - entry.periodDays - entry.postPeriodDays) * scale + (CGFloat(entry.periodDays) * scale) / 2 - 9)
                }
                .frame(height: barHeight)
            }
            .frame(height: maxBarHeight)

            Text(entry.month)
                .font(.system(size: 13))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
    }
}

struct PhaseIndicatorBadge: View {
    let icon: String
    let color: Color

    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 8, weight: .medium))
            .foregroundColor(.white.opacity(0.9))
            .frame(width: 18, height: 18)
            .background(
                Capsule()
                    .fill(Color.white.opacity(0.2))
            )
            .overlay(
                Capsule()
                    .strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
            )
    }
}

// MARK: - 3. Body & Metabolic Trends (Area + Line + Point Chart)

struct MetabolicTrendsCard: View {
    @State private var selection: String = "Monthly"

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            MetabolicHeader(selection: $selection)

            ScrollView(.horizontal, showsIndicators: false) {
                MetabolicChart()
                    .frame(width: CGFloat(weightData.count) * 70)
                    .frame(height: 200)
            }
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

struct MetabolicHeader: View {
    @Binding var selection: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Your weight")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text("in kg")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            Spacer()

            HStack(spacing: 8) {

                Button(action: { selection = "Monthly" }) {
                    Text("Monthly")
                        .font(.system(size: 13, weight: .semibold))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == "Monthly" ? Color.black : Color.gray.opacity(0.1))
                        .foregroundColor(selection == "Monthly" ? .white : .gray)
                        .cornerRadius(12)
                }

                Button(action: { selection = "Weekly" }) {
                    Text("Weekly")
                        .font(.system(size: 13, weight: .semibold))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(selection == "Weekly" ? Color.black : Color.gray.opacity(0.1))
                        .foregroundColor(selection == "Weekly" ? .white : .gray)
                        .cornerRadius(12)
                }
            }
        }
    }
}

struct MetabolicChart: View {
    private let salmon = Color(hex: "E99597")

    var body: some View {
        let gradient = LinearGradient(
            colors: [salmon.opacity(0.4), salmon.opacity(0.0)],
            startPoint: .top,
            endPoint: .bottom
        )

        Chart(weightData) { item in
            AreaMark(
                x: .value("Month", item.month),
                yStart: .value("Base", 25),
                yEnd: .value("Weight", item.kg)
            )
            .foregroundStyle(gradient)
            .interpolationMethod(.catmullRom)

            LineMark(
                x: .value("Month", item.month),
                y: .value("Weight", item.kg)
            )
            .foregroundStyle(salmon)
            .lineStyle(StrokeStyle(lineWidth: 3))
            .interpolationMethod(.catmullRom)

            PointMark(
                x: .value("Month", item.month),
                y: .value("Weight", item.kg)
            )
            .symbol {
                Circle()
                    .fill(salmon)
                    .frame(width: 8, height: 8)
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
            }
        }
        .chartYScale(domain: 25...80)
        .chartXAxis {
            AxisMarks { _ in
                AxisValueLabel()
                    .font(.system(size: 11, weight: .medium))
                    .foregroundStyle(.gray.opacity(0.8))
            }
        }
        .chartYAxis {
            AxisMarks(position: .leading, values: [25, 50, 75]) { value in
                AxisGridLine(stroke: StrokeStyle(lineWidth: 1, dash: [3]))
                    .foregroundStyle(Color.gray.opacity(0.15))
                AxisValueLabel {
                    if let v = value.as(Int.self) {
                        Text("\(v)")
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
    }
}

// MARK: - 4. Body Signals / Symptom Donut

struct BodySignalsCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            VStack(alignment: .leading, spacing: 4) {
                Text("Symptom Trends")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.black)
                Text("Compared to last cycle")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }

            SymptomDonutChart()
                .frame(height: 300)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

struct SymptomDonutChart: View {
    private struct SectorGradient: Identifiable {
        let id: UUID = UUID()
        let entry: SymptomEntry
        let startPoint: UnitPoint
        let endPoint: UnitPoint
        let labelX: CGFloat
        let labelY: CGFloat
    }

    private var sectorConfigs: [SectorGradient] {
        let total = symptomData.reduce(0) { $0 + $1.percentage }
        var cumulative = 0.0
        let labelRadius: CGFloat = 125

        return symptomData.map { entry in
            let startRel = cumulative / total
            let endRel = (cumulative + entry.percentage) / total
            cumulative += entry.percentage

            let startAngle = startRel * 360 - 90
            let endAngle = endRel * 360 - 90
            let midAngle = (startAngle + endAngle) / 2

            let startRad = (startAngle - 15) * .pi / 180
            let endRad = (endAngle + 15) * .pi / 180
            let midRad = midAngle * .pi / 180

            let startP = UnitPoint(x: (cos(startRad) + 1) / 2, y: (sin(startRad) + 1) / 2)
            let endP = UnitPoint(x: (cos(endRad) + 1) / 2, y: (sin(endRad) + 1) / 2)

            return SectorGradient(
                entry: entry,
                startPoint: startP,
                endPoint: endP,
                labelX: cos(midRad) * labelRadius,
                labelY: sin(midRad) * labelRadius
            )
        }
    }

    var body: some View {
        ZStack {
            Chart(sectorConfigs) { config in
                SectorMark(
                    angle: .value("Percentage", config.entry.percentage),
                    innerRadius: .ratio(0.68),
                    angularInset: 0
                )
                .foregroundStyle(
                    LinearGradient(
                        colors: [
                            Color(hex: config.entry.color),
                            Color(hex: config.entry.fadeColor)
                        ],
                        startPoint: config.startPoint,
                        endPoint: config.endPoint
                    )
                )
            }
            .frame(width: 250, height: 250)

            ForEach(sectorConfigs) { config in
                VStack(spacing: 0) {
                    Text("\(Int(config.entry.percentage))%")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                    Text(config.entry.name)
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.gray)
                }
                .frame(width: 62, height: 62)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.12), radius: 10, x: 0, y: 6)
                .offset(x: config.labelX, y: config.labelY)
            }
        }
    }
}

// MARK: - 5. Lifestyle Impact (Heatmap Grid)

struct LifestyleImpactCard: View {
    private func heatmapGradient(point: LifestylePoint) -> LinearGradient {
        let isFirstInPair = point.index % 2 == 0
        let color = Color(hex: point.color).opacity(point.value)
        let baseColor = point.value > 0 ? color : Color(hex: "F4F4F4")
        let fadeColor = point.value > 0 ? color.opacity(point.fadeOpacity) : Color(hex: "F4F4F4")

        return LinearGradient(
            colors: isFirstInPair ? [baseColor, fadeColor] : [fadeColor, baseColor],
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Spacer()
                Menu {
                    Button("1 Month", action: {})
                    Button("3 Months", action: {})
                    Button("4 Months", action: {})
                    Button("Yearly", action: {})
                } label: {
                    HStack(spacing: 4) {
                        Text("4 months")
                            .font(.system(size: 12, weight: .medium))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10))
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .foregroundColor(.black)
                    .cornerRadius(8)
                }
            }

            Text("Correlation Strength")
                .font(.system(size: 16, weight: .semibold))

            VStack(spacing: 20) {
                ForEach(lifestyleData) { entry in
                    HStack(alignment: .center, spacing: 15) {

                        Text(entry.category)
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(.black)
                            .frame(width: 60, alignment: .leading)

                        Chart {
                            let points = entry.blocks.enumerated().map { i, val in
                                LifestylePoint(category: entry.category, index: i, value: val, color: entry.color, fadeOpacity: entry.fadeOpacity)
                            }

                            ForEach(points) { point in
                                RectangleMark(
                                    x: .value("Block", "\(point.index)"),
                                    y: .value("Category", point.category),
                                    width: .ratio(0.8),
                                    height: .fixed(24)
                                )
                                .foregroundStyle(heatmapGradient(point: point))
                                .cornerRadius(8)
                            }
                        }
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                        .frame(height: 24)
                    }
                }
            }
            .padding(.top, 8)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.03), radius: 10, x: 0, y: 5)
    }
}

// MARK: - Helpers

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

#Preview {
    InsightsView()
}
