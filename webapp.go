package main

import (
	"fmt"
	"net/http"
)

const html = `
<html>
<head>
</head>
<body>
<h3>Congrats, GO app wass successfully configured!</h3>
The environment was configured using this installation script: <a target="_blank" href="https://github.com/bykovme/webgolangdo">github.com/bykovme/webgolangdo</a>
Find more interesting stuff here: <a target="_blank" href="https://bykov.tech/">bykov.tech</a>
</body>
</html>
`

func handler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, html)
}

func main() {
	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}
