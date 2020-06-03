package hello_world

import (
  . "github.com/go-check/check"
  "testing"
)

func Test(t *testing.T) { TestingT(t) }
type HelloWorldSuite struct{
}
var _ = Suite(&HelloWorldSuite{})

func (s *HelloWorldSuite) TestHelloWorld(c *C) {
    c.Assert(HelloWorld(), Equals, "Hello world!")
}
