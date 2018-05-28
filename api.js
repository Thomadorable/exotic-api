const mysql = require('mysql');
const jsStringEscape = require('js-string-escape');
const express = require('express');
const app = express();
const https = require('https');
const http = require('http');
const fs = require('fs');
const conf = require('./conf.js');
const crypto = require('crypto');
const bodyParser = require("body-parser");
const path = require('path');

// Static Folder
app.use(express.static('www'));


// Get POST datas
app.use(bodyParser.urlencoded({
    extended: true
}));
app.use(bodyParser.json());

// Get credentials from conf.js (prod / dev instance)
const con = mysql.createConnection({
    host: "localhost",
    user: conf.user,
    password: conf.password,
    database: conf.database,
    port: conf.port
});

// Return parsed JSON with correct status + correct headers + cache
function sendJSON(res, result) {
    if (conf.isProd) {
        res.setHeader("Access-Control-Allow-Origin", "https://exotique.design");
    } else {
        res.setHeader("Access-Control-Allow-Origin", "*");
    }
    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
    res.setHeader('Content-Type', 'application/json');
    res.setHeader('Cache-Control', 'public, min-fresh=3600');

    if (!result) {
        result = [{
            status: 404
        }];
    } else if (!result.status) {
        result.status = 200;
    }

    res.send(JSON.stringify(result));
}

