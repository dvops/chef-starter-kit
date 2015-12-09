require 'spec_helper'

describe 'app::default' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'installs golang' do
    expect(chef_run).to install_package('golang')
  end

  it 'installs git' do
    expect(chef_run).to install_package('git')
  end

  it 'clones the app gist' do
    expect(chef_run).to export_git('/var/www/app')
  end

  it 'compiles the app' do
    expect(chef_run).to run_execute('Build and run server')
  end
end
