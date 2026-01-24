from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
import os
import time

# 1. Matches your docker-compose service name 'mysql' and db 'phase1_db'
DEFAULT_URL = "mysql://root:password@mysql:3306/phase1_db"
SQLALCHEMY_DATABASE_URL = os.getenv("DATABASE_URL", DEFAULT_URL)

# 2. Add Resiliency: Retry connection 5 times before giving up
engine = None
for attempt in range(5):
    try:
        engine = create_engine(SQLALCHEMY_DATABASE_URL)
        engine.connect()
        print("Successfully connected to the database!")
        break
    except Exception as e:
        print(f"Database connection attempt {attempt + 1} failed. Retrying in 5s...")
        time.sleep(5)

if not engine:
    raise Exception("Could not connect to the database after multiple attempts.")

SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)
Base = declarative_base()

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
