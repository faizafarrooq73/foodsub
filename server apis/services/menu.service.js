const menumodel = require('../model/menu.modal');

class menuService{
   static async registermenu(number,itemname,itemprice,itemdes,image,cat,type){
        try{
            const cretemenu = new menumodel({number,itemname,itemprice,itemdes,image,cat,type});
            return await cretemenu.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }
   
   static async allmenu(number,cat){
    try{
        return await menumodel.find({number,cat});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async allmenuwn(){
    try{
        return await menumodel.find();
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async allmenuadmin(number){
    try{
        return await menumodel.find({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedmenu(id,itemname,itemprice,itemdes,image,cat,type){
    try {
        await menumodel.findByIdAndUpdate(id,
             { $set: {itemname:itemname,itemprice:itemprice,itemdes:itemdes,image:image,cat:cat,type:type}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async deletemenu(id){
    try {
        await menumodel.findByIdAndDelete(id);
    } catch(e) {
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = menuService;
