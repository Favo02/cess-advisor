import React from "react"
import ReactDOM from "react-dom/client"
import "./index.css"
import { createBrowserRouter, RouterProvider, Outlet, Navigate } from "react-router-dom"
import ProtectedRoute from "./components/ProtectedRoute"
import { Toaster } from "@/components/ui/toaster"

const router = createBrowserRouter([
  { path: "/",              element: <Navigate to="/home" /> },
  { path: "/home",          element: <p>home</p> },
  { path: "/login",         element: <p>login</p> },
  {
    path: "*",
    element: <ProtectedRoute><Outlet /></ProtectedRoute>,
    children: [
      { path: "profile",    element: <p>profile</p> },
      { path: "*",          element: <p>404 not found</p> }
    ]
  }
])

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <RouterProvider router={router} />
    <Toaster />
  </React.StrictMode>
)
