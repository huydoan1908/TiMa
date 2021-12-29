const sequelize = require("sequelize");
const { Op } = require("sequelize");
const { models } = require('../../model');

const category = () => {
    return models.category.findAll({
        raw: true
    })
}

const all = (page = 0, perPage = 9) => {
    return models.product.findAndCountAll({
        include: [{
            model: models.category,
            as: 'category',
            attributes: ['name']
        },
        {
            model: models.product_image,
            as: 'product_images',
            attributes: ['image_url'],
            duplicating: false,
        }],
        offset: page * perPage,
        limit: perPage,
        raw: true,
        group: ['product.id']
    });
}

const byKeyword = (category, keyword, page = 0, perPage = 9) => {
    
    console.log(category);
    console.log(keyword)
    return models.product.findAndCountAll({
        include: [{
            model: models.category,
            as: 'category',
            attributes: ['name',"id"]
        },
        {
            model: models.product_image,
            as: 'product_images',
            attributes: ['image_url'],
            duplicating: false,
        }],
        offset: page * perPage,
        limit: perPage,
        raw: true,
        group: ['product.id'],
        where: {
            [Op.and]:[
                {
                    [Op.or]: [
                        {
                            category_id: {
                                [Op.like]: `%${category}%`
                            }
                            
                        }, {
                            '$category.parent_id$': {
                                [Op.like]: `%${category}%`
                            }
                        }
                    ]
                }
            ,
                {
                    [Op.or]: [
                        {
                            name: {
                                [Op.like]: `N%${keyword}%`
                            }
                        }, {
                            price: {
                                [Op.like]: `%${keyword}%`
                            }
                        }, {
                            '$category.name$': {
                                [Op.like]: `%${keyword}%`
                            }
                        }
                    ]
                }
            ],
        }
    });
}

const byCategory = (id, page = 0, perPage = 9) => {
    return models.product.findAndCountAll({
        include: [{
            model: models.category,
            as: 'category',
            attributes: ['name'],
            where: {
                [Op.or]: [
                    { id: id },
                    { 'parent_id': id }
                ]
            }
        },
        {
            model: models.product_image,
            as: 'product_images',
            attributes: ['image_url'],
            duplicating: false,
        }],
        offset: page * perPage,
        limit: perPage,
        group: ['product.id'],
        raw: true
    });
}

const topRate = () => {
    return models.product.findAll({
        include: [{
            model: models.product_image,
            as: 'product_images',
            attributes: ['image_url']
        }],
        where: {
            'rate': 5
        },
        limit: 9,
        duplicating: false,
        required: true,
        group: ['product.id'],
        raw: true
    });
}

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
}

const size = id => {
    return models.product_size.findAll({
        where: {
            'product_id': id,
            quantity: { [Op.not]: 0 }
        },
        attributes: ['size', 'quantity'],
        raw: true
    })
}

const image = id => {
    return models.product_image.findAll({
        raw: true,
        where: { 'product_id': id },
        offset: 1
    })
}

const addRate = ({ userId, productId, rate, content }) => {
    return models.feedback.create({
        'customer_id': userId,
        'product_id': productId,
        rate,
        content,
        'created_at': Date.now()
    })
}

const getRate = (productId, offset, limit) => {
    return models.feedback.findAndCountAll({
        raw: true,
        offset,
        limit,
        order: [
            ['created_at', 'DESC']
        ],
        where: {
            'product_id': productId
        },
        include: {
            model: models.customer,
            as: 'customer',
            attributes: ['first_name', 'last_name', 'avatar']
        }
    })
}

const getAVGRate = productId => {
    return models.feedback.findOne({
        raw: true,
        where: {
            'product_id': productId
        },
        attributes: [[sequelize.fn('avg', sequelize.col('rate')), 'avgRate']]
    })
}

const updateProductRate = (rate, productId) => {
    return models.product.update({
        rate
    },{
        where: {
            id: productId
        }
    })
}

module.exports = {
    all,
    category,
    byCategory,
    topRate,
    detail,
    size,
    image,
    addRate,
    getRate, 
    getAVGRate,
    updateProductRate
}