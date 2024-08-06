const itemmodel = require('../model/item.modal');

class itemService{
    static async registeritem(number, name) {
        try{
            const creteitem = new itemmodel({number, name});
            return await creteitem.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
    }
    

   static async getitem(number){
    try{
        return await itemmodel.find({number});
    } catch(e){
        console.log(e)
    }
   }


   static async deleteitem(id){
    try{
        return await itemmodel.findByIdAndDelete(id);
    } catch(e){
        console.log(e)
    }
   }

}

module.exports = itemService;