const router = require('express').Router();
const UserController = require("../controllers/users.controller");

router.post('/sign_up',UserController.register);
router.post('/login',UserController.login)

module.exports = router;