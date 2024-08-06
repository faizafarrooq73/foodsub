const menuService = require('../services/menu.service');

exports.registermenu = async(req,res,next)=>{
    try{
        const {number,itemname,itemprice,itemdes,image,cat,type} = req.body;
        const response = await menuService.registermenu(number,itemname,itemprice,itemdes,image,cat,type);
        res.json({status:true,sucess:"table registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.allmenu = async(req,res,next)=>{
    try{
        const {number,cat} = req.body;
        const rest = await menuService.allmenu(number,cat);
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

exports.allmenuwn = async(req,res,next)=>{
    try{
        const rest = await menuService.allmenuwn();
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


exports.allmenuadmin = async(req,res,next)=>{
    try{
        const {number} = req.body;
        const rest = await menuService.allmenuadmin(number);
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

exports.updatedmenu = async(req,res,next)=>{
    try{
        const {id,itemname,itemprice,itemdes,image,cat,type} = req.body;
        const rest = await menuService.updatedmenu(id,itemname,itemprice,itemdes,image,cat,type);
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

exports.deletemenu = async(req,res,next)=>{
    try{
        const {id} = req.body;
        const rest = await menuService.deletemenu(id);
        if(!rest){
            res.status(200).json({status:true,message:"deleted table"});
        } else{
            res.status(200).json({status:false,message:"no table found"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}
