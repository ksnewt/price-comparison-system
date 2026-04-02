# FILE: database.py
# --- THE DATABASE CONNECTION ---

from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, declarative_base

# To tells SQLite to create a file named "price_app.db" in folder 
SQLALCHEMY_DATABASE_URL = "sqlite:///./price_app.db"

# This engine is the physical connection to the database
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"check_same_thread": False})

# The Session is what we use to actually "talk" to the database for query add delete
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Blueprint that the tables will inherit from
Base = declarative_base()