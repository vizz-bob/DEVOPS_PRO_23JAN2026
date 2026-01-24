from pydantic import BaseModel, Field
from typing import Optional

# Base properties shared by creating and reading
class ProductBase(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    description: Optional[str] = None
    price: float = Field(..., gt=0) # Price must be greater than 0
    category: Optional[str] = "General"

# Properties to receive on product creation
class ProductCreate(ProductBase):
    pass

# Properties to return to the client
class Product(ProductBase):
    id: int

    class Config:
        # This allows the API to return SQLAlchemy models as JSON automatically
        from_attributes = True

# Used for updating stock (Inventory Service interaction later)
class ProductUpdate(BaseModel):
    name: Optional[str] = None
    price: Optional[str] = None
    description: Optional[str] = None
