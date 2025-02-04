from fastapi import FastAPI
from app.api.routers.recipes import router as router_recipes
from dotenv import load_dotenv


def create_app():
    load_dotenv()
    app = FastAPI(docs_url="/")
    app.include_router(
        router_recipes,
        prefix="/api",
    )

    return app
