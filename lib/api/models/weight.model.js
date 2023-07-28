const mongoose = require('mongoose');
const db = require('../config/db');
const UserModel = require('../models/user.model')   
const {Schema} = mongoose;

const weightSchema = new Schema({
    userId:{
        type:Schema.Types.ObjectId,
        ref:UserModel.modelName
    },
    weight : {
        type:String,
        required:true
    },
    weighed_on:{
        type:Date,
        required:true
    }    

})

const WeightModel = db.model('weight',weightSchema);



module.exports = WeightModel;


