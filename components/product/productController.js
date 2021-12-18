const service = require('./productService')

const list = async (req,res) => {
    //get params
    const page = !Number.isNaN(req.query.page) && req.query.page > 0 ? Number.parseInt(req.query.page) : 1; 
    const catOption = !Number.isNaN(req.query.category) && req.query.category > 0 ? Number.parseInt(req.query.category) : 0;
    //request from dtb
    const category = await service.category();
    const products = catOption ? await service.byCategory(catOption,page-1) : await service.all(page-1,9);
    res.render('product/productList', { title: 'Shop', products, category, page, catOption});
}

const detail = async (req, res) => {
    try {
        const [detail, size, image] = await Promise.all([
            service.detail(req.params.id),
            service.size(req.params.id),
            service.image(req.params.id)
        ]);
        const related = await service.byCategory(detail['category_id']);
        res.render('product/productDetail', {
            title: detail.name,
            style: 'detail.css',
            scripts: ['productRate.js'],
            detail,
            related: related.rows,
            size,
            image
        });
    } catch (err) {
        console.log(err);
    }
};

module.exports = {
    list,
    detail
}