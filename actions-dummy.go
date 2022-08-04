package main

import (
	"fmt"
	"log"
	"os"
	"path"
	"strings"

	actionsdummy "github.com/gabizou/actionsdummy/cmd"

	"github.com/spf13/cobra/doc"
)

var (
	linkAssigner = func(file string) string {
		base := ""
		resolved := file
		if repo != "" {
			e := path.Ext(file)
			resolved = strings.ReplaceAll(file, e, "")
			base = fmt.Sprintf("/%s/wiki/", repo)
		}
		url := fmt.Sprintf("%s%s", base, resolved)

		fmt.Printf("%q\n", url)
		return url
	}
	filePrepender = func(filename string) string { return "" }
	repo          = os.Getenv("GH_REPO")
)

func main() {
	cmd := actionsdummy.NewCommand()
	if err := doc.GenMarkdownTreeCustom(cmd, "./docs", filePrepender, linkAssigner); err != nil {
		log.Fatal(err)
	}
}
