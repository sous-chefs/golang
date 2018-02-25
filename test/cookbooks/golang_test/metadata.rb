name             'golang_test'
maintainer       'Alexander Rozhnov'
maintainer_email 'gnox73@gmail.com'
license          'Apache-2.0'
description      'Installs/Configures golang_test'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

recipe 'golang_test', 'default'

depends 'chef-golang'
