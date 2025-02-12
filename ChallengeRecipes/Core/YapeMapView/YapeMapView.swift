//
//  YapeMapView.swift
//  ChallengeRecipes
//
//  Created by Luis Chavez pozo on 11/02/25.
//
import MapKit

@MainActor
protocol YapeMapView: UIView {
    func setLocation(_ location: CLLocationCoordinate2D, animated: Bool)
    func addMarker(at location: CLLocationCoordinate2D, title: String?)
}

class YapeMapViewDefault: UIView, YapeMapView {
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.mapType = .standard
        return mapView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupMapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLocation(_ location: CLLocationCoordinate2D, animated: Bool) {
        let region = MKCoordinateRegion(
            center: location,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
        mapView.setRegion(region, animated: animated)
    }
    
    func addMarker(at location: CLLocationCoordinate2D, title: String?) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
}

private extension YapeMapViewDefault {
    func setupUI() {
        setupMapView()
    }
    
    private func setupMapView() {
        addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: topAnchor),
            mapView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
