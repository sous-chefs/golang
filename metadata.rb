name             'chef-golang'
maintainer       'Alexander Rozhnov'
maintainer_email 'gnox73@gmail.com'
license          'All rights reserved'
description      'Installs go programming language'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.1'

recipe "chef-golang", "Installs go programing language."
recipe "chef-golang::install", "Installs go programing language."
