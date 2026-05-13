package helloworld

import (
	"testing"
)

func TestHelloWorld(t *testing.T) {
	t.Run("func HelloWorld returns 'Hello, World!'", func(t *testing.T) {
		expected := "Hello, World!"

		output := HelloWorld()

		if output != expected {
			t.Fatalf("expected %q, got %q", expected, output)
		}
	})
}
