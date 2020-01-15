# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/exporters/squid_exporter_boynux/active') do
    it { should be_symlink }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

describe file('/opt/prometheus/exporters/squid_exporter_boynux/active/squid-exporter') do
    it { should be_file }
    it { should be_executable }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

# Verify the 'squid_exporter_boynux' service is running
control '01' do
  impact 1.0
  title 'Verify squid_exporter_boynux service'
  desc 'Ensures squid_exporter_boynux service is up and running'
  describe service('squid_exporter_boynux') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe processes(Regexp.new("^/opt/prometheus/exporters/squid_exporter_boynux/([0-9.]+|[0-9.]+__go-[0-9.]+)/squid-exporter")) do
    it { should exist }
    its('entries.length') { should eq 1 }
    its('users') { should include 'prometheus' }
end

describe port(9301) do
    it { should be_listening }
end

describe http('http://127.0.0.1:9301/metrics') do
    its('status') { should cmp 200 }
    its('body') { should match /squid_exporter_build_info/ }
end
