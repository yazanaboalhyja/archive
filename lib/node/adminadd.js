const express = require('express');
const router = express.Router();
const bodyParser = require('body-parser');
const multer = require('multer');
const path = require('path');
const mysql = require('mysql');
const jwt = require('jsonwebtoken');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

db.connect((err) => {
  if (err) {
    throw err;
  }
});

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

router.use(bodyParser.json());

// Middleware to verify token
function verifyToken(req, res, next) {
  const token = req.headers['authorization'];

  if (!token) {
    return res.status(401).json({ message: 'Unauthorized' });
  }

  jwt.verify(token, 'AdminPage', (err, decoded) => {
    if (err) {
      return res.status(403).json({ message: 'Forbidden' });
    }

    if (!decoded.isAdmin) {
      return res.status(403).json({ message: 'Forbidden: Admins only' });
    }

    req.userId = decoded.userId;
    next();
  });
}


router.post('/add_martyrs1', verifyToken, upload.single('photo'), (req, res) => {
  const { full_name, date_of_birth, date_of_death, cause_of_death, nationality, place_of_death ,description} = req.body;
  const photo = req.file.filename;
  const submitted_by = req.userId; // Get the user ID from the token
  const INSERT_MARTYRS_QUERY = `INSERT INTO martyrs (full_name, date_of_birth, date_of_death, cause_of_death, nationality, place_of_death, image_url, submitted_by,description) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)`;
  db.query(INSERT_MARTYRS_QUERY, [full_name, date_of_birth, date_of_death, cause_of_death, nationality, place_of_death, photo, submitted_by,description], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    return res.status(200).json({ message: 'Martyr added' });
  });
});

router.post('/add_news1', verifyToken, upload.single('photo'), (req, res) => {
    const { name, description, source, type} = req.body;
    const photo = req.file.filename;
    const submitted_by = req.userId; // Get the user ID from the token
    const INSERT_MARTYRS_QUERY = `INSERT INTO news ( name, description, source, type, photo_url ,submitted_by) VALUES (?, ?, ?, ?, ?, ?)`;
    db.query(INSERT_MARTYRS_QUERY, [name, description, source, type, photo, submitted_by], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }
      return res.status(200).json({ message: 'news added' });
    });
  });

  router.post('/add_prisoners1', verifyToken, upload.single('photo'), (req, res) => {
    const { full_name, date_of_birth, date_of_arrest, place_of_birth, life_story } = req.body;
    const photo = req.file.filename;
    const submitted_by = req.userId; // Get the user ID from the token
    const INSERT_MARTYRS_QUERY = `INSERT INTO prisoners (name, date_of_birth, date_of_arrest, place_of_birth, life_story, photo_url, submitted_by) VALUES (?, ?, ?, ?, ?, ?, ?)`;
    db.query(INSERT_MARTYRS_QUERY, [full_name, date_of_birth, date_of_arrest, place_of_birth, life_story, photo, submitted_by], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }
      return res.status(200).json({ message: 'Martyr added' });
    });
  });

  router.post('/addvid1', verifyToken, upload.single('video'), (req, res) => {
    const { description, location } = req.body;
    const videoPath = req.file.filename;
    const uploadDate = new Date();
    const submitted_by = req.userId;  
  
    // Insert video information into database
    const query = 'INSERT INTO videos (video_path, description, upload_date, location, submitted_by, created_at) VALUES (?, ?, ?, ?, ?,NOW())';
    const values = [videoPath, description, uploadDate, location, submitted_by];
  
    db.query(query, values, (err, result) => {
      if (err) {
        console.error('Error inserting into database:', err);
        return res.status(500).json({ error: 'Database error' });
      }
  
      res.status(200).json({ message: 'Video uploaded successfully', videoId: result.insertId });
    });
  });

  router.post('/add_village1', verifyToken, upload.single('photo'), (req, res) => {
    const { name, city, historical_context, current_status } = req.body;
    const photo = req.file.filename;
    const submitted_by = req.userId; // Get the user ID from the token
    const INSERT_VILLAGE_QUERY = `INSERT INTO palestinian_villages (village_name, city, historical_context, current_status, image_url, created_at, submitted_by) VALUES (?, ?, ?, ?, ?, NOW(), ?)`;
    db.query(INSERT_VILLAGE_QUERY, [name, city, historical_context, current_status, photo, submitted_by], (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }
      return res.status(200).json({ message: 'Village added' });
    });
  });
module.exports = router;