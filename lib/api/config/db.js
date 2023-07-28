const mongoose = require('mongoose');
//TODO : Move to config file
const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/weightdb')
        .on('open',()=>{
        console.log("Mongo connected!");
            })
        .on('error',err=>{
                console.log("Mongo connection error",err);

})

module.exports = connection;