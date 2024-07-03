const express = require('express');
const app = express();

const signinRouter = require('./signin');
const signupRouter = require('./signup');
const martysdiethisday = require('./martysthisday');
//const getmartysfromid = require('./martysfromid');
const addmartyrsRouter = require('./addmartyrs');
const addprisonerRouter = require('./addprisoner');
const addvidRouter = require('./addvid');
const verifyRouter = require('./verify');
const forgetpassRouter = require('./forgetpass');
const martyrspageviewRouter = require('./martyrspageview');
const prisonerspageviewRouter = require('./prisonerspageview');
const newspageviewRouter = require('./newspageview');
const vidpageviewRouter = require('./videospageview');
const villagespageviewRouter = require('./villagespageview');
const increaseviewsRouter = require('./increaseviews');
const profileRouter = require('./profile');
const addnewsRouter = require('./addnews');
const addvillageRouter = require('./addvillage');
const AIchatRouter = require('./AIchat');
//admin
const adminsginRouter = require('./adminsignin');
const dashboardRouter = require('./admindashbord');
const adminpostsRouter = require('./adminposts');
const acceptdeclineRouter = require('./acceptdeclinepage');
const adminaddRouter = require('./adminadd');
const createadminRouter = require('./createadmin');












app.use('/', signinRouter);
app.use('/', addmartyrsRouter);
app.use('/', signupRouter);
app.use('/', martysdiethisday);
app.use('/', addprisonerRouter);
//app.use('/', getmartysfromid);
app.use('/', addvidRouter);
app.use('/', verifyRouter);
app.use('/', forgetpassRouter);
app.use('/', martyrspageviewRouter);
app.use('/', addnewsRouter);
app.use('/', addvillageRouter);
app.use('/', AIchatRouter);
app.use('/', prisonerspageviewRouter);
app.use('/', newspageviewRouter);
app.use('/', vidpageviewRouter);
app.use('/', villagespageviewRouter);
app.use('/', increaseviewsRouter);
app.use('/', profileRouter);
app.use('/', adminsginRouter);
app.use('/', dashboardRouter);
app.use('/', adminpostsRouter);
app.use('/', acceptdeclineRouter);
app.use('/', adminaddRouter);   
app.use('/', createadminRouter);   







const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
