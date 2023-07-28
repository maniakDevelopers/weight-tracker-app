const WeightService = require('../services/weight.service');

exports.addWeight = async (req,res,next)=>{
    try {
        const {userId,weight,weighed_on} = req.body;
    let weightRecord = await WeightService.addWeight(userId,weight,weighed_on);
     res.json({status:true,data:weightRecord});

    } catch (err) {
       throw err; 
    }
}


exports.getUserWeights = async (req,res,next)=>{
    try {
        const {userId} = req.body;
    let weights = await WeightService.getUserWeights(userId);
     res.json({status:true,data:weights});

    } catch (err) {
       throw err; 
    }
}


exports.deleteWeight = async (req,res,next)=>{
    try {
        const {id} = req.body;
    let deleted = await WeightService.deleteWeight (id);
     res.json({status:true,data:deleted});

    } catch (err) {
       throw err; 
    }
}
