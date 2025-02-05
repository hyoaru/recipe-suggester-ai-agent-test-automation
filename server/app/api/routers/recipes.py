import time
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
    elapsed_time: float
    recipes: List[Recipe]


@router.post("/recipes/suggest", response_model=RecipeSuggestResponse)
async def recipe_suggest(body: RecipeSuggestBody):
    ingredients = body.ingredients
    agent: RecipeSuggesterAgentABC = RecipeSuggesterAgent()

    start_time = time.perf_counter()

    result = await agent.suggest(ingredients)

    end_time = time.perf_counter()
    elapsed_time = end_time - start_time

    return RecipeSuggestResponse(
        elapsed_time=elapsed_time,
        recipes=result.recipes,
    )
