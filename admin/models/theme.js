'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('theme', {
    'id_theme': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'nom': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'theme',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
  };

  return Model;
};

