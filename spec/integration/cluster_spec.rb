require 'spec_helper'

# Ideally these should be defined in config - the spec helper
# is NOT the best place for these.
Infrataster::Server.define(:app1) do |server|
  server.address = '172.25.1.10'
  server.vagrant = true
end

Infrataster::Server.define(:app2) do |server|
  server.address = '172.25.1.11'
  server.vagrant = true
end

Infrataster::Server.define(:web) do |server|
  server.address = '172.25.1.100'
  server.vagrant = true
end

describe 'Talking to the application', integration: true do
  [:app1, :app2].each do |server|
    describe server(server) do
      describe http("http://#{server.to_s}:8484") do
        it "responds as #{server}" do
          expect(response.body).to eq("Hi there, I'm served from #{server}!")
        end
        it "responds as 'text/plain'" do
          expect(response.headers['content-type']).to include('text/plain')
        end
      end
    end
  end

  describe server(:web) do
    context 'Round robin requests' do
      # Makes ten requests to the load balancer and tests
      # that responses come from alternate servers
      (0..9).each do |counter|
        describe http("http://web") do
          it 'hits the servers alternately' do
            server_num = (counter % 2) + 1 # it's either server 1 or 2
            expect(response.body).to eq("Hi there, I'm served from app#{server_num}!")
          end
        end
      end
    end
  end
end
