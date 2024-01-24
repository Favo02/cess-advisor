import React from "react"
import ReactDOM from "react-dom/client"
import "./index.css"
import { createBrowserRouter, RouterProvider, Outlet, Navigate } from "react-router-dom"
import ProtectedRoute from "./components/ProtectedRoute"
import LoginPage from "./components/login/LoginPage"
import { Toaster } from "@/components/ui/toaster"
import ProfilePage from "./components/profile/ProfilePage"

const router = createBrowserRouter([
  { path: "/",              element: <Navigate to="/home" /> },
  { path: "/home",          element: <p>home</p> },
  { path: "/login",         element: <LoginPage /> },
  {
    path: "*",
    element: <ProtectedRoute><Outlet /></ProtectedRoute>,
    children: [
      { path: "profile",    element: <ProfilePage /> },
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
