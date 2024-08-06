const restmodel = require('../model/rest.modal');

class restService{
   static async registerrest(number,name,open,close,image,rating,user,review){
        try{
            const cretemenu = new restmodel({number,name,open,close,image,rating,user,review});
            return await cretemenu.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async getrest(number){
    try{
        return await restmodel.find({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async getallrest(){
    try{
        return await restmodel.find();
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updaterest(id,name,open,close,image,rating,user,review){
    try {
        await restmodel.findByIdAndUpdate(id,
             { $set: {name:name,open:open,close:close,image:image,rating:rating,
                user:user,review:review}});
    } catch(e) {
        console.log(e)
        res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = restService;
