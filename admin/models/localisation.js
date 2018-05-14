'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('localisation', {
    'id_localisation': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'prix': {
      type: DataTypes.STRING,
    },
    'stock': {
      type: DataTypes.INTEGER,
    },
  }, {
    tableName: 'localisation',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
    Model.belongsTo(models.produit, {
      foreignKey: 'id_produit',
      targetKey: 'id_produit',
      as: '_id_produit',
    });
    
    Model.belongsTo(models.boutique, {
      foreignKey: 'id_boutique',
      targetKey: 'id_boutique',
      as: '_id_boutique',
    });
    
  };

  return Model;
};

