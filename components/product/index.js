const express = require('express');
const router = express.Router();

const controller = require('./productController')


router.get('/:id', controller.detail);

module.exports = router;