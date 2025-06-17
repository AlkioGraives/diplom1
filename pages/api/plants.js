import mysql from "mysql2/promise";

export default async function handler(req, res) {
  // Connect using the Railway cloud database URL
  const db = await mysql.createConnection(process.env.MYSQL_URL);

  try {
    const [rows] = await db.execute(
      "SELECT p.id, p.name_ru, p.name_lat, t.family, t.genus, t.species, p.description FROM plants p JOIN taxonomy t ON p.taxonomy_id = t.id"
    );
    res.status(200).json(rows);
  } catch (error) {
    console.error("DB Error:", error);
    res.status(500).json({ error: "Database error" });
  } finally {
    await db.end();
  }
}