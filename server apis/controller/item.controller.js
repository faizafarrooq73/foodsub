const itemService = require('../services/item.service');

exports.registeritem = async(req, res, next) => {
    try {
        const { number, name } = req.body;
        const response = await itemService.registeritem(number, name);
        res.json({ status: true, success: "item registered successfully" });
    } catch (e) {
        console.log(e);
        res.json({ status: false, success: "server error controller register" });
    }
}

exports.getitem = async(req,res,next)=>{
    try{
        const { number } = req.body;
        const item = await itemService.getitem(number);
        res.status(200).json({item:item});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller mood"});
    }
}


exports.deleteitem = async(req,res,next)=>{
    try{
        const { id } = req.body;
        const item = await itemService.deleteitem(id);
        res.json({ status: true, success: "item deleted successfully" });
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller mood"});
    }
}
