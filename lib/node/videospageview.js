const express = require('express');
const mysql = require('mysql');
const router = express.Router();
const path = require('path');

// Database connection
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: '',
  database: 'archive'
});

// Route to get all videos
router.get('/videos', (req, res) => {
  // SQL SELECT query to retrieve all videos
  const SELECT_VIDEOS_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM videos m JOIN users u ON m.submitted_by = u.id  ORDER BY views DESC`;

  // Execute the query to retrieve videos
  db.query(SELECT_VIDEOS_QUERY, (err, results) => {
    if (err) {
      console.error('Error retrieving videos:', err);
      res.status(500).json({ message: 'Error retrieving videos' });
      return;
    }

    // Modify each video URL to include the full path
    const videos = results.map(video => ({
      ...video,
      video_path: `${req.protocol}://${req.get('host')}/uploads/${video.video_path}`
    }));

    // Return videos
    res.status(200).json({ videos });
  });
});

// Route to search videos by description
router.get('/search_videos', (req, res) => {
  const description = req.query.description;
  if (!description) {
    return res.status(400).json({ message: 'Description query parameter is required' });
  }

  // SQL SELECT query to retrieve videos by description
  const SEARCH_VIDEOS_BY_DESCRIPTION_QUERY = `SELECT m.*, u.name AS submitted_by_name   FROM videos m JOIN users u ON m.submitted_by = u.id WHERE m.description LIKE ? ORDER BY views DESC`;

  // Execute the query to retrieve videos by description
  db.query(SEARCH_VIDEOS_BY_DESCRIPTION_QUERY, [`%${description}%`], (err, results) => {
    if (err) {
      console.error('Error searching for videos:', err);
      res.status(500).json({ message: 'Error searching for videos' });
      return;
    }

    // Modify each video URL to include the full path
    const videos = results.map(video => ({
      ...video,
      video_path: `${req.protocol}://${req.get('host')}/uploads/${video.video_path}`
    }));

    // Return videos with the specified description
    res.status(200).json({ videos });
  });
});

module.exports = router;
