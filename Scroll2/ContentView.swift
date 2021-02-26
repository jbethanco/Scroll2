//
//  ContentView.swift
//  Scroll2
//
//  Created by John Bethancourt on 2/25/21.
//

import SwiftUI

struct ContentView: View {
    
    private struct ScrollOffsetPreferenceKey: PreferenceKey {
        static var defaultValue: CGPoint = .zero
        static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
    }
    
    @State var xOffset: CGFloat = 0
    
    let personColumnWidth: CGFloat = 200
    let eventIDWidth: CGFloat = 190
    let headerHeight: CGFloat = 32
    
    var body: some View {
        VStack{
            HStack{
                Rectangle()
                    .frame(width: eventIDWidth)
                    .foregroundColor(.yellow)
                 ScrollView(.horizontal, showsIndicators: false) {
                    
                    HStack{
                        //foreach person name
                        Text("Person 1")
                            .frame(width: personColumnWidth)
                        Text("Person 2")
                            .frame(width: personColumnWidth)
                        Text("Person 3")
                            .frame(width: personColumnWidth)
                        Text("Person 4")
                            .frame(width: personColumnWidth)
                    }.offset(x: xOffset - eventIDWidth)
                    
               }
              }
            .clipShape(
               Rectangle()
                .offset(x: eventIDWidth)
            )
            .overlay(
                HStack{
                    Text("EVENT COLUMN TITLE")
                        .frame(width:eventIDWidth)
                    Spacer()
                }
                
            )
            .frame(height: headerHeight)
            HStack{
                
                ScrollView{
                    HStack{
                        VStack{
                            ForEach((1...100), id: \.self) {
                                // foreach eventID
                                Text("EVENT ID \($0)")
                            }
                        }
                        
                        .frame(width: eventIDWidth)
                        .background(Color.blue)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            // for each person column
                            HStack{
                                VStack{
                                    //foreach eventID
                                    ForEach((1...100), id: \.self) {
                                        Text("P1 Stepper \($0)")
                                    }
                                }
                                .frame(width: personColumnWidth)
                                .background(Color.red)
                                
                                VStack{
                                    ForEach((1...100), id: \.self) {
                                        Text("P2 Stepper \($0)")
                                    }
                                }
                                .frame(width:personColumnWidth)
                                .background(Color.red)
                                
                                VStack{
                                    ForEach((1...100), id: \.self) {
                                        Text("P3 Stepper \($0)")
                                    }
                                }
                                .frame(width:personColumnWidth)
                                .background(Color.red)
                                
                                VStack{
                                    ForEach((1...100), id: \.self) {
                                        Text("P4 Stepper \($0)")
                                    }
                                }
                                .frame(width:personColumnWidth)
                                .background(Color.red)
                            }
                            .background (
                                GeometryReader {
                                    geometry in
                                    Color.clear
                                        .preference(key: ScrollOffsetPreferenceKey.self,
                                                    value: geometry.frame(in: .named("scrollView")).origin
                                        )
                                }
                            )
                            
                        }.onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
                        
                    }
                    
                }
                
            }
        }
        
    }
    func offsetChanged(point: CGPoint) {
        xOffset = point.x
        print(point)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
