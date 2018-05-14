'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('categorie', {
    'id_categorie': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'nom': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'categorie',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
  };

  return Model;
};

