const mysql = require('mysql');
const jsStringEscape = require('js-string-escape');
const express = require('express');
const app = express();
const https = require('https');
const http = require('http');
const fs = require('fs');
const conf = require('./conf.js');

const con = mysql.createConnection({
    host: "localhost",
    user: conf.user,
    password: conf.password,
    database: conf.database,
    port: conf.port
});

function sendJSON(res, result) {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.setHeader('Content-Type', 'application/json');

    if (!result) {
        result = [{
            status: 404
        }];
    } else {
        result.status = 202;
    }

    res.send(JSON.stringify(result));
}

function getListThemesID(isThemeactive, search, res, callback) {
    if (!isThemeactive && callback && typeof (callback) === 'function') {
        // if we doesn't need theme, and we have a callback function
        callback();
    } else {
        let sql = "SELECT id_theme FROM theme WHERE nom LIKE '%" + search + "%'";
        con.query(sql, function (err, result, fields) {
            if (err) throw err;
            let idThemes = '';
            for (let index = 0; index < result.length; index++) {
                idThemes += result[index].id_theme + ', ';
            }
    
            idThemes = idThemes.substring(0, idThemes.length - 2);
    
            if (callback && typeof (callback) === 'function') {
                callback(idThemes);
            }
        });
    }
}

function getListBoutiquesID(isLocationActive, search, res, callback) {
    if (!isLocationActive && callback && typeof (callback) === 'function') {
        callback();
    } else {
        let sql = "SELECT id_boutique FROM boutique WHERE nom LIKE '%" + search + "%' OR lieu LIKE '%" + search + "%'";
        con.query(sql, function (err, result, fields) {
            if (err) throw err;
            let idBoutiques = '';
            for (let index = 0; index < result.length; index++) {
                idBoutiques += result[index].id_boutique + ', ';
            }
    
            idBoutiques = idBoutiques.substring(0, idBoutiques.length - 2);
    
            if (callback && typeof (callback) === 'function') {
                callback(idBoutiques);
            }
        });
    }
}

function getShopByProduct(productID, callback) {
    let sql = "SELECT boutique.lat, boutique.lng, boutique.nom AS 'nom_boutique', boutique.lieu AS 'lieu_boutique', ";
    sql += "localisation.id_localisation, localisation.id_boutique, localisation.prix, localisation.stock, ";
    sql +="proprietaire.nom as 'nom_proprietaire' ";
    sql += "FROM localisation ";
    sql += "INNER JOIN boutique ON boutique.id_boutique = localisation.id_boutique ";
    sql += "INNER JOIN proprietaire ON proprietaire.id_proprietaire = boutique.id_proprietaire ";
    sql += "WHERE id_produit = " + productID;

    con.query(sql, function (err, localisation, fields) {
        if (err) throw err;
        callback(localisation);
    });
}

function isActive(array, filter) {
    return array.indexOf(filter) !== -1;
}

function splitResult(result) {
    if (result) {
        return result.split(';');
    } else {
        return [];
    }
}

function getMoreDatas(where, callback) {
    let sql = "SELECT GROUP_CONCAT(DISTINCT categorie.nom SEPARATOR ';') as 'all_categories', ";
    sql += "GROUP_CONCAT(DISTINCT localisation.prix SEPARATOR ';') as 'all_prices', "
    sql += "GROUP_CONCAT(DISTINCT theme.nom SEPARATOR ';') as 'all_themes' "
    sql += "FROM produit ";
    sql += "LEFT JOIN categorisation ON produit.id_produit = categorisation.id_produit ";
    sql += "LEFT JOIN categorie ON categorie.id_categorie = categorisation.id_categorie ";
    sql += "LEFT JOIN localisation ON localisation.id_produit = produit.id_produit ";
    sql += "LEFT JOIN boutique ON boutique.id_boutique = localisation.id_boutique ";
    sql += "LEFT JOIN theme ON theme.id_theme = produit.id_theme ";
    sql += "WHERE " + where + " ";

    console.log('more infos ---->');
    console.log(sql);

    con.query(sql, function (err, results, fields) {
        callback(results);
    });
}

