package actionsdummy

import (
	"fmt"
	"github.com/spf13/cobra"
)

func NewCommand() *cobra.Command {
	parent := &cobra.Command{
		Use:     "actions-dummy",
		Aliases: []string{"ad"},
		Short:   "A dummy command",
		Long:    "Some long lorem ipsum dolor",
		Example: "actions-dummy",
		Version: "",
		RunE: func(cmd *cobra.Command, args []string) error {
			return nil
		},
	}
	child := &cobra.Command{
		Use:     "echo",
		Aliases: []string{"e"},
		Short:   "says something",
		Long:    "Says something about the user",
		Example: "actions-dummy e hello world",
		Run: func(cmd *cobra.Command, args []string) {
			fmt.Printf("%#v", args)
		},
	}
	parent.AddCommand(child)
	return parent
}
