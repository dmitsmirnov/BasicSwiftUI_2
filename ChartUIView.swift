//
//  Chart.swift
//  BaseProject
//
//  Created by user on 12.04.2024.
//

import SwiftUI
import Charts

struct SiteView: Identifiable {
    var id = UUID().uuidString
    var hour: Date
    var views: Double
    var animate: Bool = false
}

struct ChartUIView: View {
    
    @State var sampleAnalicicts: [SiteView] = sample_analytics
    @State var currentActiveItem: SiteView?
    @State var plotWigth: CGFloat = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    AnimatedChart()
                }
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white.shadow(.drop(radius: 2)))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .padding()
            .navigationTitle("Swift Charts")
            
            
        }
    }
    
    
    @ViewBuilder
    func AnimatedChart()->some View {
        
        let max = sample_analytics.max { item1, item2 in
            return item1.views > item2.views
        }?.views ?? 0
        
        Chart {
            ForEach(sampleAnalicicts){ item in
                BarMark(
                    x: .value("Hour", item.hour, unit: .hour),
                    y: .value("views", !item.animate ? item.views : 0)
                )
                .foregroundStyle(Color.green.gradient)
                
                if let currentActiveItem, currentActiveItem.id == item.id {
                    RuleMark(x: .value("Hour", currentActiveItem.hour))
                        .lineStyle(.init(lineWidth: 2, miterLimit: 2, dash: [2]))
                        .offset(x: (plotWigth / CGFloat(sampleAnalicicts.count)) / 2)
                        .annotation(position: .top) {
                            VStack {
                                Text("Views")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                                
                                Text(String(currentActiveItem.views))
                                    .font(.title3.bold())
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 4)
                                    .background {
                                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                                            .fill(.white.shadow(.drop(radius: 2)))
                                    }
                                
                            }
                        }
                }
            }
        }
        .chartYScale(domain: 0...(max + 10000))
        .chartOverlay(content: { proxy in
            
            GeometryReader { innerProxy in
                Rectangle()
                    .fill(.clear).contentShape(Rectangle())
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                let location = value.location
                                
                                if let date: Date = proxy.value(atX: location.x) {
                                    let calendar = Calendar.current
                                    let hour = calendar.component(.hour, from: date)
                                    if let currentItem = sampleAnalicicts.first(where: { item in
                                        calendar.component(.hour, from: item.hour) == hour
                                    }) {
                                        self.currentActiveItem = currentItem
                                        self.plotWigth = proxy.plotSize.width
                                    }
                                }
                            }
                            .onEnded { value in
                                self.currentActiveItem = nil
                            }
                    )
            }
            
        })
        .frame(height: 250)
    }
    
}

#Preview {
    ChartUIView()
}

extension Date {
    func updateHour(value: Int)->Date {
        let calendar = Calendar.current
        return calendar.date(bySettingHour: value, minute: 0, second: 0, of: self) ?? .now
    }
}

var sample_analytics: [SiteView] = [SiteView(hour: Date().updateHour(value: 8), views: 1500),
                                    SiteView(hour: Date().updateHour(value: 9), views: 2500),
                                    SiteView(hour: Date().updateHour(value: 10), views: 3500),
                                    SiteView(hour: Date().updateHour(value: 11), views: 4500),
                                    SiteView(hour: Date().updateHour(value: 12), views: 1500),
                                    SiteView(hour: Date().updateHour(value: 13), views: 2500),
                                    SiteView(hour: Date().updateHour(value: 14), views: 3500),
                                    SiteView(hour: Date().updateHour(value: 15), views: 6500),
                                    SiteView(hour: Date().updateHour(value: 16), views: 7500),
                                    SiteView(hour: Date().updateHour(value: 17), views: 2500),
                                    SiteView(hour: Date().updateHour(value: 18), views: 4500),
                                    SiteView(hour: Date().updateHour(value: 19), views: 3500)]