function getFullProductInfos(where, having, limitBegin, limiteEnd, res, callback) {
    let sql = "SELECT produit.id_produit, produit.nom, produit.description, produit.code_barre, ";
    sql += "theme.nom AS 'theme', ";
    sql += "marque.nom AS 'marque', ";
    sql += "GROUP_CONCAT(DISTINCT categorie.nom SEPARATOR ';') as 'categories', ";
    sql += "GROUP_CONCAT(DISTINCT photo.url SEPARATOR ';') as 'photos', ";
    sql += "GROUP_CONCAT(DISTINCT localisation.prix SEPARATOR ';') as 'prices' ";
    
    sql += "FROM produit ";
    sql += "LEFT JOIN theme ON theme.id_theme = produit.id_theme ";
    sql += "LEFT JOIN marque ON marque.id_marque = produit.id_marque ";
    sql += "LEFT JOIN photo ON photo.id_produit = produit.id_produit ";
    sql += "LEFT JOIN categorisation ON categorisation.id_produit = produit.id_produit ";
    sql += "LEFT JOIN categorie ON categorie.id_categorie = categorisation.id_categorie ";
    sql += "LEFT JOIN localisation ON localisation.id_produit = produit.id_produit ";
    sql += "LEFT JOIN boutique ON boutique.id_boutique = localisation.id_boutique ";
   
    sql += "WHERE " + where + " ";
    sql += "GROUP BY produit.id_produit ";
    sql += having;
    sql += " ORDER BY produit.nb_visites DESC ";
    
    let limit = "LIMIT " + limitBegin + ", " + limiteEnd + " ";

    let sqlLimited = sql + limit;
    
    console.log('#SQL : get products by');
    console.log(sqlLimited);
    console.log('-----------------');

    con.query(sqlLimited, function (err, products, fields) {
        if (err) throw err;
        else if (products.length > 0) {
            let listThemes = [];
            let listCategories = [];
            let minPrice = 0;
            let maxPrice = 0;
            let datas = {};

            for (let index = 0; index < products.length; index++) {
                let product = products[index];
                const productID = product.id_produit;

                product.categories = splitResult(product.categories);
                product.images = splitResult(product.photos);
                let prices = splitResult(product.prices);

                if (prices.length > 0) {
                    prices = prices.map(function(price){
                        return parseFloat(price.replace('€'));
                    });
    
                    let min = Math.min.apply(null, prices);
                    let max = Math.max.apply(null, prices);
                    product.price = {};
                    product.price.min = min; 
                    product.price.max = max;  
                }

                delete product.nb_results;
                delete product.prices;
                delete product.photos;

                getShopByProduct(productID, function(localisations){
                    product.localisations = localisations;

                    if (index === (products.length - 1)) {

                        // Get list of all products without pagination limit
                        con.query(sql, function (err, allProducts, fields) {
                            let listIDProduct = '0';

                            datas.nb_results = allProducts.length;

                            if (allProducts && allProducts.length > 0) {
                                listIDProduct = allProducts.map(y => y.id_produit);
                                listIDProduct = listIDProduct.join(',');
                            }

                            getMoreDatas('produit.id_produit IN (' + listIDProduct + ')', function(moreDatas){
                                if (moreDatas && moreDatas[0]) {
                                    datas.all_categories = splitResult(moreDatas[0].all_categories);
                                    datas.all_prices = splitResult(moreDatas[0].all_prices);
                                    datas.all_themes = splitResult(moreDatas[0].all_themes);
                                }
                               
                                datas.products = products;
    
                                if (callback && typeof (callback) === 'function') {
                                    callback(datas);
                                } else {
                                    sendJSON(res, datas);
                                }
                            });
                        });
                    }
                });
            }
        } else {
            sendJSON(res);
        }
    });

}

// ROUTE #1 SEARCH BY ALL
app.get('/api/products/search', function (req, res) {
    let filters = req.query.filters;
    let begin = req.query.from;
    let nbProducts = req.query.nbProducts;
    let query = req.query.query;
    let categories = req.query.categories;
    let theme = req.query.theme;

    begin = begin ? begin : 0;
    nbProducts = nbProducts ? nbProducts : 20;

    if (typeof (filters) !== 'undefined' && typeof (query) !== 'undefined') {
        filters = filters.split(',');

        query = jsStringEscape(query);
    
        let isThemeActive = isActive(filters, 'theme');
        let isLocationActive = isActive(filters, 'location');
        let isNameActive = isActive(filters, 'name');

        if (isThemeActive + isLocationActive + isNameActive > 0) {
            let where = '';

            if (isNameActive) {
                where += 'produit.nom LIKE "%' + query + '%" OR ';
            }

            getListThemesID(isThemeActive, query, res, function (listThemesID) {
                if (isThemeActive && listThemesID && listThemesID.length > 0) {
                    where += 'produit.id_theme IN (' + listThemesID + ') OR ';
                }

                getListBoutiquesID(isLocationActive, query, res, function (listBoutiquesID) {
                    if (isLocationActive && listBoutiquesID && listBoutiquesID.length > 0) {
                        where += 'produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique IN (' + listBoutiquesID + ')) OR ';
                    }
        
                    where = where.substring(0, where.length - 3); // Remove last 'or'

                    if (typeof (theme) !== 'undefined') {
                        theme = jsStringEscape(theme);
                        where = "(" + where + ") AND theme.nom LIKE '%" + theme + "%' "
                    }

                    if (where.length > 0) {
                        let having = filterByCategories(categories);
                        getFullProductInfos(where, having, begin, nbProducts, res);
                    } else {
                        // If we have 0 filter matching (with 0 idTheme or 0 idBoutique for ex)
                        sendJSON(res);
                    }
                });
            });
        } else {
            sendJSON(res);
        }
    } else {
        sendJSON(res);
    }
});

