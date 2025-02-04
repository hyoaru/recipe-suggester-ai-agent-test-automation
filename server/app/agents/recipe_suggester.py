from typing import List
from pydantic import BaseModel
from pydantic_ai import Agent
from app.models.base_models.recipe.models import Recipe
from dotenv import load_dotenv

load_dotenv()


class RecipeSuggesterAgentDependencies(BaseModel):
    ingredients: List[str]


recipe_suggester_agent = Agent(
    "openai:gpt-4o-mini",
    deps_type=RecipeSuggesterAgentDependencies,
    result_type=List[Recipe],
    system_prompt=(
        "You are a helpful Recipe Suggester AI. Given a list of ingredients provided by the user, you will suggest five recipes that can be made using those ingredients."
    ),
)


async def agent_suggest_recipes(ingredients: List[str]) -> List[Recipe]:
    deps = RecipeSuggesterAgentDependencies(ingredients=ingredients)
    result = await recipe_suggester_agent.run("Suggest a recipe", deps=deps)
    return result.data
