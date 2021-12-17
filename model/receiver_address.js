const Sequelize = require('sequelize');
module.exports = function(sequelize, DataTypes) {
  return sequelize.define('receiver_address', {
    id: {
      autoIncrement: true,
      type: DataTypes.INTEGER,
      allowNull: false,
      primaryKey: true
    },
    customer_id: {
      type: DataTypes.STRING(255),
      allowNull: false,
      references: {
        model: 'customer',
        key: 'id'
      }
    },
    receiver_name: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    telephone: {
      type: DataTypes.STRING(11),
      allowNull: true
    },
    province: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    city: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    district: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    ward: {
      type: DataTypes.STRING(45),
      allowNull: true
    },
    specific_address: {
      type: DataTypes.STRING(45),
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'receiver_address',
    timestamps: false,
    indexes: [
      {
        name: "PRIMARY",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "id_UNIQUE",
        unique: true,
        using: "BTREE",
        fields: [
          { name: "id" },
        ]
      },
      {
        name: "fk_address_customer_idx",
        using: "BTREE",
        fields: [
          { name: "customer_id" },
        ]
      },
    ]
  });
};
