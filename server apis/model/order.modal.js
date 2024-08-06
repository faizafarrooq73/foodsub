const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const orderSchema = new Schema({
    restnumber:{
        type:String,
    },
    ridernumber:{
        type:String,
    },
    custnumber:{
        type:String,
    },
    datetime:{
        type:String,
    },
    menu:[
        {
            type: Map,
        },
    ],
    clat:{
        type:Number,
    },
    clon:{
        type:Number,
    },
    ulat:{
        type:Number,
    },
    ulon:{
        type:Number,
    },
    status:{
        type:String,
    },
    sechdule:{
        type:String,
    },
    sechduledays:{
        type:String,
    },
    sechduletime:{
        type:String,
    },
    reststatus:{
        type:String,
    },
    riderstatus:{
        type:String,
    },
    dis:{
        type:String,
    },
});

const orderModel = db.model('order',orderSchema);
module.exports = orderModel;