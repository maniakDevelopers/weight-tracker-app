const WeightModel = require('../models/weight.model');

class WeightService{
 static async addWeight(userId,weight,weighed_on){
    const createWeight = new WeightModel({userId,weight,weighed_on});
    return await createWeight.save();
 }

 static async getUserWeights(userId){
   const weights = await WeightModel.find({userId}).sort("-weighed_on");
    return weights;
 }

 static async deleteWeight(id){
    const deleted = await WeightModel.findOneAndDelete({_id:id});
    return deleted;
 }

}

module.exports = WeightService;