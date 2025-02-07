import { createFileRoute } from "@tanstack/react-router";
import DynamicListInput from "../components/DynamicListInput";
import { useState } from "react";
import { Button } from "../components/ui/button";
import { Sparkles } from "lucide-react";

export const Route = createFileRoute("/")({
  component: RouteComponent,
});

function RouteComponent() {
  const [ingredients, setIngredients] = useState<string[]>([]);
  return (
    <>
      <div className="mt-40">
        <div className="space-y-2">
          <p className="text-center text-4xl font-bold">
            Recipe Suggester AI Agent
          </p>
          <p className="text-center text-sm">
            This is AI agent will suggests recipes based on the ingredients that
            you provide.
          </p>
        </div>
        <div className="mx-auto mt-8">
          <div className="relative">
            <div className="absolute bottom-0 right-0 p-4">
              <Button variant={"outline"}>
                <Sparkles />
              </Button>
            </div>
            <DynamicListInput items={ingredients} setItems={setIngredients} />
          </div>
        </div>
      </div>
    </>
  );
}
