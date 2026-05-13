# frozen_string_literal: true

user 'golang' do
  manage_home true
end

group 'golang' do
  members 'golang'
end

golang 'default' do
  owner 'golang'
  group 'golang'
  scm_packages %w(git)
end

package 'gcc'

remote_directory '/tmp/helloWorld'

golang_package 'golang.org/x/example/hello' do
  owner 'golang'
  group 'golang'
end
