//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Lucas Chae on 5/16/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your donut flavor", selection: $order.flavor) {
                        ForEach(Order.flavors.indices) {index in
                            Text(Order.flavors[index])
                        }
                    }
                    
                    Stepper("Number of donuts: \(order.quantity)", value: $order.quantity, in: 1...12)
                }
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled.animation())
                    if order.specialRequestEnabled {
                        Toggle("Add extra filling", isOn: $order.extraFilling)
                        Toggle("Add extra sprinkles", isOn: $order.extraSprinkles)
                    }
                }
                
                Section {
                    NavigationLink
                    {
                        AddressView(order: order)
                    } label: {
                        Text("Delivery Address")
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