// Get string of list of themes by theme name
function getListThemesID(isThemeactive, search, res, callback) {
    if (!isThemeactive && callback && typeof (callback) === 'function') {
        // if we don't need theme, and we have a callback
        callback(); // go to callback function
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

// Get string of list of boutiques by categorie name
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

// Get all shop associated to 1 particular product (by product id)
function getShopByProduct(productID, callback) {
    let sql = "SELECT ";
    sql += "CONCAT('https://api.exotique.design:3000/api/shop?id=', boutique.id_boutique) AS href, "
    sql += "boutique.lat, boutique.lng, boutique.nom AS 'nom_boutique', boutique.lieu AS 'lieu_boutique', ";
    sql += "localisation.id_localisation, localisation.id_boutique, localisation.prix, localisation.stock, ";
    sql += "proprietaire.nom as 'nom_proprietaire' ";
    sql += "FROM localisation ";
    sql += "INNER JOIN boutique ON boutique.id_boutique = localisation.id_boutique ";
    sql += "INNER JOIN proprietaire ON proprietaire.id_proprietaire = boutique.id_proprietaire ";
    sql += "WHERE id_produit = " + productID;

    con.query(sql, function (err, localisation, fields) {
        if (err) throw err;
        callback(localisation);
    });
}

// Is filter active function
function isActive(array, filter) {
    return array.indexOf(filter) !== -1;
}

// Function to split result or return empty array
function splitResult(result) {
    if (result) {
        return result.split(';');
    } else {
        return [];
    }
}

function sha256(data) {
    return crypto.createHash("sha256").update(data, 'utf8').digest('hex');
}

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

function parseNumber(nb, defaultNb = 0) {
    return nb = nb && !isNaN(nb) && nb >= 0 ? nb : defaultNb;
}

// Function to get all datas about categories, themes and prices for 1 query search
// This allow to return all categories/themes/prices from all matching products (=> allow creating front filters)
// without limit pagination
function getMoreDatas(where, callback) {
    let sql = "SELECT GROUP_CONCAT(DISTINCT categorie.nom SEPARATOR ';') as 'all_categories', ";
    sql += "GROUP_CONCAT(DISTINCT theme.nom SEPARATOR ';') as 'all_themes', "
    sql += "GROUP_CONCAT(DISTINCT localisation.prix SEPARATOR ';') as 'all_prices' "
    sql += "FROM produit ";
    sql += "LEFT JOIN categorisation ON produit.id_produit = categorisation.id_produit ";
    sql += "LEFT JOIN categorie ON categorie.id_categorie = categorisation.id_categorie ";
    sql += "LEFT JOIN localisation ON localisation.id_produit = produit.id_produit ";
    sql += "LEFT JOIN boutique ON boutique.id_boutique = localisation.id_boutique ";
    sql += "LEFT JOIN theme ON theme.id_theme = produit.id_theme ";
    sql += "WHERE " + where + " ";

    con.query(sql, function (err, results, fields) {
        callback(results);
    });
}


// Get list of detailed products with 1 query search + limits + filters
function getFullProductInfos(where, whereLimited, having, limitBegin, limiteEnd, res, callback) {
    let select = "SELECT ";
    select += "CONCAT('https://api.exotique.design:3000/api/product?id=', produit.id_produit) AS href, "
    select += "produit.id_produit, produit.nom, produit.description, produit.code_barre, ";
    select += "theme.nom AS 'theme', ";
    select += "marque.nom AS 'marque', ";
    
    select += "GROUP_CONCAT(DISTINCT categorie.nom SEPARATOR ';') as 'categories', ";
    select += "GROUP_CONCAT(DISTINCT photo.url SEPARATOR ';') as 'photos', ";
    select += "GROUP_CONCAT(DISTINCT localisation.prix SEPARATOR ';') as 'prices' ";
    
    let from = "FROM produit ";
    from += "LEFT JOIN theme ON theme.id_theme = produit.id_theme ";
    from += "LEFT JOIN marque ON marque.id_marque = produit.id_marque ";
    from += "LEFT JOIN photo ON photo.id_produit = produit.id_produit ";
    from += "LEFT JOIN categorisation ON categorisation.id_produit = produit.id_produit ";
    from += "LEFT JOIN categorie ON categorie.id_categorie = categorisation.id_categorie ";
    from += "LEFT JOIN localisation ON localisation.id_produit = produit.id_produit ";
    from += "LEFT JOIN boutique ON boutique.id_boutique = localisation.id_boutique ";
    from += "WHERE " + where + " ";

    let groupBy = "GROUP BY produit.id_produit ";
    groupBy += having;
    groupBy += " ORDER BY produit.nb_visites DESC ";
    
    let limit = "LIMIT " + limitBegin + ", " + limiteEnd + " ";


    // Limited sql for products result
    let sqlLimited = select + from + whereLimited + groupBy + limit;

    // Without limit => get datas from all matching products (list of categories/themes/etc)
    let sqlWithoutLimit = select + from + groupBy;

    // Sql to count products without limit but matching filters
    let sqlCount = 'SELECT produit.id_produit ' + from + whereLimited + groupBy;

    console.log('#SQL : get products by');
    console.log(sqlLimited);
    console.log('-----------------');

    con.query(sqlLimited, function (err, products, fields) {
        if (err) throw err;
        else if (products.length > 0) {
            let datas = {};

            // Count all results
            con.query(sqlCount, function (err, products, fields) {
                datas.nb_results = products.length;
            });
            
            // Foreach all products to get images + categories + shop datas
            for (let index = 0; index < products.length; index++) {
                let product = products[index];
                const productID = product.id_produit;

                // Split result to get array from example : "category1;category2"
                product.categories = splitResult(product.categories);
                product.images = splitResult(product.photos);
                let prices = splitResult(product.prices);

                if (prices.length > 0) {
                    // Get array of all prices without "€" sign + parse float
                    prices = prices.map(function(price){
                        return parseFloat(price.replace('€'));
                    });
                    
                    // Return min + max prices of this product
                    let min = Math.min.apply(null, prices);
                    let max = Math.max.apply(null, prices);
                    product.price = {};
                    product.price.min = min; 
                    product.price.max = max;  
                }

                // we don't need anymore these sql result datas
                delete product.prices;
                delete product.photos;

                getShopByProduct(productID, function(localisations){
                    product.localisations = localisations;

                    // After looping all products (= last index)
                    if (index === (products.length - 1)) {
                        datas.products = products;

                        // Get list of all products ID without pagination limit
                        con.query(sqlWithoutLimit, function (err, allProducts, fields) {
                            let listIDProduct = '0';

                            if (allProducts && allProducts.length > 0) {
                                listIDProduct = allProducts.map(y => y.id_produit);
                                listIDProduct = listIDProduct.join(',');
                            }

                            // Get global datas (all matching themes + cat + prices)
                            getMoreDatas('produit.id_produit IN (' + listIDProduct + ')', function(moreDatas){
                                if (moreDatas && moreDatas[0]) {
                                    datas.all_categories = splitResult(moreDatas[0].all_categories);
                                    datas.all_themes = splitResult(moreDatas[0].all_themes);

                                    let prices = splitResult(moreDatas[0].all_prices);

                                    prices = prices.map(price => parseFloat(price));

                                    prices.sort(function(a, b) {
                                        return a - b;
                                    });

                                    datas.all_prices = prices;

                                    datas.prices = {
                                        min: prices[0],
                                        max: prices[prices.length - 1]
                                    }
                                }
    
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
            if (callback && typeof (callback) === 'function') {
                callback();
            } else {
                sendJSON(res, []);
            }
        }
    });
}

// #ROUTE 1 : GENERATE TOKEN
app.post('/api/token', function (req, res) {
    let usermail = req.body.usermail;
    let mdp = req.body.mdp;
    let forbidden = [{
        status: 403,
        message: "Invalid mail or password." + usermail + mdp
    }];

    if(typeof(usermail) !== 'undefined' && typeof(mdp) !== 'undefined') {
        usermail = jsStringEscape(usermail);
        mdp = sha256(jsStringEscape(mdp));
        
        const sql = "SELECT * FROM proprietaire WHERE mail = '" + usermail + "' AND mdp = '" + mdp + "' ";
        con.query(sql, function (err, result) {
            if (err) throw err;
            if (result.length) {
                const date = Date.now();
                const user = result[0];
                const userID = user.id_proprietaire;
                const token = sha256(date + user.mail + date + user.mdp);

                const tokenSQL = 'SELECT token FROM token WHERE id_proprietaire = ' + userID;

                con.query(tokenSQL, function (err, tokens) {
                    if (err) throw err;

                    // Si l'utilisateur a déjà un token, on lui retourne
                    if (tokens.length > 0) {
                        let token = tokens[0].token;

                        sendJSON(res, {
                            token: token,
                        });
                    } else { // Sinon on lui créé
                        let insertSQL = "INSERT INTO token SET token = '" + token + "', id_proprietaire = " + userID;
                        insertSQL += ", debut = NOW(), fin = DATE_ADD(NOW(), INTERVAL 10 MINUTE) , nb_appel = 0";
        
                        con.query(insertSQL, function (err, result) {
                            if (err) throw err;
        
                            sendJSON(res, {
                                token: token,
                            });
                        });
                    }

                });

                
            } else {
                sendJSON(res, forbidden);
            }
        });
    } else {
        sendJSON(res, forbidden);
    }
});

app.get('/', function (req, res, next) {
    res.sendFile(path.join(__dirname + '/www/doc.html'));
});

app.get('/api', function (req, res) {
    res.sendFile(path.join(__dirname + '/www/doc.html'));
});

app.get('/api/products', function (req, res) {
    sendJSON(res, {
        routes: {
            "get" : {
                2: "/api/products/search",
                3: "/api/products/popular",
            }
        },
        status: 404
    })
});


// ALL OTHER ROUTES
app.use(function (req, res, next) {
    let token = req.query.token;
    let forbidden = [{
        status: 403,
        message: "You need a valid token.",
        routes: {
            "post" : {
                1: "/api/token",
            },
            "get" : {
                2: "/api/products/search",
                3: "/api/products/popular",
                4: "/api/product",
                5: "/api/product/shop",
                6: "/api/shop",
                7: "/api/shop/near"
            }
        }
    }];

    let maxCall = [{
        status: 404,
        message: "Vous avez dépassé la limite d'appels.",
    }];

    if (typeof (token) !== 'undefined') {
        token = jsStringEscape(token);

        // SET nb_appel = nb_appel + 1
        const sql = "SELECT * FROM token WHERE token = '" + token + "' ";
        con.query(sql, function (err, result) {
            if (err) throw err;

            if(result.length > 0) {
                let myToken = result[0];
                let end = myToken.fin;

                let sqlUpdate = "UPDATE token SET nb_appel = nb_appel + 1 ";
                let sqlWhere = "WHERE id_token = " + myToken.id_token ;

                if (myToken.nb_appel >= 50 && new Date() <= end) {
                    sendJSON(res, maxCall);
                } else {
                    if (new Date() > end) {
                        sqlUpdate = "UPDATE token SET nb_appel = 0, fin = DATE_ADD(NOW(), INTERVAL 1 MINUTE) ";
                    } 

                    sqlUpdate += sqlWhere;

                    con.query(sqlUpdate, function(err, result){
                        if (err) throw err;
                        next();
                    });
                }
            } else {
                sendJSON(res, forbidden);
            }
        });
    } else {
        sendJSON(res, forbidden);
    }
    
    
    console.log('Visite du serveur sur : ', req.url);
});

// ROUTE 2 : SEARCH BY ALL
app.get('/api/products/search', function (req, res) {
    let filters = req.query.filters;
    let begin = req.query.from;
    let nbProducts = req.query.nbProducts;
    let query = req.query.query;
    let categories = req.query.categories;
    let theme = req.query.theme;
    let maxPrice = req.query.maxPrice;

    begin = parseNumber(begin);
    nbProducts = parseNumber(nbProducts, 20);

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

        
                    where = where.substring(0, where.length - 4); // Remove last 'or' (or parentheses)

                    where = '(' + where + ')';                    
                    

                    if (typeof (theme) !== 'undefined') {
                        theme = jsStringEscape(theme);
                        where += " AND theme.nom LIKE '%" + theme + "%'";
                    }

                    if (where.length > 2) { // 2 because of () 
                        let having = filterByCategories(categories);
                        let whereLimited = '';

                        if (typeof (maxPrice) !== 'undefined' && !isNaN(maxPrice) && maxPrice > 0) {
                           whereLimited = " AND (localisation.prix <= " + maxPrice + ' OR localisation.prix IS NULL)';
                        }

                        getFullProductInfos(where, whereLimited, having, begin, nbProducts, res);
                    } else {
                        // If we have 0 filter matching (with 0 idTheme or 0 idBoutique for ex)
                        sendJSON(res, []);
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

// ROUTE 3 : POPULAR PRODUCTS
app.get('/api/products/popular', function (req, res) {
    let from = parseNumber(req.query.from);
    let to = parseNumber(req.query.to, 9);

    getFullProductInfos('produit.nb_visites > 0', '', '', from, to, res);
});

// ROUTE 4 GET PRODUCT BY ID
app.get('/api/product', function (req, res) {
    let idProduct = req.query.id;

    if (!isNaN(idProduct)) {

        let sql = "produit.id_produit = " + idProduct;
        getFullProductInfos(sql, '', '', 0, 1, res, function (products) {
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
});

// ROUTE 5 : GET PRODUCT SHOPS, ORDER BY LOCATION
app.get('/api/product/shop', function (req, res) {
    let lat = req.query.lat;
    let lng = req.query.lng;
    let idProduct = req.query.idProduct;

    if (!isNaN(lat) && !isNaN(lng) && !isNaN(idProduct) && idProduct > 0) {
        // avoid &limit= (with blank value)
        if (lat == 0) lat = 0;
        if (lng == 0) lng = 0;
        
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

// ROUTE 6 : SHOP INFOS
app.get('/api/shop', function (req, res) {
    let idBoutique = req.query.id;
    let from = parseNumber(req.query.from);
    let to = parseNumber(req.query.to, 9);

    if (!isNaN(idBoutique) && idBoutique > 0) {
        sql = 'SELECT id_boutique, nom, lieu, lat, lng FROM boutique WHERE id_boutique = ' + idBoutique;
        con.query(sql, function (err, shopDatas) {
            if (err) throw err;
            
            let sql = 'produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique = ' + idBoutique + ')';
            getFullProductInfos(sql, '', '', from, to, res, function(data){
                if (shopDatas && shopDatas[0]) {
                    shopDatas[0].products = [];

                    if (data && data.products && data.products.length > 0) {
                        shopDatas[0].products = data.products;
                    }
    
                    let sql = "UPDATE boutique SET nb_visites = nb_visites + 1 WHERE id_boutique = " + idBoutique;
                    con.query(sql, function (err, result) {
                        if (err) throw err;
                        console.log(result.affectedRows + " record(s) updated");
                    });

                    sendJSON(res, shopDatas);
                    
                } else {
                    sendJSON(res);
                }
                

            });
        });
    } else {
        sendJSON(res);
    }
});

// ROUTE 7 : FIND SHOP BY LOCATION
app.get('/api/shop/near', function (req, res) {
    let lat = req.query.lat;
    let lng = req.query.lng;
    let limit = parseNumber(req.query.limit);

    if (!isNaN(lat) && !isNaN(lng)) {
        // avoid &limit= (with blank value)
        if (limit == 0) limit = 0;
        if (lat == 0) lat = 0;
        if (lng == 0) lng = 0;

        sql = 'SELECT id_boutique, nom, lieu, lat, lng, (abs(boutique.lat - ' + lat + ') + abs(boutique.lng - ' + lng + ')) as distance FROM boutique ORDER BY distance ASC LIMIT ' + limit + ' , 8';
        con.query(sql, function (err, results) {
            if (err) throw err;
            sendJSON(res, results);
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
    
    https.createServer(options, app).listen(3000, function(){
        console.log("#######################################################");
        console.log("Le serveur a bien été lancé sur le port 3000 (en HTTPS)");
        console.log("#######################################################");
    });
} else {
    app.listen(3000, function(){
        console.log("#######################################################");
        console.log("Le serveur a bien été lancé sur le port 3000 (en HTTPS)");
        console.log("#######################################################");
    });
}
  