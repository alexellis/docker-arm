package main

import (
	"encoding/json"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/gorilla/mux"
	"github.com/twinj/uuid"
)

type GuidReponse struct {
	Guid        string `json:"guid"`
	ContainerId string `json:"container"`
}

func HomeHandler(w http.ResponseWriter, r *http.Request) {
	w.Write([]byte("Routes: /guid/\n"))
}

func GuidHandler(w http.ResponseWriter, r *http.Request) {
	id := uuid.NewV4()
	containerId, _ := os.Hostname()
	guidReponse := GuidReponse{}
	guidReponse.Guid = uuid.Formatter(id, uuid.FormatCanonicalCurly)
	guidReponse.ContainerId = containerId

	jsonValue, _ := json.Marshal(guidReponse)
	w.Write([]byte(jsonValue))
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
