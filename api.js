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

function getProductsBy(where, res) {
    let sql = "SELECT produit.id_produit, produit.nom, theme.nom AS 'id_theme', photo.url AS 'image' FROM produit ";
    sql += "LEFT JOIN theme ON theme.id_theme = produit.id_theme ";
    sql += "LEFT JOIN photo ON photo.id_produit = produit.id_produit  ";
    sql += "WHERE " + where + " ";
    sql += "GROUP BY produit.id_produit";

    console.log('#SQL : get products by');
    console.log(sql);
    console.log('-----------------');

    con.query(sql, function (err, result, fields) {
        if (err) throw err;
        sendJSON(res, result);
    });
}

function getIdThemes(search, res, callback) {
    let sql = "SELECT id_theme FROM theme WHERE nom LIKE '%" + search + "%'";
    con.query(sql, function (err, result, fields) {
        if (err) throw err;
            let idThemes = '';
            for (let index = 0; index < result.length; index++) {
                idThemes += result[index].id_theme + ', ';
            }

            idThemes = idThemes.substring(0, idThemes.length - 2);

            if(callback && typeof(callback) === 'function') {
                callback(idThemes);
            }
    });
}

function getIdBoutiques(search, res, callback) {
    console.log('get id boutiques !');
    let sql = "SELECT id_boutique FROM boutique WHERE nom LIKE '%" +search+ "%' OR lieu LIKE '%" +search+ "%'";
    con.query(sql, function (err, result, fields) {
        if (err) throw err;
            let idBoutiques = '';
            for (let index = 0; index < result.length; index++) {
                idBoutiques += result[index].id_boutique + ', ';
            }

            idBoutiques = idBoutiques.substring(0, idBoutiques.length - 2);

            if(callback && typeof(callback) === 'function') {
                callback(idBoutiques);
            }
    });
}

// SEARCH BY NAME
app.get('/api/search/products/name/:search', function (req, res) {
    let search = req.params.search;
    search = jsStringEscape(search);

    getProductsBy('produit.nom LIKE "%' + search + '%"', res);
})

// SEARCH BY THEME
app.get('/api/search/products/theme/:search', function (req, res) {
    let search = req.params.search;
    search = jsStringEscape(search);

   getIdThemes(search, res, function(idThemes){
        getProductsBy('produit.id_theme IN ('+ idThemes + ')', res);
   });
})

// SEARCH BY LOCATION
app.get('/api/search/products/location/:search', function (req, res) {
    let search = req.params.search;
    search = jsStringEscape(search);

    getIdBoutiques(search, res, function(idBoutiques){
        let sql = 'produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique IN (' +idBoutiques+ '))';
        getProductsBy(sql, res);
    });
})

// SEARCH BY ALL
app.get('/api/search/products/all/:search', function (req, res) {
    let search = req.params.search;
    search = jsStringEscape(search);

    getIdThemes(search, res, function(idThemes){
        getIdBoutiques(search, res, function(idBoutiques){
            let sql = 'produit.nom LIKE "%' + search + '%" ';
            if (idThemes.length > 0) {
                sql += 'OR produit.id_theme IN ('+ idThemes + ') ';
            } 
            if (idBoutiques.length > 0) {
                sql += 'OR produit.id_produit IN (SELECT id_produit FROM localisation WHERE id_boutique IN (' +idBoutiques+ '))';
            }
            getProductsBy(sql, res);
        });
    });
})

app.get('/api/product/:id', function (req, res) {
    let idProduct = req.params.id;

    con.query("SELECT id_produit AS 'id', produit.nom, description, echelle_prix, code_barre, theme.nom AS 'theme', marque.nom AS 'marque' FROM produit INNER JOIN theme ON theme.id_theme = produit.id_theme INNER JOIN marque ON marque.id_marque = produit.id_marque WHERE id_produit = " + idProduct+ ' LIMIT 0, 1 ', function (err, result, fields) {
        if (err) throw err;
        else if (result.length > 0) {
            con.query("SELECT categorie.id_categorie, nom FROM categorisation INNER JOIN categorie ON categorie.id_categorie = categorisation.id_categorie WHERE id_produit = " + idProduct, function (err, categories, fields) {
                if (err) throw err;
                else if (result.length > 0) {
                    result[0].categories = categories;
                  
                    con.query("SELECT id_photo, url FROM photo WHERE id_produit = " + idProduct, function (err, photos, fields) {
                        if (err) throw err;
                        else if (result.length > 0) {
                            result[0].images = photos;
                          
                            con.query("SELECT localisation.id_localisation, localisation.id_boutique, prix, stock, boutique.nom AS 'nom_boutique', boutique.lieu AS 'lieu_boutique', proprietaire.nom as 'nom_proprietaire' FROM localisation INNER JOIN boutique ON boutique.id_boutique = localisation.id_boutique INNER JOIN proprietaire ON proprietaire.id_proprietaire = boutique.id_proprietaire WHERE id_produit = " + idProduct, function (err, localisation, fields) {
                                if (err) throw err;
                                else if (result.length > 0) {
                                    result[0].localisation = localisation;
                                  
                                    res.setHeader("Access-Control-Allow-Origin", "*");
                                    res.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
                                    res.setHeader('Content-Type', 'application/json');
                                    
                                    res.send(JSON.stringify(result));
                                }
                            });
                        }
                    });
                }
            });
        } else {
            result = [];
        }

        
    });
})

app.use(function(req, res, next){
    // res.setHeader('Content-Type', 'text/plain');
    // res.status(404).send('Page introuvable !');
    console.log('Page introuvable !');
    sendJSON(res);
});

app.listen(3000);