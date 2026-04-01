# Kaleb Newton | March 2026
# FILE: main.py
# THE BACKEND ENGINE 

from fastapi import FastAPI

# Initialize the server application
app = FastAPI()

# THE API ENDPOINT
# When a user (or app) visits the "/products" URL, run this function
@app.get("/products")
def get_products():
    # FastAPI automatically converts Python lists/dictionaries into perfect JSON!
    return [
        {"name": "Pro Headphones", "price": 199.99, "icon_code": 58268},
        {"name": "Smart Watch", "price": 249.99, "icon_code": 58711},
        {"name": "Wireless Mouse", "price": 49.99, "icon_code": 58210}
    ]