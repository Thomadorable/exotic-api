'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('photo', {
    'id_photo': {
      type: DataTypes.INTEGER,
      primaryKey: true 
    },
    'url': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'photo',
    underscored: true,
    timestamps: false,
    
  });

  Model.associate = (models) => {
    Model.belongsTo(models.produit, {
      foreignKey: 'id_produit',
      targetKey: 'id_produit',
      as: '_id_produit',
    });
    
  };

  return Model;
};

