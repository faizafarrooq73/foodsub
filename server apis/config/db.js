const mongoose = require('mongoose');

const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/food_sub')
    .on('open',()=>{
    console.log('MongoDb connected');
}).on('error',()=>{
    console.log('MongoDb error');
});

module.exports = connection;
