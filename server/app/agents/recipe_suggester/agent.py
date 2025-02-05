from typing import List

from pydantic import BaseModel
from pydantic_ai import Agent
from app.agents.recipe_suggester.interfaces import RecipeSuggesterAgentABC
from app.agents.recipe_suggester.models import Recipe


class RecipeSuggesterAgentDependencies(BaseModel):
    ingredients: List[str]


class RecipeSuggesterAgent(RecipeSuggesterAgentABC):
    def __init__(self):
        self.agent = Agent(
            "openai:gpt-4o-mini",
            deps_type=RecipeSuggesterAgentDependencies,
            result_type=List[Recipe],
            system_prompt=(
                "You are a helpful Recipe Suggester AI. Given a list of ingredients provided by the user, you will suggest two recipes that can be made using those ingredients."
            ),
        )

    async def suggest(self, ingredients: List[str]) -> List[Recipe]:
        result = await self.agent.run(
            "Suggest a recipe",
            deps=RecipeSuggesterAgentDependencies(ingredients=ingredients),
        )

        return result.data
