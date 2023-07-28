const mongoose = require('mongoose');
//TODO : Move to config file
const connection = mongoose.createConnection('mongodb://localhost:2717/newasses')
        .on('open',()=>{
        console.log("Mongo connected!");
            })
        .on('error',()=>{
                console.log("Mongo connection error");

})

module.exports = connection;