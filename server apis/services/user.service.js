const usermodel = require('../model/user.modal');
const jwt = require("jsonwebtoken");

class UserService{
   static async registerUser(number,name,img,cnic,pass,address,dob,cat,deviceid){
        try{
            const creteuser = new usermodel({number,name,img,cnic,pass,address,dob,cat,deviceid});
            return await creteuser.save();
        } catch(e){
            console.log(e)
            res.json({status:false,sucess:"server error service register"});
        }
   }

   static async checkuser(number){
    try{
        return await usermodel.findOne({number});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async updatedevice(userId,deviceid){
    try{
        await usermodel.findByIdAndUpdate(userId, { $set: { deviceid: deviceid } });
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

   static async generateToken(tokenData,secretKey,jwt_expiry){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expiry});
   }

   
   static async getoneuser(id){
    try{
        return await usermodel.findOne({number:id});
    } catch(e){
        console.log(e)
            res.json({status:false,sucess:"server error service chcekuser"});
    }
   }

}

module.exports = UserService;