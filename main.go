package main

import (
	"html/template"
	"net/http"
)

type Data struct {
	Manifest string
}

func main() {
	http.HandleFunc("/", installer)
	http.ListenAndServe(":8080", nil)
}

func installer(w http.ResponseWriter, r *http.Request) {
	qs := r.URL.Query()
	manifest := qs.Get("manifest")

	data := &Data{manifest}
	t, _ := template.ParseFiles("template.html")
	t.Execute(w, data)
}
