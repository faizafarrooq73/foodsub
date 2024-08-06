const router = require('express').Router();
const resrController = require('../controller/order.controller');

router.post("/registeroder",resrController.registeroder);
router.post("/getbyrest",resrController.getbyrest);
router.post("/getbyuser",resrController.getbyuser);
router.post("/getbyrider",resrController.getbyrider);
router.post("/updatereststatus",resrController.updatereststatus);
router.post("/getbyriderstatus",resrController.getbyriderstatus);
router.post("/updateriderstatus",resrController.updateriderstatus);
router.post("/doneorder",resrController.doneorder);
router.post("/updateloc",resrController.updateloc);


module.exports = router;