function filterByCategories(categories) {
    let having = '';
    if (categories && typeof (categories) !== 'undefined') {
        categories = categories.split(',');

        if (categories.length > 0) {
            having = 'HAVING ';

            for (let index = 0; index < categories.length; index++) {
                const category = categories[index];
                having += 'categories LIKE "%' +category+ '%" AND '
            }

            having = having.substring(0, having.length - 4); // Remove last 'and '
        }
    }

    return having;
}

// ROUTE #2 GET PRODUCT BY ID
app.get('/api/product', function (req, res) {
    let idProduct = req.query.id;

    if (!isNaN(idProduct)) {

        let sql = "produit.id_produit = " + idProduct;
        getFullProductInfos(sql, '', 0, 1, res, function (products) {
            let sql = "UPDATE produit SET nb_visites = nb_visites + 1 WHERE id_produit = " + idProduct;
            con.query(sql, function (err, result) {
                if (err) throw err;
                console.log(result.affectedRows + " record(s) updated");
            });
    
            sendJSON(res, products);
        });
    } else {
        sendJSON(res);
    }
})

// GET PRODUCT SHOPS, ORDER BY LOCATION
app.get('/api/product/shop', function (req, res) {
    let lat = req.query.lat;
    let lng = req.query.lng;
    let idProduct = req.query.idProduct;

    if (!isNaN(lat) && !isNaN(lng) && !isNaN(idProduct)) {
        sql = 'SELECT boutique.id_boutique, boutique.nom, boutique.lieu, boutique.lat, boutique.lng, ';
        sql += '(abs(boutique.lat - ' + lat + ') + abs(boutique.lng - ' + lng + ')) as distance ';
        sql += 'FROM localisation '
        sql += 'LEFT JOIN boutique ON boutique.id_boutique = localisation.id_boutique '
        sql += 'WHERE id_produit = ' + idProduct;
        sql += ' ORDER BY distance ASC';

        con.query(sql, function (err, results) {
            if (err) throw err;
            sendJSON(res, results);
        });
    } else {
        sendJSON(res);
    }
});

// FIND SHOP BY LOCATION
app.get('/api/shop/near', function (req, res) {
    let lat = req.query.lat;
    let lng = req.query.lng;
    let limit = req.query.limit;

    if (!isNaN(lat) && !isNaN(lng) && !isNaN(limit) && limit >= 0) {
        sql = 'SELECT id_boutique, nom, lieu, lat, lng, (abs(boutique.lat - ' + lat + ') + abs(boutique.lng - ' + lng + ')) as distance FROM boutique ORDER BY distance ASC LIMIT ' + limit + ' , 8';
        con.query(sql, function (err, results) {
            if (err) throw err;
            sendJSON(res, results);
        });
    } else {
        sendJSON(res);
    }
});


// POPULAR PRODUCTS
app.get('/api/products/popular', function (req, res) {
    getFullProductInfos('produit.nb_visites > 0', '', 0, 9, res);
});

// SHOP INFOS
app.get('/api/shop', function (req, res) {
    let idBoutique = req.query.id;

    if (!isNaN(idBoutique)) {
        sql = 'SELECT id_boutique, nom, lieu, lat, lng FROM boutique WHERE id_boutique = ' + idBoutique;
        con.query(sql, function (err, shopDatas) {
            if (err) throw err;
            let sql = 'produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique = ' + idBoutique + ')';
            getFullProductInfos(sql, '', 0, 999, res, function(data){
                shopDatas[0].products = [];

                if (data.products.length > 0) {
                    shopDatas[0].products = data.products;
                }

                let sql = "UPDATE boutique SET nb_visites = nb_visites + 1 WHERE id_boutique = " + idBoutique;
                con.query(sql, function (err, result) {
                    if (err) throw err;
                    console.log(result.affectedRows + " record(s) updated");
                });

                sendJSON(res, shopDatas);
            });
        });
    } else {
        sendJSON(res);
    }
});

app.use(function (req, res, next) {
    let notFound = [{
        status: 404
    }]
    sendJSON(res, notFound);
});

if (conf.isProd) {
    var options = {
        key: fs.readFileSync('keys/private.key.pem'),
        cert: fs.readFileSync('keys/domain.cert.pem')
    };
    
    https.createServer(options, app).listen(3000);
    // http.createServer(app).listen(3000);
} else {
    app.listen(3000);
}
  