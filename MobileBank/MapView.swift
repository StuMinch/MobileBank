//
//  MapView.swift
//  MobileBank
//
//  Created by Stuart Minchington on 5/14/25.
//

import MapKit
import SwiftUI

struct MapView: View {
    let manager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .userLocation(fallback: .automatic)
    @State private var searchText: String = ""
    @State private var storeLocations: [StoreLocation] = []
    @State private var route: MKRoute?

    var body: some View {
        VStack {
            HStack {
                TextField("Enter location", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)
                
                Button(action: {
                    searchForLocation()
                }) {
                    Image(systemName: "magnifyingglass")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                }
                .padding(.trailing)
            }
            .padding()

            Button("Find Closest Store") {
                findClosestStore()
            }
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(8)

            if let route = route {
                Text("Distance: \(String(format: "%.2f", route.distance / 1000)) km")
                    .font(.headline)
                    .padding()
            }

            Map(position: $cameraPosition) {
                UserAnnotation()
                ForEach(storeLocations) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
                if let route = route {
                    MapPolyline(route.polyline)
                        .stroke(Color.blue, lineWidth: 5)
                }
            }
            .mapControls {
                MapUserLocationButton()
            }
            .onAppear {
                manager.requestWhenInUseAuthorization()
                loadStoreLocations() // Load store locations from JSON
            }
        }
        .padding()
    }

    private func loadStoreLocations() {
        if let url = Bundle.main.url(forResource: "stores", withExtension: "json"),
           let data = try? Data(contentsOf: url),
           let decodedStores = try? JSONDecoder().decode([StoreLocation].self, from: data) {
            storeLocations = decodedStores
        }
    }

    private func searchForLocation() {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        let search = MKLocalSearch(request: request)
        
        search.start { response, error in
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            cameraPosition = .region(MKCoordinateRegion(
                center: coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
        }
    }

    private func findClosestStore() {
        guard let userLocation = manager.location else { return }

        var closestStore: StoreLocation?
        var smallestDistance: CLLocationDistance = .greatestFiniteMagnitude

        for store in storeLocations {
            let storeLocation = CLLocation(latitude: store.latitude, longitude: store.longitude)
            let distance = userLocation.distance(from: storeLocation)

            if distance < smallestDistance {
                smallestDistance = distance
                closestStore = store
            }
        }

        if let closestStore = closestStore {
            let closestCoordinate = CLLocationCoordinate2D(latitude: closestStore.latitude, longitude: closestStore.longitude)
            cameraPosition = .region(MKCoordinateRegion(
                center: closestCoordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            ))
            
            // Calculate and draw route
            calculateRoute(to: closestCoordinate)
        }
    }

    private func calculateRoute(to destination: CLLocationCoordinate2D) {
        guard let userLocation = manager.location?.coordinate else { return }

        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: userLocation))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        request.transportType = .automobile

        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let route = response?.routes.first else { return }
            self.route = route
        }
    }
}

#Preview {
    MapView()
}
