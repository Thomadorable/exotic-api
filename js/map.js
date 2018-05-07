const APIKEY = 'AIzaSyDaRd_kdSXbVX7ewzWK82F8ujPSf5py2sg';


// TODO : remove this test
// navigator.geolocation.getCurrentPosition = function (callback) {
//     let position = {};
//     position.coords = {};
//     position.coords.latitude = 48.8077711;
//     position.coords.longitude = 2.3673933;
//     callback(position);
// }


function generateMap() {
    // Init map in center of Paris
    mapp.map = new google.maps.Map($('.map')[0], {
        zoom: 13,
        center: {
            lat: 48.8537, // Center of Paris
            lng: 2.3418 // Center of Paris
        }
    });

    // Close info window
    mapp.map.addListener('click', function () {
        mapp.infowindow.close();
    });

    mapp.infowindow = new google.maps.InfoWindow();

    getUserLocation();
}

function getUserLocation() {
    navigator.geolocation.getCurrentPosition(function (position) {
        mapp.loading = 0;
        mapp.lat = position.coords.latitude;
        mapp.lng = position.coords.longitude;

        mapp.map.panTo({
            lat: mapp.lat,
            lng: mapp.lng
        });

        getNamePosition();
        getShopList();
    });
}

function getNamePosition() {
    let posDatasURL = 'https://maps.googleapis.com/maps/api/geocode/json?key=' + APIKEY;
    posDatasURL += '&latlng=' + mapp.lat + ',' + mapp.lng;

    $.get(posDatasURL, function (data) {
        let location = data.results[0].address_components;
        let city = null;
        let area = null;

        for (let i = 0; i < location.length; i++) {
            if (location[i].types[0] === 'locality') {
                city = location[i].long_name;
            }
            if (location[i].types[0] === 'administrative_area_level_1') {
                area = location[i].long_name;
            }
        }

        $('.search-input').text(area + ' - ' + city);
    });
}

function generateMarkers(locations, zoom = false) {
    let bounds  = new google.maps.LatLngBounds();
    mapp.listBoutiques.push(...locations);
    
    for (let index = 0; index < locations.length; index++) {
        const boutique = locations[index];
        let newMarker = new google.maps.Marker({
            position: {
                lat: boutique.lat,
                lng: boutique.lng
            },
            map: mapp.map,
            // animation: google.maps.Animation.DROP,
            title: '#' + boutique.id_boutique + ' ' + boutique.nom,
            idBoutique: boutique.id_boutique
        });

        mapp.markers.push(newMarker);

        newMarker.addListener('click', function () {
            openModal(this);
        });

        loc = new google.maps.LatLng(newMarker.position.lat(), newMarker.position.lng());
        bounds.extend(loc);
    }
    if (zoom && zoom === true) {
        setTimeout(function(){
            console.log('autozoom !');
            mapp.map.fitBounds(bounds);
        }, 200);
    }
}

function openModal (marker) {
    mapp.map.panTo(marker.getPosition());

    mapp.infowindow.setContent(
        '<style>div.content {color: orange} </style><div class="content"><a href="boutique.html?id=' + marker.idBoutique + '" style="font-size:12px">' + marker.title + '</a></div>'
    );
    
    mapp.infowindow.open(mapp.map, marker);
}

var mapp = new Vue({
    el: '#app-map',
    data: {
        loading: 1,
        location: 'Vous êtes situé...',
        listBoutiques: [],
        markers: [],
        limit: 0
    },
    methods: {
        initMap: function () {
            if ("geolocation" in navigator) {
                generateMap();

                
            } else {
                this.location = 'La géolocalisation n\'est pas disponible';
                this.loading = 0;
            }
        },
        hoverBoutique: function (event) {
            event.preventDefault();
            let target = event.target;
            if (!$(target).hasClass('result')) {
                target = $(target).closest('.result')[0];
            }
            let id = target.getAttribute('data-id');
            openModal(mapp.markers[id]);
        },
        seeMore: function(event){
            event.preventDefault();
            getShopList();
        }
    }
});