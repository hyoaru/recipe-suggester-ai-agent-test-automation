from fastapi import FastAPI
from app.api.routers.recipes import router as router_recipes
from dotenv import load_dotenv
from fastapi.middleware.cors import CORSMiddleware


def create_app():
    load_dotenv()

    app = FastAPI(docs_url="/")

    app.add_middleware(
        CORSMiddleware,
        allow_origins=[
            "http://localhost:8002",
            "https://hyoaru.github.io/recipe-suggester-ai",
        ],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    app.include_router(
        router_recipes,
        prefix="/api",
    )

    return app
