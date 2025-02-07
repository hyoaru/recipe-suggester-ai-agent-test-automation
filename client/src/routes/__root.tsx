import * as React from "react";
import { Outlet, createRootRoute } from "@tanstack/react-router";

export const Route = createRootRoute({
  component: RootComponent,
});

function RootComponent() {
  return (
    <React.Fragment>
      <main className="mx-auto w-4/12">
        <Outlet />
      </main>
    </React.Fragment>
  );
}
