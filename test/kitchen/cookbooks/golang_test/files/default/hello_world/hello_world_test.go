package hello_world

import (
  . "launchpad.net/gocheck"
  "testing"
)

func Test(t *testing.T) { TestingT(t) }
type HelloWorldSuite struct{
}
var _ = Suite(&HelloWorldSuite{})

func (s *HelloWorldSuite) TestHelloWorld(c *C) {
    c.Assert(HelloWorld(), Equals, "Hello world!")
}

