const router = require('express').Router();
const weightController = require('../controllers/weight.controller');

router.post('/save_weight',weightController.addWeight);
router.get('/get_weight_history',weightController.getUserWeights);
router.post('/delete_weight',weightController.deleteWeight);
module.exports = router;