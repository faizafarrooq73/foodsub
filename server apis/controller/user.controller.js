const UserService = require('../services/user.service');

exports.register = async(req,res,next)=>{
    try{
        const {number,name,img,cnic,pass,address,dob,cat,deviceid} = req.body;
        const response = await UserService.registerUser(number,name,img,cnic,pass,address,dob,cat,deviceid);
        res.json({status:true,sucess:"User registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}


exports.login = async(req,res,next)=>{
    try{
        const {number,pass,deviceid} = req.body;
        
        const user = await UserService.checkuser(number);
        if(!user){
            res.status(200).json({status:false,message:"no user found"});
        } else{

            const isMatch = await user.comparePassword(pass);
            if(isMatch == false){
                res.status(200).json({status:false,message:"invalid password"});
            } else{
                await UserService.updatedevice(user._id, deviceid);
                let tokenData = {number:user.number,name:user.name,
                    img:user.img,cnic:user.cnic,address:user.address,dob:user.dob,
                    cat:user.cat,deviceid: deviceid};
                const token = await UserService.generateToken(tokenData,"learnandearn","1h")
                res.status(200).json({status:true,token:token,message:"login in sucessfully"});
            }
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.getoneuser = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const user = await UserService.getoneuser(id);
        res.status(200).json({status:true,data:user});
    } catch (e){
        console.log(e)
        res.json({status:false,data:{}});
    }
}