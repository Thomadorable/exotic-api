var domain = 'https://81.57.199.69:3000';
const iToken = 'd557ef8b9827b063b0c29e4bfc6d474e080e65a1e4d76217a03845038f2427bb';
const token = '&token=' + iToken;

if (location.protocol != 'https:') {
    // location.href = 'https:' + window.location.href.substring(window.location.protocol.length);
    domain = '//localhost:3000';
}


if ($('#app-product').length > 0) {
    var productApp = new Vue({
        el: '#app-product',
        data: {
            infosProduct: [],
            listBoutiques: [],
            markers: [],
            autoCenterMap: true
        },
        methods: {
            getProductInfos: function () {
                if (this.idProduct > 0) {
                    $.get(domain + '/api/product?id=' + this.idProduct + token, (data) => {
                        if (data.nb_results > 0) {
                            this.infosProduct = data.products[0];
                        } else {
                            $('#app-product').html('<p class="error">Ce produit n\'existe pas.</p>');
                            $('#app-map').remove();
                        }
                    });
                }
            }
        },
        mounted: function() {
            var idProduct = null;
            var beginUrl = window.location.href.split('produit-')[1];
    
            if (beginUrl) {
                if (beginUrl.split('.')[0]) {
                    idProduct = beginUrl.split('.')[0];
                }
            }
        
            this.idProduct = idProduct;
            this.getProductInfos();
        },
        updated: function () {
            new Swiper('.swiper-container', {
                pagination: {
                    el: '.swiper-pagination',
                    dynamicBullets: true,
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                loop: true,
                autoplay: true,
                speed: 500
            });
        }
    });
}

if ($('#app-search').length > 0) {
    var listFilters = ['name', 'location', 'theme'];
    console.log('init appsearch');
    var appSearch = new Vue({
        el: '#app-search',
        data: {
            searchValue: getHashes()[0],
            filters: getHashes()[1],
            listresults: [],
            currentPage: 0,
            resultsPerPage: 3 * 3,
            nbResults: 0,
            loading: 1,
            popular: false,
            ajax: null,
            filterTheme: 'default',
            filterCategory: 'default',
            themes: [],
            categories: []
        },
        methods: {
            getProductsByName: function () {
                this.loading = 1;

                console.log(this.searchValue);

                if (this.searchValue.length > 0 && this.filters.length > 0) {
                    if (this.ajax) {
                        this.ajax.abort();
                    }
                    var from = this.currentPage * this.resultsPerPage;
                    
                    var filters = this.filters.join(',');
                    var categories = this.categories.join(',');
                    var themes = this.themes.join(',');

                    var url = domain + '/api/products/search';
                    url += '?query=' + this.searchValue + '&filters=' + filters;
                    url +='&from=' + from + '&nbProducts=' + this.resultsPerPage;
                    if (categories.length > 0) {
                        url +='&categories=' + categories;
                    }
                    if (themes.length > 0) {
                        url +='&theme=' + themes;
                    }

                    if (this.filters.length === listFilters.length) {
                        window.location.hash = this.searchValue;
                    } else {
                        window.location.hash = this.filters.join('-') + '-' + this.searchValue;
                    }

                    this.ajax = $.get(url + token, (data) => {

                        if (data.products) {
                            this.nbResults = data.nb_results;
                            this.listresults = data;
                        } else {
                            this.nbResults = 0;
                            this.listresults = [];
                        }

                        this.loading = 0;
                        this.popular = false;
                        
                    });
                } else if(this.searchValue.length === 0) {
                    if (this.ajax) {
                        this.ajax.abort();
                    }

                    if(this.popular === true) {
                        this.loading = 0;
                    } else {
                        this.listresults = [];


                        this.ajax = $.get(domain + '/api/products/popular?token=' + iToken, (data) => {
                            this.loading = 0;
                            this.nbResults = 9;
                            this.popular = true;
                            this.listresults = data;
                        });
                    }

                    window.location.hash = '';
                } else {
                    this.loading = 0;
                    this.nbResults = 0;
                    this.popular = false;
                    this.listresults = [];
                }
            },
            highlight: function (content, filter) {
                if (!this.searchValue || !this.isActive(filter)) {
                    return content;
                }

                var value = this.searchValue.replace('*', '\\*').replace('(', '\\(').replace(')', '\\)');
                value = escape(value);
                var regex = regexAccent(value);


                return content.replace(new RegExp(regex, "gi"), match => {
                    return '<span class="highlightText">' + match + '</span>';
                });
            },
            prevPage: function () {
                this.currentPage--;
            },
            nextPage: function () {
                this.currentPage++;
            },
            isActive: function(filter) {
                return this.filters.indexOf(filter) !== -1;
            },
            notavailable: function() {
                return '<p class="results-no-img">No image available</p>';
            },
            filterChange: function(event) {
                var filter = event.target.className;
                var value = event.target.value;
                
                var indexItem = this[filter].indexOf(value);

                this.updateFilter(filter, value);
            },
            updateFilter: function(filter, value) {
                var indexItem = this[filter].indexOf(value);

                if (indexItem === -1) {
                    this[filter].push(value);
                } else {
                    this[filter].splice(indexItem, 1);
                }

                this.filterTheme = 'default';
                this.filterCategory = 'default';

                this.getProductsByName();
            }
        },
        watch: {
            searchValue: function () {
                this.currentPage = 0;
                this.getProductsByName();
            },
            filters: function () {
                this.currentPage = 0;
                this.getProductsByName();
            },
            currentPage: function () {
                $('html, body').animate({
                    scrollTop: 0
                }, 500); // Go
                this.getProductsByName();
            }
        },
        mounted: function () {
            this.getProductsByName();
            $('.show-after-loaded').fadeIn();
        },
        updated: function () {
            var images = $('.product-cover-img');

            for (let index = 0; index < images.length; index++) {
                const image = images[index];
                let background = new Image();
                background.onload = function () {
                    $(image).next('.loader').fadeOut(300);
                    $(image).css({
                        'background-image': 'url(' + background.src + ')',
                        'opacity': 1
                    }).removeClass('loading');
                };
                background.onerror = (event) => {
                    $(image).closest('.product-cover').html(this.notavailable()).removeClass('product-cover');
                }
                background.src = image.getAttribute('data-image');
            }
        } 
    });

    function regexAccent(regex) {
        regex = regex.replace(new RegExp('[aàáâãäå]', "gi"), '[aàáâãäå]');
        regex = regex.replace(new RegExp('[eèéêë]', "gi"), '[eèéêë]');
        regex = regex.replace(new RegExp('[oòóôõöø]', "gi"), '[oòóôõöø]');
        regex = regex.replace(new RegExp('[cç]', "gi"), '[cç]');
        regex = regex.replace(new RegExp('[iìíîï]', "gi"), '[iìíîï]');
        regex = regex.replace(new RegExp('[uùúûü]', "gi"), '[uùúûü]');
        regex = regex.replace(new RegExp('[nñ]', "gi"), '[nñ]');
        regex = regex.replace(new RegExp('[sš]', "gi"), '[sš]');
        regex = regex.replace(new RegExp('[yÿý]', "gi"), '[yÿý]');
        regex = regex.replace(new RegExp('[zž]', "gi"), '[zž]');

        return regex;
    }

    function getHash() {
        return decodeURIComponent(window.location.hash).split('#')[1].split('-');
    }

    function getHashes() {
        var filters = [];
        var hashes = [''];
        if (window.location.hash) {
            hashes = getHash(); 

            filters = hashes.splice(0, hashes.length - 1);
        }

        if (filters.length === 0) {
            filters = listFilters;
        }

        return [hashes[0], filters];
    }
}