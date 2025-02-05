from typing import List
from fastapi import APIRouter
from pydantic import BaseModel

from app.agents.recipe_suggester.agent import RecipeSuggesterAgent
from app.agents.recipe_suggester.interfaces import RecipeSuggesterAgentABC
from app.agents.recipe_suggester.models import Recipe

router = APIRouter()


class RecipeSuggestBody(BaseModel):
    ingredients: List[str]


class RecipeSuggestResponse(BaseModel):
    recipes: List[Recipe]


@router.post("/recipes/suggest", response_model=RecipeSuggestResponse)
async def recipe_suggest(body: RecipeSuggestBody):
    ingredients = body.ingredients
    agent: RecipeSuggesterAgentABC = RecipeSuggesterAgent()

    recipes = await agent.suggest(ingredients)
    return {"recipes": recipes}
