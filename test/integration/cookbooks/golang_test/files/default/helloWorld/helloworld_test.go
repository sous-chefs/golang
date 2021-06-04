package helloworld

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestHelloWorld(t *testing.T) {
	t.Run("func HelloWorld returns 'Hello, World!'", func(t *testing.T) {
		expected := "Hello, World!"

		output := HelloWorld()

		assert.Equal(t, output, expected)
	})
}
