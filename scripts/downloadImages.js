import { promises as fsPromises } from 'fs';
import fs from 'fs';
import path from 'path';
import https from 'https';
import http from 'http';
import { fileURLToPath } from 'url';
import dotenv from 'dotenv';

console.log('Starting script...');

try {
  console.log('Importing plant data...');
  const { plantData } = await import('../src/data/plantImages.js');
  console.log('Plant data imported successfully:', Object.keys(plantData));

  // Load environment variables
  console.log('Loading environment variables...');
  dotenv.config({ path: '.env.local' });
  console.log('API Key:', process.env.GOOGLE_API_KEY ? 'Present' : 'Missing');
  console.log('Search Engine ID:', process.env.GOOGLE_SEARCH_ENGINE_ID ? 'Present' : 'Missing');

  const __filename = fileURLToPath(import.meta.url);
  const __dirname = path.dirname(__filename);

  // Create images directory if it doesn't exist
  const imagesDir = path.join(__dirname, '..', 'public', 'images');
  console.log('Creating images directory at:', imagesDir);
  await fsPromises.mkdir(imagesDir, { recursive: true }).catch(() => {});

  // Function to download image
  function downloadImage(url, filepath) {
    return new Promise((resolve, reject) => {
      const protocol = url.startsWith('https:') ? https : http;
      
      protocol.get(url, (response) => {
        if (response.statusCode === 200) {
          const writeStream = fs.createWriteStream(filepath);
          response.pipe(writeStream);
          writeStream.on('finish', () => {
            writeStream.close();
            resolve();
          });
          writeStream.on('error', (err) => {
            fs.unlink(filepath, () => {}); // Delete the file if there was an error
            reject(err);
          });
        } else if (response.statusCode === 302 || response.statusCode === 301) {
          // Handle redirects
          console.log(`Following redirect to: ${response.headers.location}`);
          downloadImage(response.headers.location, filepath)
            .then(resolve)
            .catch(reject);
        } else {
          reject(`Failed to download image: ${response.statusCode}`);
        }
      }).on('error', (err) => {
        reject(err.message);
      });
    });
  }

  // Function to search for image using Google Custom Search API
  async function searchImage(query) {
    const apiKey = process.env.GOOGLE_API_KEY;
    const searchEngineId = process.env.GOOGLE_SEARCH_ENGINE_ID;
    
    if (!apiKey || !searchEngineId) {
      throw new Error('Google API key and Search Engine ID are required in .env.local file');
    }

    const searchUrl = `https://www.googleapis.com/customsearch/v1?key=${apiKey}&cx=${searchEngineId}&q=${encodeURIComponent(query + ' растение фото')}&searchType=image&imgSize=large&num=1&safe=active`;
    console.log('Searching with URL:', searchUrl);

    return new Promise((resolve, reject) => {
      https.get(searchUrl, (response) => {
        let data = '';
        response.on('data', chunk => data += chunk);
        response.on('end', () => {
          try {
            const result = JSON.parse(data);
            if (result.items && result.items.length > 0) {
              resolve(result.items[0].link);
            } else {
              console.log('API Response with no items:', data);
              reject('No image found');
            }
          } catch (err) {
            console.error('Failed to parse API response:', err);
            console.error('Raw response:', data);
            reject('Failed to parse API response');
          }
        });
      }).on('error', reject);
    });
  }

  // Download all images
  async function downloadAllImages() {
    console.log('Starting image downloads...');
    
    for (const [plantName, data] of Object.entries(plantData)) {
      const filename = data.image.split('/').pop();
      const filepath = path.join(imagesDir, filename);
      
      try {
        console.log(`Searching for ${plantName}...`);
        const imageUrl = await searchImage(plantName);
        
        console.log(`Downloading ${filename} from ${imageUrl}...`);
        await downloadImage(imageUrl, filepath);
        console.log(`Successfully downloaded ${filename}`);
        
        // Wait a bit to avoid hitting API rate limits
        await new Promise(resolve => setTimeout(resolve, 2000));
      } catch (error) {
        console.error(`Error processing ${plantName}:`, error);
      }
    }
    
    console.log('Download process completed!');
  }

  // Run the script
  await downloadAllImages();
} catch (error) {
  console.error('Script failed:', error);
} 