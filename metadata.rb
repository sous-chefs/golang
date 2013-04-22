name             'golang'
maintainer       'Alexander Rozhnov'
maintainer_email 'gnox73@gmail.com'
license          'All rights reserved'
description      'Installs go programming language'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'

recipe "golang", "Installs go programing language."
recipe "golang::install", "Installs go programing language."

supports 'debian', ">= 6.0"
supports 'ubuntu', ">= 12.04"
