# Kaleb Newton | March 2026
# FILE: main.py
# THE BACKEND ENGINE 

from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
import models
from database import engine, SessionLocal

# Create the database tables automatically when server starts
models.Base.metadata.create_all(bind=engine)

# Initialize the server application
app = FastAPI()

# Dependency: A helper function to open and close the database safely
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
        
# THE API ENDPOINT
# When a user (or app) visits the "/products" URL, run this function
@app.get("/products")
def get_products(db: Session = Depends(get_db)):
    # FastAPI automatically converts Python lists/dictionaries into perfect JSON!
    #return [
    #    {"name": "Pro Headphones", "price": 199.99, "icon_code": 58268},
    #   {"name": "Smart Watch", "price": 249.99, "icon_code": 58711},
    #    {"name": "Wireless Mouse", "price": 49.99, "icon_code": 58210}
    products = db.query(models.ProductDB).all()

    # Dictionaries that fastAPI turns into JSON
    clean_products = []
    for p in products:
        clean_products.append({
            "name": p.name,
            "price": p.price,
            "icon_code": p.icon_code
        })
        
    return clean_products

# Quickly fill database 
@app.post("/seed")
def seed_database(db: Session = Depends(get_db)):
    # Checks data to prevent duplicates
    if db.query(models.ProductDB).first():
        return {"message": "Database is already seeded with data!!"}

        # Creating initial products
    initial_products = [
        models.ProductDB(name="Pro Headphones", price=199.99, icon_code=58268),
        models.ProductDB(name="Smart Watch", price=249.99, icon_code=58711),
        models.ProductDB(name="Wireless Mouse", price=49.99, icon_code=58210)
    ]   

    # add them to database and save changes
    db.add_all(initial_products)
    db.commit()

    return {"message": "Successfully seeded the database with 3 items!!"}