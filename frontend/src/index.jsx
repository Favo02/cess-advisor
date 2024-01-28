import React from "react"
import ReactDOM from "react-dom/client"
import "./index.css"
import { createBrowserRouter, RouterProvider, Outlet, Navigate } from "react-router-dom"

import Wrapper from "./components/Wrapper"
import Authorization from "./components/Authorization"

import LoginPage from "./components/login/LoginPage"
import ProfilePage from "./components/profile/ProfilePage"
import HomePage from "./components/home/HomePage"

const router = createBrowserRouter([
  {
    element: <Wrapper><Outlet /></Wrapper>,
    errorElement: <Navigate to="/home" replace />,
    children: [
      { path: "/home",          element: <HomePage /> },
      { path: "/login",         element: <LoginPage /> },
      {
        element: <Authorization><Outlet /></Authorization>,
        children: [
          { path: "/profile",             element: <ProfilePage /> },
          { path: "/toilets/new",         element: <>new toilet</> },
          { path: "/toilets/:id/review",  element: <>review</> }
        ]
      }
    ]
  }
])

ReactDOM.createRoot(document.getElementById("root")).render(
  <React.StrictMode>
    <RouterProvider router={router} />
  </React.StrictMode>
)
