# FILE: models.py
# === DATABASE SCHEMA === 

from sqlalchemy import Column, Integer, String, Float
from database import Base

class ProductDB(Base):
    __tablename__= "products" # name of the table in SQL

    # Defined columns
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    price = Column(Float)
    icon_code = Column(Integer)