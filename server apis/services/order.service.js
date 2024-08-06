const ordermodel = require('../model/order.modal');

class orderService{
   static async registeroder(restnumber,ridernumber,custnumber,datetime,menu,clat,clon,ulat,ulon,status,sechdule,sechduledays,sechduletime,reststatus,riderstatus,dis){
        try{
            const creteorder = new ordermodel({restnumber,ridernumber,custnumber,datetime,menu,clat,clon,ulat,ulon,status,sechdule,sechduledays,sechduletime,reststatus,riderstatus,dis});
            return await creteorder.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        } 
   }

   static async getbyrest(restnumber){
    try{
        return await ordermodel.find({restnumber}).sort({datetime:-1,restnumber:-1});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getbyuser(custnumber){
    try{
        return await ordermodel.find({custnumber}).sort({datetime:-1});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getbyrider(ridernumber){
    try{
        return await ordermodel.find({ridernumber}).sort({datetime:-1});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async getbyriderstatus(riderstatus){
    try{
        return await ordermodel.find({riderstatus});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatereststatus(id,reststatus,riderstatus){
    try{
        await ordermodel.findByIdAndUpdate(id, { $set: { reststatus: reststatus, riderstatus:riderstatus } });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async updateriderstatus(id,status,riderstatus,clat,clon,ridernumber){
    try{
        await ordermodel.findByIdAndUpdate(id, { $set: { status: status, riderstatus:riderstatus ,clat:clat , clon:clon , ridernumber:ridernumber } });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async doneorder(id,status){
    try{
        await ordermodel.findByIdAndUpdate(id, { $set: { status: status} });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }


   static async updateloc(id,clat,clon){
    try{
        await ordermodel.findByIdAndUpdate(id, { $set: { clat: clat, clon:clon} });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }
}

module.exports = orderService;