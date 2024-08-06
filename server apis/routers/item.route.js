const router = require('express').Router();
const itemController = require('../controller/item.controller');

router.post("/registeritem",itemController.registeritem);
router.post("/getitem",itemController.getitem);
router.post("/deleteitem",itemController.deleteitem);

module.exports = router;
