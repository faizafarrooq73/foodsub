const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const promotionSchema = new Schema({
    number:{
        type:String,
    },
    img:{
        type:String,
    },
    dis:{
        type:String,
    },
    code:{
        type:String,
    },
    date:{
        type:String,
    },
});

const promotionModel = db.model('promotion',promotionSchema);
module.exports = promotionModel;