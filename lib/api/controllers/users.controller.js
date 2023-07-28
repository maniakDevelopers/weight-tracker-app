const UserService = require("../services/user.service")

exports.register = async(req,res,next)=>{

    try{
        const {email,password} = req.body;

        const successRes = await UserService.registerUser(email,password);

        res.json({status:true,success:"User Registered Successfully"});
    }catch(err){
        throw err;
    }
}


exports.login = async(req,res,next)=>{

    try{
        const {email,password} = req.body;
        const user = await UserService.checkuser(email);

        if(!user){
            throw new Error('User does n ot exist');
        }

        const isMatch = await user.comparePassword(password);

        if(isMatch === false){
            throw new Error('Password Invalid');
        }

        let tokenData = {id:user._id,email:user.email};

        const token = await UserService.generateToken(tokenData,"secretKey","60s");
        res.status(200).json({status:true,token:token});


    }catch(err){
        throw err;
    }
}