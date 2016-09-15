package main

import (
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
	"github.com/twinj/uuid"
)

func HomeHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Routes: /guid/\n"))
}

func GuidHandler(w http.ResponseWriter, r *http.Request) {
	id := uuid.NewV4()
	containerId, _ := os.Hostname()
	json := "{\"guid\":" + uuid.Formatter(id, uuid.FormatCanonicalCurly) + ",\"container\":\"" + containerId + "\"}"
	w.Write([]byte(json + "\n"))
}

func main() {
	r := mux.NewRouter()
	r.HandleFunc("/", HomeHandler)
	r.HandleFunc("/guid", GuidHandler)
	http.Handle("/", r)

	srv := &http.Server{
		Handler: r,
		Addr:    "0.0.0.0:9000",
		// Good practice: enforce timeouts for servers you create!
		WriteTimeout: 15 * time.Second,
		ReadTimeout:  15 * time.Second,
	}
	log.Fatal(srv.ListenAndServe())
}
