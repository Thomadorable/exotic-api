const mysql = require('mysql');
const jsStringEscape = require('js-string-escape');
const express = require('express');
const app = express();

const con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "root",
    database: "exotic",
    port: "8889"
});

function sendJSON(res, result) {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.setHeader('Content-Type', 'application/json');

    if (!result) {
        result = [];
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

function getQueryInfos(where, callback) {
    let sql = 'SELECT COUNT (*) AS nb_results FROM produit WHERE ' + where;
    con.query(sql, function (err, datas, fields) {
        if (err) throw err;
        let nbResults = datas[0].nb_results;
        callback(nbResults);
    });
}

function getFullProductInfos(where, limitBegin, limiteEnd, res, callback) {
    let sql = "SELECT id_produit, produit.nom, description, echelle_prix, code_barre, theme.nom AS 'theme', "
    sql += "marque.nom AS 'marque' ";
    sql += "FROM produit ";
    sql += "LEFT JOIN theme ON theme.id_theme = produit.id_theme ";
    sql += "LEFT JOIN marque ON marque.id_marque = produit.id_marque "
    sql += "WHERE " + where + ' ';
    sql += "LIMIT " + limitBegin + ", " + limiteEnd;

    console.log('#SQL : get products by');
    console.log(sql);
    console.log('-----------------');

    con.query(sql, function (err, results, fields) {
        if (err) throw err;
        else if (results.length > 0) {
            let products = [];
            let listThemes = [];
            let listCategories = [];

            for (let index = 0; index < results.length; index++) {
                let product = results[index];
                const productID = product.id_produit;

                if (listThemes.indexOf(product.theme) === -1) {
                    listThemes.push(product.theme);
                }

                con.query("SELECT nom FROM categorisation INNER JOIN categorie ON categorie.id_categorie = categorisation.id_categorie WHERE id_produit = " + productID, function (err, categories, fields) {
                    if (err) throw err;
                    else if (categories.length > 0)  {
                        product.categories = categories;

                        for (let indexCat = 0; indexCat < categories.length; indexCat++) {
                            const category = categories[indexCat].nom;
                            if (listCategories.indexOf(category) === -1) {
                                listCategories.push(category);
                            }
                        }
                    }

                    con.query("SELECT id_photo, url FROM photo WHERE id_produit = " + productID, function (err, images, fields) {
                        if (err) throw err;
                        else if (images.length > 0) {
                            product.images = images;
                        }

                        getShopByProduct(productID, function(localisation){
                            if (localisation.length > 0) {
                                product.localisation = localisation;
                            }

                            products.push(product);

                            if (index === (results.length - 1)) {
                                if (callback && typeof (callback) === 'function') {
                                    callback(products);
                                } else {
                                    getQueryInfos(where, function(nbResults){
                                        let datas = {};                                        
                                        datas.nbResults = nbResults;
                                        datas.categories = listCategories;
                                        datas.themes = listThemes;
                                        datas.products = products;
                                        sendJSON(res, datas);
                                    });
                                }
                            }
                        });
                    });
                });
            }
        } else {
            if (callback && typeof (callback) === 'function') {
                callback([]);
            } else {
                sendJSON(res);
            }
        }
    });
}

function isActive(array, filter) {
    return array.indexOf(filter) !== -1;
}

// SEARCH BY ALL
app.get('/api/products/search', function (req, res) {
    let filters = req.query.filters;
    let begin = req.query.from;
    let nbProducts = req.query.nbProducts;
    let query = req.query.query;

    if (filters && typeof (filters) !== 'undefined' && query && typeof (query) !== 'undefined') {
        filters = filters.split(',');

        query = jsStringEscape(query);
    
        let isThemeActive = isActive(filters, 'theme');
        let isLocationActive = isActive(filters, 'location');
        let isNameActive = isActive(filters, 'name');

        if (isThemeActive + isLocationActive + isNameActive > 0) {
            let sql = '';

            if (isNameActive) {
                sql += 'produit.nom LIKE "%' + query + '%" OR ';
            }


            getListThemesID(isThemeActive, query, res, function (listThemesID) {
                if (isThemeActive && listThemesID && listThemesID.length > 0) {
                    sql += 'produit.id_theme IN (' + listThemesID + ') OR ';
                }

                getListBoutiquesID(isLocationActive, query, res, function (listBoutiquesID) {
                    if (isLocationActive && listBoutiquesID && listBoutiquesID.length > 0) {
                        sql += 'produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique IN (' + listBoutiquesID + ')) OR ';
                    }
        
                    sql = sql.substring(0, sql.length - 3); // Remove last 'or'

                    // If we have 0 filter matching (with 0 idTheme or 0 idBoutique for ex)
                    if (sql.length === 0) {
                        sendJSON(res);
                    } else {
                        // Else get products infos
                        getFullProductInfos(sql, begin, nbProducts, res);
                    }
                });
            });
        } else {
            sendJSON(res);
        }
    } else {
        sendJSON(res);
    }
})

// GET PRODUCT BY ID
app.get('/api/product/:id', function (req, res) {
    let idProduct = req.params.id;
    let sql = "id_produit = " + idProduct;

    if (!isNaN(idProduct)) {
        getFullProductInfos(sql, 0, 1, res, function (products) {
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
app.get('/api/product/shop/:lat/:lng/:idProduct', function (req, res) {
    let lat = req.params.lat;
    let lng = req.params.lng;
    let idProduct = req.params.idProduct;

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
    getFullProductInfos('nb_visites > 0 ORDER BY nb_visites DESC', 0, 9, res);
});

// SHOP INFOS
app.get('/api/shop/:id', function (req, res) {
    let idBoutique = req.params.id;

    if (!isNaN(idBoutique)) {
        sql = 'SELECT id_boutique, nom, lieu, lat, lng FROM boutique WHERE id_boutique = ' + idBoutique;
        con.query(sql, function (err, shopDatas) {
            if (err) throw err;
            let sql = 'produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique = ' + idBoutique + ')';
            getFullProductInfos(sql, 0, 999, res, function(products){
                shopDatas[0].products = [];
                if (products.length > 0) {
                    shopDatas[0].products = products;
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
    // res.setHeader('Content-Type', 'text/plain');
    // res.status(404).send('Page introuvable !');
    console.log('Page introuvable !');
    sendJSON(res);
});

app.listen(3000);