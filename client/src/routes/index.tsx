import { createFileRoute } from "@tanstack/react-router";
import DynamicListInput from "../components/DynamicListInput";
import { useCallback, useState } from "react";
import { Button } from "../components/ui/button";
import { LoaderCircle, Sparkles } from "lucide-react";
import { Recipe } from "../types/core-types";
import useRecipes from "../hooks/core/useRecipes";
import { toast } from "sonner";
import { Badge } from "@/components/ui/badge";
import { ThemeModeToggle } from "@/components/ThemeModeToggle";

export const Route = createFileRoute("/")({
  component: RouteComponent,
});

function RouteComponent() {
  const [ingredients, setIngredients] = useState<string[]>([]);
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const { getSuggestionsMutation } = useRecipes();

  const onSubmit = useCallback(async () => {
    if (!ingredients.length) {
      toast.error("Please add some ingredients to get suggestions");
      return;
    }

    setIngredients([]);
    await getSuggestionsMutation.mutateAsync({ ingredients }).then((res) => {
      setRecipes(res.recipes);
    });
  }, [getSuggestionsMutation, ingredients]);

  return (
    <>
      <div className="mt-20 md:mt-32">
        <div id="header" className="sticky top-32 pb-10 backdrop-blur-sm">
          <div className="absolute top-[-60px] z-10 flex w-full justify-end md:end-[-10px] md:top-[-50px]">
            <ThemeModeToggle />
          </div>
          <div className="space-y-2">
            <p className="text-center text-2xl font-bold md:text-4xl">
              Recipe Suggester AI Agent
            </p>
            <p className="text-center text-sm">
              This is AI agent will suggests recipes based on the ingredients
              that you provide.
            </p>
          </div>
          <div className="mx-auto mt-8">
            <div className="relative">
              <div className="absolute bottom-0 right-0 p-4">
                <Button
                  variant={"outline"}
                  onClick={onSubmit}
                  disabled={getSuggestionsMutation.isPending}
                >
                  {getSuggestionsMutation.isPending ? (
                    <LoaderCircle className="animate-spin" />
                  ) : (
                    <Sparkles />
                  )}
                </Button>
              </div>
              <DynamicListInput items={ingredients} setItems={setIngredients} />
            </div>
          </div>
        </div>
        <div className="space-y-4">
          {recipes.map((recipe) => (
            <div key={recipe.name} className="rounded-xl bg-secondary p-6">
              <p className="text-lg font-bold">{recipe.name}</p>
              <p className="mb-4 text-sm">{recipe.description}</p>
              <div className="flex flex-wrap items-center justify-start gap-1">
                {recipe.ingredients.map((ingredient, index) => (
                  <Badge
                    key={`${ingredient}-${index}`}
                    className="font-normal"
                    variant={"outline"}
                  >
                    {ingredient}
                  </Badge>
                ))}
              </div>

              <div className="mt-4">
                <p className="text-sm font-semibold">Steps:</p>
                <div className="">
                  {recipe.steps.map((step, index) => (
                    <p key={`${step}-${index}`} className="text-sm">
                      {index + 1}. {step}
                    </p>
                  ))}
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </>
  );
}
