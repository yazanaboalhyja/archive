const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const jwt = require('jsonwebtoken');
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
router.use(bodyParser.json());

// Serve the uploads folder as static
router.use('/uploads', express.static(path.join(__dirname, 'uploads')));
const getFileUrl = (filePath, req) => {
    return `${req.protocol}://${req.get('host')}/uploads/${filePath}`;
  };
// Middleware to verify token
const verifyToken = (req, res, next) => {
  const token = req.body.token || req.query.token || req.headers['authorization'];

  if (!token) {
    return res.status(403).json({ message: 'No token provided' });
  }

  jwt.verify(token, 'katkot', (err, decoded) => {
    if (err) {
      return res.status(500).json({ message: 'Failed to authenticate token' });
    }

    req.userId = decoded.userId;
    
    next();
  });
};

// Route to get profile data
router.post('/profile', verifyToken, (req, res) => {
  const userId = req.userId;

  const queries = [
    `SELECT *, video_path AS file_url FROM videos WHERE submitted_by = ?`,
    `SELECT *, photo_url AS file_url FROM news WHERE submitted_by = ?`,
    `SELECT *, photo_url AS file_url FROM prisoners WHERE submitted_by = ?`,
    `SELECT *, image_url AS file_url FROM martyrs WHERE submitted_by = ?`,
    `SELECT *, image_url AS file_url FROM palestinian_villages WHERE submitted_by = ?`
  ];
  const results = {};
  let completedQueries = 0;

  queries.forEach((query, index) => {
    db.query(query, [userId], (err, result) => {
      if (err) {
        console.error(`Error retrieving data from table ${index}:`, err);
        res.status(500).json({ message: 'Error retrieving data' });
        return;
      }

      result = result.map(item => ({
        ...item,
        file_url: item.file_url ? getFileUrl(item.file_url, req) : null
      }));

      switch (index) {
        case 0:
          results.videos = result;
          break;
        case 1:
          results.news = result;
          break;
        case 2:
          results.prisoners = result;
          break;
        case 3:
          results.martyrs = result;
          break;
        case 4:
          results.villages = result;
          break;
      }

      completedQueries++;
      if (completedQueries === queries.length) {
        res.status(200).json(results);
      }
    });
  });
});

router.put('/edit_prisoners/:id', verifyToken, (req, res) => {
  const prisonerId = req.params.id;
  const { date_of_arrest, life_story } = req.body;
  


  const UPDATE_PRISONERS_QUERY = `
    UPDATE prisoners 
    SET  date_of_arrest = ?,  life_story = ?
    WHERE id = ? AND submitted_by = ?
  `;

  db.query(UPDATE_PRISONERS_QUERY, [ date_of_arrest, life_story, prisonerId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Prisoner not found or unauthorized' });
    }
    return res.status(200).json({ message: 'Prisoner updated' });
  }); 
});

router.delete('/delete_prisoners/:id', verifyToken, (req, res) => {
  const prisonerId = req.params.id;

  const DELETE_PRISONERS_QUERY = `DELETE FROM prisoners WHERE id = ? AND submitted_by = ?`;

  db.query(DELETE_PRISONERS_QUERY, [prisonerId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Prisoner not found or unauthorized' });
    }
    return res.status(200).json({ message: 'Prisoner deleted' });
  });
});



router.put('/edit_news/:id', verifyToken, (req, res) => {
  const newsId = req.params.id;
  const {  description, source } = req.body;
  


  const UPDATE_NEWS_QUERY = `
    UPDATE news 
    SET  description = ?, source = ?
    WHERE id = ? AND submitted_by = ?
  `;

  db.query(UPDATE_NEWS_QUERY, [ description, source,  newsId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'News not found or unauthorized' });
    }
    return res.status(200).json({ message: 'News updated' });
  });
});

router.delete('/delete_news/:id', verifyToken, (req, res) => {
  const newsId = req.params.id;

  const DELETE_NEWS_QUERY = `DELETE FROM news WHERE id = ? AND submitted_by = ?`;

  db.query(DELETE_NEWS_QUERY, [newsId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'News not found or unauthorized' });
    }
    return res.status(200).json({ message: 'News deleted' });
  });
});


router.put('/edit_video/:id', verifyToken, (req, res) => {
  const videoId = req.params.id;
  const { description } = req.body;

  const UPDATE_VIDEO_DESCRIPTION_QUERY = `
    UPDATE videos 
    SET description = ? 
    WHERE id = ? AND submitted_by = ?
  `;

  db.query(UPDATE_VIDEO_DESCRIPTION_QUERY, [description, videoId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Video not found or unauthorized' });
    }
    return res.status(200).json({ message: 'Video description updated' });
  });
});

router.delete('/delete_video/:id', verifyToken, (req, res) => {
  const videoId = req.params.id;

  const DELETE_VIDEO_QUERY = `DELETE FROM videos WHERE id = ? AND submitted_by = ?`;

  db.query(DELETE_VIDEO_QUERY, [videoId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Video not found or unauthorized' });
    }
    return res.status(200).json({ message: 'Video deleted' });
  });
});

router.put('/edit_village/:id', verifyToken, (req, res) => {
  const villageId = req.params.id;
  const { historical_context, current_status } = req.body;

  const UPDATE_VILLAGE_QUERY = `
    UPDATE palestinian_villages 
    SET historical_context = ?, current_status = ? 
    WHERE id = ? AND submitted_by = ?
  `;

  db.query(UPDATE_VILLAGE_QUERY, [historical_context, current_status, villageId, req.userId], (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    if (results.affectedRows === 0) {
      return res.status(404).json({ message: 'Village not found or unauthorized' });
    }
    return res.status(200).json({ message: 'Village information updated' });
  });
});
module.exports = router;
