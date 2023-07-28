const app = require('./app');
const db = require('./config/db');
const UserModel = require('./models/user.model');
const WeightModel = require('./models/weight.model');

//TODO : Move to config file
const port = 3000;

app.get('/',(req,res)=>{
 res.send("Alive!!!");

});

app.listen(port,()=>{
    console.log(`Server Listening on port http://localhost:${port}`);
})