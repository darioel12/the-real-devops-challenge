from os import environ
from fastapi import FastAPI, HTTPException, Depends
from fastapi.responses import JSONResponse
from fastapi.security import OAuth2PasswordBearer
from pymongo import MongoClient

app = FastAPI()

# Configuración de MongoDB
client = MongoClient("mongodb+srv://darioel12:4pr3ndi3nd0-M0ng0DB@dgb0.a9dusoj.mongodb.net/?retryWrites=true&w=majority")
db = client["prueba_intelligz"]
collection = db["restaurants"]

# Modelo de datos
class Item:
    def __init__(self, name: str, description: str):
        self.name = name
        self.description = description

# Ruta para obtener un item por su ID
@app.get("/api/v1/restaurant/{item_id}", response_model=None)
async def read_item(item_id: str):
    result = collection.find_one({"_id": item_id})
    if result:
        return [result]
    raise HTTPException(status_code=404, detail="Item not found")

# Ruta para obtener todos los items
@app.get("/api/v1/restaurant", response_model=None)
async def read_items(skip: int = 0):
    results = collection.find().skip(skip)
    return list(results)