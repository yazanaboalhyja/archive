const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql');
const router = express.Router();
const natural = require('natural');
const _ = require('underscore');
require('dotenv').config();

router.use(bodyParser.json());

// Set up database connection
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

// Function to calculate cosine similarity between two strings

function tokenizeArabic(text) {
  const validTextRegex = /[\u0621-\u064A\u0660-\u0669]+/g;
  return text.match(validTextRegex) || [];
}

function tokenizeEnglish(text) {
  const tokenizer = new natural.WordTokenizer();
  return tokenizer.tokenize(text);
}

async function compareEnglish(textA, textB) {
  return compareText(textA, textB, tokenizeEnglish);
}

async function compareArabic(textA, textB) {
  return compareText(textA, textB, tokenizeArabic);
}

async function compareText(textA, textB, tokenizeFunction) {
  return new Promise((resolve, reject) => {
    const tokensA = tokenizeFunction(textA);
    const tokensB = tokenizeFunction(textB);

    try {
      const tfA = termFrequency(tokensA);
      const tfB = termFrequency(tokensB);
      //console.log(`Term Frequency A: ${JSON.stringify(tfA)}`);
      //console.log(`Term Frequency B: ${JSON.stringify(tfB)}`);

      const dotProd = dotProduct(tfA, tfB);
      const magnitudeA = magnitude(tfA);
      const magnitudeB = magnitude(tfB);
      //console.log(`Dot Product: ${dotProd}`);
     // console.log(`Magnitude A: ${magnitudeA}`);
      //console.log(`Magnitude B: ${magnitudeB}`);

      if (magnitudeA === 0 || magnitudeB === 0) {
          resolve(0); // Return 0 if either vector has zero magnitude
      }

      resolve(dotProd / (magnitudeA * magnitudeB));
    } catch (error) {
      console.error('Error in cosine similarity calculation:', error);
      reject(0); // Return 0 in case of error
    }
  });
}

function termFrequency(tokens) {
  const frequency = {};

  tokens.forEach(token => {
      frequency[token] = (frequency[token] || 0) + 1;
  });

  return frequency;
}

function dotProduct(vecA, vecB) {
  const keys = _.union(Object.keys(vecA), Object.keys(vecB));
  return keys.reduce((sum, key) => sum + (vecA[key] || 0) * (vecB[key] || 0), 0);
}

function magnitude(vec) {
  return Math.sqrt(_.reduce(vec, (sum, value) => sum + value * value, 0));
}


router.post('/ask', async (req, res) => {
  const { question } = req.body;
  
  // Determine the language of the question (English or Arabic)
  const isEnglish = isEnglishQuestion(question);
  const isArabic = isArabicQuestion(question);
  if (isEnglish) {
  db.query('SELECT * FROM faqs WHERE language = "en"', async (err, results) => {
    if (err) {
      console.error('Database error:', err);
      return res.status(500).json({ message: 'Internal server error' });
    }
    // Compare each retrieved English question with the input question
    const similarities = await Promise.all(results.map(row => compareEnglish(question, row.question)));
    // Find the maximum similarity
    const maxSimilarity = Math.max(...similarities);
    // If a similar question is found
    if (maxSimilarity > 0.4) {
      const bestMatchIndex = similarities.findIndex(similarity => similarity === maxSimilarity);
      return res.json({ answer: results[bestMatchIndex].answer });
    } else {
      return res.status(404).json({ message: 'No answer found' });
    }
  });
  } 
  else if (isArabic) {
    db.query('SELECT * FROM faqs WHERE language = "ar"', async (err, results) => {
      if (err) {
        console.error('Database error:', err);
        return res.status(500).json({ message: 'Internal server error' });
      }
  
      const similarities = await Promise.all(results.map(row => compareArabic(question, row.question)));
      const maxSimilarity = Math.max(...similarities);

      if (maxSimilarity > 0.4) {
        const bestMatchIndex = similarities.findIndex(similarity => similarity === maxSimilarity);
        return res.json({ answer: results[bestMatchIndex].answer });
      } else {
        return res.status(404).json({ message: 'No answer found' });
      }
    });
  }
  else{
    // Unsupported language
    return res.status(400).json({ message: 'Unsupported language' });
  }

});


function isEnglishQuestion(text) {
  const englishRegex = /[a-zA-Z]/;
  return englishRegex.test(text);
}

function isArabicQuestion(text) {
  const arabicRegex = /[\u0621-\u064A\u0660-\u0669]/;
  return arabicRegex.test(text);
}

module.exports = router;