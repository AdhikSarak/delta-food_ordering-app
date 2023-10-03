const express = require('express');
const mongoose = require('mongoose');

const authRouter = require("./routes/auth");
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');

const DB = "mongodb+srv://adhiksarak:adhiksarak@cluster0.m2rdfzp.mongodb.net/?retryWrites=true&w=majority"
const PORT = 3000;
const app = express();

//Middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//Connections
mongoose.connect(DB).then( () => {
        console.log("Connected to Database");
})
.catch( (e) => {
        console.log(e);
})


app.listen(PORT, "0.0.0.0", () => {
        console.log("Connected at port: " + PORT);
})