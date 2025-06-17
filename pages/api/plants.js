import mysql from "mysql2/promise";

export default async function handler(req, res) {
  const db = await mysql.createConnection({
    host: process.env.DB_HOST || "localhost",
    user: process.env.DB_USER || "root",
    password: process.env.DB_PASSWORD || "root",
    database: process.env.DB_NAME || "botanical_db"
  });

  try {
    const [rows] = await db.execute("SELECT p.id, p.name_ru, p.name_lat, t.family, t.genus, t.species, p.description FROM plants p JOIN taxonomy t ON p.taxonomy_id = t.id");
    res.status(200).json(rows);
  } catch (error) {
    console.error("DB Error:", error);
    res.status(500).json({ error: "Database error" });
  } finally {
    await db.end();
  }
}