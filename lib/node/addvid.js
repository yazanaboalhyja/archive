const express = require('express');
const router = express.Router();
const multer = require('multer');
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

// Configure multer for file uploads
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + '-' + file.originalname);
  }
});

const upload = multer({ storage: storage });

// Middleware to parse JSON bodies
router.use(express.json());
router.use(express.urlencoded({ extended: true }));

// Middleware to authenticate token
function authenticateToken(req, res, next) {
    const token = req.headers['authorization'];
    if (!token) {
      return res.status(401).json({ message: 'Unauthorized' });
    }
  
    jwt.verify(token, 'katkot', (err, decoded) => {
      if (err) {
        return res.status(403).json({ message: 'Forbidden' });
      }
      req.userId = decoded.userId;
      next();
    });
}

// POST route to upload video
router.post('/addvid', authenticateToken, upload.single('video'), (req, res) => {
  const { description, location } = req.body;
  const videoPath = req.file.path;
  const uploadDate = new Date();
  const submitted_by = req.userId;  

  // Insert video information into database
  const query = 'INSERT INTO review_videos (video_path, description, upload_date, location, submitted_by) VALUES (?, ?, ?, ?, ?)';
  const values = [videoPath, description, uploadDate, location, submitted_by];

  db.query(query, values, (err, result) => {
    if (err) {
      console.error('Error inserting into database:', err);
      return res.status(500).json({ error: 'Database error' });
    }

    res.status(200).json({ message: 'Video uploaded successfully', videoId: result.insertId });
  });
});

module.exports = router;
