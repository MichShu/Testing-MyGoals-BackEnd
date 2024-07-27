//import express
const express = require('express')

//import CORS
const cors = require('cors')

//import bodyParser
const bodyParser = require('body-parser')

//import router
const router = require('./routes')

//init app
const app = express()

//use cors
app.use(cors())

//use body parser
app.use(bodyParser.urlencoded({ extended: false }))

// parse application/json
app.use(bodyParser.json())

//define port
const port = 3000;

//route
// app.get('/', (req, res) => {
//   res.send('Hello World!')
// })

const prisma = require('./prisma/client');

app.get('/test-db', async (req, res) => {
  try {
    const positions = await prisma.position.findMany();
    const subunits = await prisma.subUnit.findMany();
    res.json({ positions, subunits });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});


//define routes
app.use('/api', router);

//start server
app.listen(port, () => {
    console.log(`Server started on port ${port}`);
})