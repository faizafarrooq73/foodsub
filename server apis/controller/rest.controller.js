const rstService = require('../services/rest.service');

exports.registerrest = async(req,res,next)=>{
    try{
        const {number,name,open,close,image,rating,user,review} = req.body;
        const response = await rstService.registerrest(number,name,open,close,image,rating,user,review);
        res.json({status:true,sucess:"table registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getallrest = async(req,res,next)=>{
    try{
        const rest = await rstService.getallrest();
        if(!rest){
            res.status(200).json({status:false,message:"no rest found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"login in sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getrest = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const rest = await rstService.getrest(number);
        if(!rest){
            res.status(200).json({status:false,message:"no rest found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"login in sucessfully"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.updaterest = async(req,res,next)=>{
    try{
        const {id,name,open,close,image,rating,user,review} = req.body;
        const rest = await rstService.updaterest(id,name,open,close,image,rating,user,review);
        if (!rest) {
            res.status(200).json({status:true,rest:rest,message:"update in sucessfully"});
        } else{
            res.status(200).json({status:false,message:"no rest found"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}
