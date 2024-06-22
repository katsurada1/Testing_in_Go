package main

import (
	"net/http"

	"github.com/go-chi/chi"
	"github.com/go-chi/chi/v5/middleware"
)

func (app *application) routes() http.Handler {
	mux := chi.NewRouter()

	// register the middleware
	mux.Use(middleware.Recoverer)

	mux.Post("/auth", app.authenticate)
	mux.Post("/refresh-token", app.refresh)

	mux.Route("/users", func(mux chi.Router) {
		mux.Get("/", app.allUsers)
		mux.Get("/{userID}", app.getUser)
		mux.Delete("/{userID}", app.deleteUser)
		mux.Put("/", app.insertUser)
		mux.Patch("/", app.updateUser)
	})
	return mux
}
