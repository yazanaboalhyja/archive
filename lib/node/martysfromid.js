const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const path = require('path');
const router = express.Router();

// Database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

// Connect to database
db.connect((err) => {
  if (err) {
    console.error('Database connection error:', err);
    return;
  }
});

// Middleware to parse JSON bodies
router.use(bodyParser.json());

// Serve the uploads folder as static
router.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Route to search martyrs by ID and increase views
router.get('/martyrs/:id', (req, res) => {
  const martyrId = req.params.id;

  // SQL SELECT query to retrieve martyr details
  const SELECT_MARTYR_QUERY = `SELECT * FROM martyrs WHERE id = ?`;

  // Execute the query to retrieve martyr details
  db.query(SELECT_MARTYR_QUERY, [martyrId], (err, results) => {
    if (err) {
      console.error('Error searching for martyr:', err);
      res.status(500).json({ message: 'Error searching for martyr' });
      return;
    }

    if (results.length === 0) {
      res.status(404).json({ message: 'Martyr not found' });
      return;
    }

    // Increment views count
    const martyr = results[0];
    martyr.views += 1;

    // SQL UPDATE query to increase views count
    const UPDATE_VIEWS_QUERY = `UPDATE martyrs SET views = ? WHERE id = ?`;

    // Execute the query to update views count
    db.query(UPDATE_VIEWS_QUERY, [martyr.views, martyrId], (err) => {
      if (err) {
        console.error('Error updating views:', err);
        res.status(500).json({ message: 'Error updating views' });
        return;
      }

      // Modify image_url to include the full path
      martyr.image_url = martyr.image_url ? `${req.protocol}://${req.get('host')}/uploads/${martyr.image_url}` : null;

      // Return martyr details with updated views count
      res.status(200).json({ martyr });
    });
  });
});



module.exports = router;
