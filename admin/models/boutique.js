'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('boutique', {
    'id_boutique': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'nom': {
      type: DataTypes.STRING,
    },
    'lieu': {
      type: DataTypes.STRING,
    },
    'nb_visites': {
      type: DataTypes.INTEGER,
    },
  }, {
    tableName: 'boutique',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
    Model.belongsTo(models.proprietaire, {
      foreignKey: 'id_proprietaire',
      targetKey: 'id_proprietaire',
      as: '_id_proprietaire',
    });
    
  };

  return Model;
};

