from typing import List
from fastapi import APIRouter
from pydantic import BaseModel

from app.agents.recipe_suggester import agent_suggest_recipes
from app.models.base_models.recipe.models import Recipe

router = APIRouter()


class RecipeSuggestBody(BaseModel):
    ingredients: List[str]


class RecipeSuggestResponse(BaseModel):
    recipes: List[Recipe]


@router.post("/recipes/suggest", response_model=RecipeSuggestResponse)
async def recipe_suggest(body: RecipeSuggestBody):
    ingredients = body.ingredients
    agent_result = await agent_suggest_recipes(ingredients)
    return {"recipes": agent_result}
