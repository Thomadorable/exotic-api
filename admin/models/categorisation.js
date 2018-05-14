'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('categorisation', {
    'id_categorisation': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
  }, {
    tableName: 'categorisation',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
    Model.belongsTo(models.categorie, {
      foreignKey: 'id_categorie',
      targetKey: 'id_categorie',
      as: '_id_categorie',
    });
    
    Model.belongsTo(models.produit, {
      foreignKey: 'id_produit',
      targetKey: 'id_produit',
      as: '_id_produit',
    });
    
  };

  return Model;
};

