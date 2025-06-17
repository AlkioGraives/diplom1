import { useState, useEffect } from "react";
import Image from "next/image";
import { plantData } from "../src/data/plantImages";
import Head from "next/head";

export default function Home() {
  const [plants, setPlants] = useState([]);
  const [search, setSearch] = useState("");

  useEffect(() => {
    fetch("/api/plants")
      .then((res) => res.json())
      .then((data) => setPlants(data));
  }, []);

  const filtered = plants.filter((plant) => {
    const q = search.toLowerCase();
    return (
      plant.name_ru?.toLowerCase().includes(q) ||
      plant.genus?.toLowerCase().includes(q) ||
      plant.species?.toLowerCase().includes(q)
    );
  });

  return (
    <>
      <Head>
        <title>Ботанический справочник</title>
        <link rel="icon" href="/avatar.png" />
      </Head>
      <div style={{ minHeight: '100vh', display: 'flex', flexDirection: 'column', justifyContent: 'center', alignItems: 'center', background: '#f5f5f5' }}>
        <header className="header" style={{ background: 'linear-gradient(to right, #2f855a, #276749)', color: 'white', padding: '2rem 1rem', boxShadow: '0 2px 4px rgba(0,0,0,0.1)', width: '100%', textAlign: 'center' }}>
          <h1 style={{ fontSize: '2rem', marginBottom: '1rem' }}>Ботанический справочник</h1>
          <div className="search-container" style={{ maxWidth: 600, margin: '1.5rem auto', padding: '0 1rem' }}>
            <input
              type="text"
              placeholder="Поиск по названию, роду или виду..."
              value={search}
              onChange={(e) => setSearch(e.target.value)}
              className="search-input"
              style={{ width: '100%', padding: '1rem 1.5rem', fontSize: '1.1rem', border: '2px solid rgba(255,255,255,0.2)', borderRadius: 9999, backgroundColor: 'rgba(255,255,255,0.9)', transition: 'all 0.3s ease' }}
            />
          </div>
        </header>
        <div className="plant-grid" style={{ maxWidth: 1200, margin: '0 auto', padding: '1.5rem', display: 'grid', gridGap: '1.5rem', width: '100%' }}>
          {filtered.map((plant) => {
            const imagePath = plantData[plant.name_ru];
            
            return (
              <div key={plant.id} className="plant-card">
                <div className="plant-image-container">
                  {imagePath ? (
                    <Image
                      src={imagePath}
                      alt={plant.name_ru}
                      fill
                      sizes="(max-width: 640px) 100vw, (max-width: 1024px) 50vw, 33vw"
                      className="plant-image"
                      style={{ objectFit: 'cover' }}
                      priority={false}
                      onError={(e) => {
                        e.currentTarget.src = 'data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjAwIiBoZWlnaHQ9IjIwMCIgdmlld0JveD0iMCAwIDIwMCAyMDAiIGZpbGw9Im5vbmUiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PHJlY3Qgd2lkdGg9IjIwMCIgaGVpZ2h0PSIyMDAiIGZpbGw9IiNFNUU3RUIiLz48cGF0aCBkPSJNMTAwIDcwQzg0LjUgNzAgNzIgODIuNSA3MiA5OEM3MiAxMTMuNSA4NC41IDEyNiAxMDAgMTI2QzExNS41IDEyNiAxMjggMTEzLjUgMTI4IDk4QzEyOCA4Mi41IDExNS41IDcwIDEwMCA3MFpNMTAwIDExNkM5MC4xIDE2MCA4Mi45IDEwOC45IDgyLjkgOThDODIuOSA4Ny4xIDkwLjEgNzguMyAxMDAgNzguM0MxMDkuOSA3OC4zIDExNy4xIDg3LjEgMTE3LjEgOThDMTE3LjEgMTA4LjkgMTA5LjkgMTE2IDEwMCAxMTZaIiBmaWxsPSIjOTRBM0IyIi8+PC9zdmc+';
                      }}
                    />
                  ) : (
                    <div className="plant-image-placeholder">
                      <svg className="w-12 h-12 text-gray-300" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z" />
                      </svg>
                    </div>
                  )}
                </div>
                <div className="plant-card-header">
                  <h2 className="plant-title">{plant.name_ru}</h2>
                  <p className="plant-subtitle">{plant.name_lat}</p>
                </div>
                <div className="plant-card-body">
                  <p className="plant-info">Семейство: {plant.species}</p>
                  <p className="plant-info">Род: {plant.family}</p>
                  <p className="plant-info">Вид: {plant.genus}</p>
                  <p className="plant-description">{plant.description || 'Описание отсутствует'}</p>
                </div>
              </div>
            );
          })}
        </div>
      </div>
    </>
  );
}
