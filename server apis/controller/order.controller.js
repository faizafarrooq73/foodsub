const orderService = require('../services/order.service');

exports.registeroder = async(req,res,next)=>{
    try{
        const {restnumber,ridernumber,custnumber,datetime,menu,clat,clon,ulat,ulon,status,sechdule,sechduledays,sechduletime,reststatus,riderstatus,dis} = req.body;
        const response = await orderService.registeroder(restnumber,ridernumber,custnumber,datetime,menu,clat,clon,ulat,ulon,status,sechdule,sechduledays,sechduletime,reststatus,riderstatus,dis);
        res.json({status:true,sucess:"order registered Sucessfully"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller register"});
    }
}

exports.getbyrest = async(req,res,next)=>{
    try{
        const {restnumber} = req.body;
        const rest = await orderService.getbyrest(restnumber);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getbyuser = async(req,res,next)=>{
    try{
        const {custnumber} = req.body;
        const rest = await orderService.getbyuser(custnumber);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}

exports.getbyrider = async(req,res,next)=>{
    try{
        const {ridernumber} = req.body;
        const rest = await orderService.getbyrider(ridernumber);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.getbyriderstatus = async(req,res,next)=>{
    try{
        const {riderstatus} = req.body;
        const rest = await orderService.getbyriderstatus(riderstatus);
        if(!rest){
            res.status(200).json({status:false,message:"no order found"});
        } else{
            res.status(200).json({status:true,rest:rest,message:"order founded"});
        }
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.updatereststatus = async(req,res,next)=>{
    try{
        const {id,reststatus,riderstatus} = req.body;
        const rest = await orderService.updatereststatus(id,reststatus,riderstatus);
        res.status(200).json({status:false,"sucess":"updated"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.updateriderstatus = async(req,res,next)=>{
    try{
        const {id,status,riderstatus,clat,clon,ridernumber} = req.body;
        const rest = await orderService.updateriderstatus(id,status,riderstatus,clat,clon,ridernumber);
        res.status(200).json({status:false,"sucess":"updated"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.doneorder = async(req,res,next)=>{
    try{
        const {id,status} = req.body;
        const rest = await orderService.doneorder(id,status);
        res.status(200).json({status:false,"sucess":"updated"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}


exports.updateloc = async(req,res,next)=>{
    try{
        const {id,clat,clon} = req.body;
        const rest = await orderService.updateloc(id,clat,clon);
        res.status(200).json({status:false,"sucess":"updated"});
    } catch (e){
        console.log(e)
        res.json({status:false,sucess:"server error controller login"});
    }
}