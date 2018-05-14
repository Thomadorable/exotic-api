'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('marque', {
    'id_marque': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'nom': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'marque',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
  };

  return Model;
};

