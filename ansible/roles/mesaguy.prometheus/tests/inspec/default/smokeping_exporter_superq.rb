# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/exporters/smokeping_exporter_superq/active') do
    it { should be_symlink }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

describe file('/opt/prometheus/exporters/smokeping_exporter_superq/active/smokeping_prober') do
    it { should be_file }
    it { should be_executable }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

# Verify the 'smokeping_exporter_superq' service is running
control '01' do
  impact 1.0
  title 'Verify smokeping_exporter_superq service'
  desc 'Ensures smokeping_exporter_superq service is up and running'
  describe service('smokeping_exporter_superq') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe processes(Regexp.new("^/opt/prometheus/exporters/smokeping_exporter_superq/([0-9.]+|[0-9.]+__go-[0-9.]+)/smokeping_prober")) do
    it { should exist }
    its('entries.length') { should eq 1 }
    its('users') { should include 'prometheus' }
end

describe port(9374) do
    it { should be_listening }
end

describe http('http://127.0.0.1:9374/metrics') do
    its('status') { should cmp 200 }
    its('body') { should match /smokeping_requests_total{host="localhost",ip="127.0.0.1"}/ }
end
