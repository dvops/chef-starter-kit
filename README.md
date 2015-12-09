# chef-starter-kit

A code test turned into a starter kit. Contains cookbooks, recipes and tests to kick off TDD with Chef for anything.

## Requirements

   * Virtualbox / <http://www.virtualbox.org>
   * Vagrant  / <http://vagrantup.com>
   * Ruby 2.1 or 2.2
   * Bundler gem installed [`gem install bundler`]


### The build

Vagrant is used to start and provision three nodes using chef-zero. These nodes are given static private IPs from the 172.0.0.0/16 range. If these need to be changed, simply edit the `Vagrantfile` to update them, and also change the `spec/integration/cluster_spec.rb` file. Unfortunately Vagrant starts a separate instance of chef-zero for each node, so shared information through Ohai, such as IP address, cannot be searched for.

### Running the stack

    vagrant up

Open <http://localhost:2112> in your browser. NOTE: Strange things are happening with Google Chrome, and the page seems to be cached in the browser. Firefox and Safari do not exhibit this behaviour, and the pages are displayed in the expected round-robin manner.

### Testing

The Rspec tests cover the two cookbooks for the servers, and an integration test that checks the server response, as
well as the round-robin response correctness.

Install the dependencies.

	bundle install

Run the unit tests.

    rspec

Run the integration tests straight after firing up a new stack.

	vagrant up
    rspec --tag integration

#### Kitchen Tests

There is a basic `.kitchen.yml` file which describes the platform on Ubuntu and defines two suites for the web and app.

	kitchen test

#### Updating the sample application

The sample application is being served from a Github gist, found here: <https://gist.github.com/f67f50ee73bffa14d869.git> Changes to this script can be propagated by simply reprovisioning the app servers (or the entire stack).

    vagrant provision app1
    vagrant provision app2

