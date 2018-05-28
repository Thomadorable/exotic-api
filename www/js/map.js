const APIKEY = 'AIzaSyDaRd_kdSXbVX7ewzWK82F8ujPSf5py2sg';
const tokenMaps = 'AIzaSyB4_D-KNKcJlgMwy0TZjkgzLBBz6O3DT5k';


// TODO : remove this test
navigator.geolocation.getCurrentPosition = function (callback) {
    var position = {};
    position.coords = {};
    position.coords.latitude = 48.8077711;
    position.coords.longitude = 2.3673933;
    callback(position);
}


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
    var posDatasURL = 'https://maps.googleapis.com/maps/api/geocode/json?key=' + APIKEY;
    posDatasURL += '&latlng=' + mapp.lat + ',' + mapp.lng;

    $.get(posDatasURL, function (data) {
        var location = data.results[0].address_components;
        var city = null;
        var area = null;
        var postal = null;

        for (var i = 0; i < location.length; i++) {
            if (location[i].types[0] === 'locality') {
                city = location[i].long_name;
            }
            if (location[i].types[0] === 'administrative_area_level_1') {
                area = location[i].long_name;
            }

            if (location[i].types[0] === 'postal_code') {
                postal = location[i].long_name;
            }
        }

        $('.located').text(area + ' - ' + city + ' (' + postal + ')');
    });
}

function generateMarkers(locations, zoom = false) {
    var bounds  = new google.maps.LatLngBounds();
    mapp.listBoutiques.push(...locations);
    
    for (var index = 0; index < locations.length; index++) {
        const boutique = locations[index];
        var newMarker = new google.maps.Marker({
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
    if (zoom && zoom === true && mapp.markers.length > 1) {
        setTimeout(function(){
            mapp.map.fitBounds(bounds);
        }, 200);
    }
}

function openModal (marker) {
    mapp.map.panTo(marker.getPosition());

    mapp.infowindow.setContent(
        '<style>div.content {color: orange} </style><div class="content"><a href="boutique-' + marker.idBoutique + '.html" style="font-size:12px">' + marker.title + '</a></div>'
    );
    
    mapp.infowindow.open(mapp.map, marker);
}

if ($('#app-map').length > 0) {
    var mapp = new Vue({
        el: '#app-map',
        data: {
            loading: 1,
            location: 'Vous êtes situé...',
            listBoutiques: [],
            markers: [],
            limit: 0,
            noShop: false,
            hideseemore: false
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
                var target = event.target;
                if (!$(target).hasClass('result')) {
                    target = $(target).closest('.result')[0];
                }
                var id = target.getAttribute('data-id');
                openModal(mapp.markers[id]);
            },
            seeMore: function(event){
                event.preventDefault();
                getShopList();
            }
        }
    });
}


if ($('#app-shop').length > 0) {
    var shopMap = new Vue({
        el: '#app-shop',
        data: {
            infosBoutique: [],
            loading: 1,
            lat: null,
            lng: null,
            travelmode: 'WALKING',
            duration: 'Géolocalisation en cours'
        },
        methods: {
            getShopInfos: function (idProduct) {
                if (idProduct > 0) {
                    var url = domain + '/api/shop?id=' + idProduct;
                    $.get(url + token, (data) => {
                        if (data[0]) {
                            this.infosBoutique = data[0];
                            var themes = {};
                            var nbThemes = 0;

                            // Foreach all themes and count occurences
                            for (var index = 0; index < this.infosBoutique.products.length; index++) {
                                const element = this.infosBoutique.products[index];
                                if (!themes[element.theme]) {
                                    themes[element.theme] = 0;
                                }
                                themes[element.theme] += 1;
                            }
                            
                            // Use the key to get nb values
                            var sorted = Object.keys(themes).sort(function(a, b) {
                                return themes[b] - themes[a];
                            });
                            
                            // Limit nb results
                            sorted = sorted.splice(0, 3);

                            this.infosBoutique.themes = sorted;

                            var $iframe = "<script async defer src='https://maps.googleapis.com/maps/api/js?key=" + tokenMaps + "&callback=shopMap.initDirection'></script>"
                            $('body').append($iframe);

                        } else {
                            $('#app-shop').html('<p class="error">Cette boutique n\'existe pas.</p>');
                        }
                    });
                }
            },
            initDirection: function() {
                if ("geolocation" in navigator) {
                    navigator.geolocation.getCurrentPosition((position) => {
                        this.loading = false;
                        this.lat = position.coords.latitude;
                        this.lng = position.coords.longitude;

                        var map = new google.maps.Map(document.getElementById('map'));

                        this.directionsDisplay = new google.maps.DirectionsRenderer;
                        this.directionsDisplay.setMap(map);
                    
                        this.direction();
                    });
                } else {
                    // TODO : si la location n'est pas dispo
                }
            },
            direction: function() {
                var directionsService = new google.maps.DirectionsService;
                directionsService.route({
                    origin: new google.maps.LatLng(this.lat, this.lng),
                    destination: this.infosBoutique.lieu,
                    travelMode: this.travelmode
                }, (response, status) => {
                    if (status === 'OK') {
                        this.duration = response.routes[0].legs[0].duration.text;
                        this.directionsDisplay.setDirections(response);
                    } else {
                        console.log('Directions request failed due to ' + status);
                    }
                });
            }
        },
        mounted: function() {
            var idBoutique = null;
            var beginUrl = window.location.href.split('boutique-')[1];

            if (beginUrl) {
                if (beginUrl.split('.')[0]) {
                    idBoutique = beginUrl.split('.')[0];
                }
            }
            this.getShopInfos(idBoutique);
        },
        watch: {
            travelmode: function() {
                this.direction();
            }
        }
    });
}