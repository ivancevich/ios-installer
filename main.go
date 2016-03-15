package main

import (
	"html/template"
	"net/http"
	"os"
)

type Data struct {
	Manifest string
}

var templatePath = os.Getenv("TEMPLATE_PATH")

func main() {
	http.HandleFunc("/", installer)
	http.ListenAndServe(":8080", nil)
}

func installer(w http.ResponseWriter, r *http.Request) {
	qs := r.URL.Query()
	manifest := qs.Get("manifest")

	data := &Data{manifest}
	t, _ := template.ParseFiles(templatePath)
	t.Execute(w, data)
}
