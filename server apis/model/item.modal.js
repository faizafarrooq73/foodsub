const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const itemSchema = new Schema({
    number:{
        type:String,
    },
    name:{
        type:String,
    },
});

const itemModel = db.model('item',itemSchema);
module.exports = itemModel;