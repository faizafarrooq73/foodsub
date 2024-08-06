const promotion = require('../model/promotion.modal');
const app = require('express').Router();

app.post('/registerpromotion', async (req, res, next) => {
    try {
      const { number, img, dis, code, date } = req.body;
        const newpromotion = new promotion({ number, img, dis, code, date });
        await newpromotion.save();
        res.status(200).json({ status: true,});
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: false });
    }
});

app.post('/allpromotionbynum', async (req, res, next) => {
    try {
        const {number} = req.body;
      const user = await promotion.find({number});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/allpromotion', async (req, res, next) => {
    try {
      const user = await promotion.find();
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/deletepromotion', async (req, res, next) => {
    try {
        const {id} = req.body;
      const user = await promotion.findByIdAndDelete(id);
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

app.post('/promotionbycode', async (req, res, next) => {
    try {
        const {code} = req.body;
      const user = await promotion.findOne({code:code});
      res.status(200).json({ status:true ,data:user});
    } catch (error) {
      console.log(error);
      res.status(500).json({ status:false,data:[] });
    }
});

module.exports = app;