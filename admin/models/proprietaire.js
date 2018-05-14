'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('proprietaire', {
    'id_proprietaire': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'nom': {
      type: DataTypes.STRING,
    },
    'mail': {
      type: DataTypes.STRING,
    },
    'mdp': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'proprietaire',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
  };

  return Model;
};

