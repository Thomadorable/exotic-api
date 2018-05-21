const isProd = false;

const localConfif = {
    user: "root",
    password: "root",
    database: "exotic",
    port: "8889"
};

if (isProd) {
    module.exports = {
        user: "pi",
        password: "Rammsterchu",
        database: "exotic",
        port: ""
    };
} else {
    module.exports = localConfif;
}

module.exports.isProd = isProd;