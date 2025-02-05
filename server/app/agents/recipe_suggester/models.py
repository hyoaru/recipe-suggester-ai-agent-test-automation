from typing import List

from pydantic import BaseModel


class Recipe(BaseModel):
    name: str
    description: str
    ingredients: List[str]
    steps: List[str]
