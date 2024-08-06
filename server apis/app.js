const express = require("express");
const bodyParser = require("body-parser")
const UserRoute = require("./routers/user.route");
const itemRoute = require("./routers/item.route");
const menuRoute = require("./routers/menu.route");
const restRoute = require("./routers/rest.route");
const orderRoute = require("./routers/order.route");
const chatRoute = require("./routers/chat.route");
const promotionRoute = require("./routers/promotion.route");

const app = express();
app.use(bodyParser.json());
app.use("/",UserRoute);
app.use("/",itemRoute);
app.use("/",menuRoute);
app.use("/",restRoute);
app.use("/",orderRoute);
app.use("/",chatRoute);
app.use("/",promotionRoute);

module.exports = app;
