'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('produit', {
    'id_produit': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'nom': {
      type: DataTypes.STRING,
    },
    'description': {
      type: DataTypes.STRING,
    },
    'echelle_prix': {
      type: DataTypes.STRING,
    },
    'code_barre': {
      type: DataTypes.STRING,
    },
    'nb_visites': {
      type: DataTypes.INTEGER,
    },
  }, {
    tableName: 'produit',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
    Model.belongsTo(models.theme, {
      foreignKey: 'id_theme',
      targetKey: 'id_theme',
      as: '_id_theme',
    });
    
    Model.belongsTo(models.marque, {
      foreignKey: 'id_marque',
      targetKey: 'id_marque',
      as: '_id_marque',
    });
    
  };

  return Model;
};

