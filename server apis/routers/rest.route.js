const router = require('express').Router();
const restController = require('../controller/rest.controller');

router.post("/registerrest",restController.registerrest);
router.post("/getrest",restController.getrest);
router.post("/updaterest",restController.updaterest);
router.post("/getallrest",restController.getallrest);

module.exports = router;
