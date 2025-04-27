const express = require('express');
const cors = require('cors');
const userRoutes = require('./routes/userRoutes');
require('dotenv').config();

const app = express();
const PORT= process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

// Routers
app.use('/api', userRoutes);

app.get('/', (req, res) => {
    res.send('Address Validation API');
});

app.listen(PORT, ()=> {
    console.log(`Server running on http://localhost:${PORT}`);
});