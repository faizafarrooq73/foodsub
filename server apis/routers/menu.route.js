const router = require('express').Router();
const menuController = require('../controller/menu.controller');

router.post("/registermenu",menuController.registermenu);
router.post("/allmenu",menuController.allmenu);
router.post("/updatedmenu",menuController.updatedmenu);
router.post("/allmenuadmin",menuController.allmenuadmin);
router.post("/deletemenu",menuController.deletemenu);
router.post("/allmenuwn",menuController.allmenuwn);

module.exports = router;
