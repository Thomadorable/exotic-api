const isProd = false;

const localConfif = {
    user: "root",
    password: "",
    //password: "root",
    database: "exotic",
    //port: "8889"
    port: "3306"
};

if (isProd) {
    module.exports = {
        user: "*****",
        password: "*****",
        database: "*****",
        port: "*****"
    };
} else {
    module.exports = localConfif;
}

module.exports.isProd = isProd;