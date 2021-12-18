const { Sequelize } = require('sequelize');
const initModels = require('./init-models');
// const sequelize = new Sequelize(process.env.CLEARDB_DATABASE_URL);

const sequelize = new Sequelize('estore', 'root', process.env.DB_PASSWORD, {
    host: 'localhost',
    dialect: 'mysql'
});

module.exports = {
    sequelize,
    models: initModels(sequelize),
}