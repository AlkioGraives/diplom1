require('dotenv').config({ path: '.env.local' });

console.log('Starting test script...');
console.log('Environment variables:');
console.log('GOOGLE_API_KEY:', process.env.GOOGLE_API_KEY ? 'Present' : 'Missing');
console.log('GOOGLE_SEARCH_ENGINE_ID:', process.env.GOOGLE_SEARCH_ENGINE_ID ? 'Present' : 'Missing'); 