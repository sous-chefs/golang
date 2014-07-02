require_relative './spec_helper'

describe 'golang::default' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      stub_command("/usr/local/go/bin/go version | grep \"go1.2.2 \"").and_return('')
      node.set['golang']['filename'] = 'testfile.tar.gz'
    end.converge(described_recipe)
  end

  it 'should include golang installer recipe' do
    expect(chef_run).to include_recipe 'golang::default'
  end

  it 'should not run bash until directory created' do
    expect(chef_run).to_not run_bash 'install-golang'
  end

  it 'bash should run if remote file not found' do
    resource = chef_run.remote_file(File.join(Chef::Config[:file_cache_path], 'testfile.tar.gz'))
    puts resource
    expect(resource).to notify "bash[install-golang]"
  end

  it 'should create path directory' do
    expect(chef_run).to create_directory('/opt/go').with(
      :recursive => true,
      :owner => 'root',
      :group =>'root',
      :mode => 0755
    )
  end

  it 'should create bin directory' do
    expect(chef_run).to create_directory('/opt/go/bin').with(
      :recursive => true,
      :owner => 'root',
      :group =>'root',
      :mode => 0755
    )
  end

  it 'should create template' do
    expect(chef_run).to create_template('/etc/profile.d/golang.sh').with(
      :source => 'golang.sh.erb',
      :owner => 'root',
      :group =>'root',
      :mode => 0755
    )
  end

  it 'should install git' do
    expect(chef_run).to install_package('git')
  end

  it 'should install mercurial' do
    expect(chef_run).to install_package('mercurial')
  end

  it 'should install bzr' do
    expect(chef_run).to install_package('bzr')
  end

end

describe 'golang::packages' do

  let(:chef_run) do
    ChefSpec::Runner.new do |node|
      stub_command("/usr/local/go/bin/go version | grep \"go1.2.2 \"").and_return('1.2.2')
    end.converge(described_recipe)
  end

  it 'should include golang installer recipe' do
    expect(chef_run).to include_recipe 'golang::default'
  end

  it 'should include golang packages recipe' do
    expect(chef_run).to include_recipe 'golang::packages'
  end

  it 'bash should not run if remote file found' do
    resource = chef_run.remote_file(File.join(Chef::Config[:file_cache_path], 'testfile.tar.gz'))
    puts resource
    expect(resource).not_to notify "bash[install-golang]"
  end

end
