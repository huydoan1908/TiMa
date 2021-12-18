const { Op } = require("sequelize");
const { models } = require('../../model');

const detail = id => {
    return models.product.findByPk(id, {
        include: [{
            model: models.category,
            as: 'category',
            attributes: ['name']
        },
        {
            model: models.product_image,
            as: 'product_images',
            attributes: ['image_url'],
            duplicating: false
        }],
        raw: true
    })
};

module.exports = {
    detail,
}