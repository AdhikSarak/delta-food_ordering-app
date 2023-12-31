const mongoose = require('mongoose');
const { productSchema } = require('./product');

const userSchema = mongoose.Schema({
        name: {
                required: true,
                type : String,
                trim: true,
        },
        email: {
                required: true,
                type: String,
                trim: true,
                validate: {
                        validator: (value) => {
                                const re =
  /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
                                return value.match(re);
                        },
                        message: 'Please enter a valid Email Address',
                },
        },
        password: {
                required: true,
                type: String,
                validate: {
                        validator: (value) => {
                                
                                return value.length > 6;
                        },
                        message: 'Password must contain minimum 6 characters',
                },
        },
        address: {
                type: String,
                default: '',
        },
        type: {
                type: String, 
                default: 'user', 
        },
        cart: [
                {
                        product: productSchema,
                        quantity: {
                                type: Number,
                                required: true,
                        }
                },
        ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;