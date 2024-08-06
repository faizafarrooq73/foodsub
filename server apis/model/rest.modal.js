const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const restSchema = new Schema({
    number:{
        type:String,
    },
    name:{
        type:String,
    },
    open:{
        type:String,
    },
    close:{
        type:String,
    },
    image:{
        type:String,
    },
    rating:{
        type:String,
    },
    user:{
        type:String,
    },
    review:[],
});

const restModel = db.model('rest',restSchema);
module.exports = restModel;
