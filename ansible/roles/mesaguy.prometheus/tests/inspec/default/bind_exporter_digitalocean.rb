# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/exporters/bind_exporter_digitalocean/active') do
    it { should be_symlink }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

describe file('/opt/prometheus/exporters/bind_exporter_digitalocean/active/bind_exporter') do
    it { should be_file }
    it { should be_executable }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

# Verify the 'bind_exporter_digitalocean' service is running
control '01' do
  impact 1.0
  title 'Verify bind_exporter_digitalocean service'
  desc 'Ensures bind_exporter_digitalocean service is up and running'
  describe service('bind_exporter_digitalocean') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe processes(Regexp.new("^/opt/prometheus/exporters/bind_exporter_digitalocean/(v[0-9.]+|[0-9.a-z\-]+__go-[0-9.]+)/bind_exporter")) do
    it { should exist }
    its('entries.length') { should eq 1 }
    its('users') { should include 'prometheus' }
end

describe port(8053) do
    it { should be_listening }
end

describe http('http://127.0.0.1:8053/metrics') do
    its('status') { should cmp 200 }
    its('body') { should match /bind_boot_time_seconds/ }
end
