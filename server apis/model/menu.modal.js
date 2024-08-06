const mongoose = require('mongoose');
const db = require('../config/db');

const { Schema } = mongoose;

const MenuSchema = new Schema({
    number:{
        type:String,
    },
    itemname:{
        type:String,
    },
    itemprice:{
        type:String,
    },
    itemdes:{
        type:String,
    },
    cat:{
        type:String,
    },
    image:{
        type:String,
    },
    type:{
        type:String,
    },
});

const menuModel = db.model('menu',MenuSchema);
module.exports = menuModel;
