import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static values = { latitude: Number, longitude: Number, title: String };
    static outlets = [ "edit-form" ]

    editFormOutletConnected(outlet, element) {
        this.listener = this.map.addListener('click', event => this.placeMarker(event.latLng, this.map));
    }

    editFormOutletDisconnected(outlet, element) {
        this.listener.remove();
    }

    initMap() {
        var lat = this.latitudeValue
        var lng = this.longitudeValue

        this.map = new google.maps.Map(this.element, {
            zoom: 13,
            center: {
                lat: lat,
                lng: lng
            }
        });

        var position = new google.maps.LatLng(lat, lng);
        this.currentMarker = new google.maps.Marker({
            position: position,
            map: this.map
        });
    }

    placeMarker(latLng, map) {
        if (this.currentMarker) {
            this.currentMarker.setMap(null);
        }

        this.currentMarker = new google.maps.Marker({
            position: latLng,
            map: map
        });

        this.updateLocationFields(latLng);
    }

    updateLocationFields(latLng) {
        const latField = document.getElementById('latitude');
        const lngField = document.getElementById('longitude');

        if (!latField || !lngField) {
            return;
        }

        latField.value = latLng.lat().toFixed(6); // Fixed to 6 decimal places
        lngField.value = latLng.lng().toFixed(6);
    }

    connect() {
        this.initMap()
    }
}
