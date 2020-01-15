# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/exporters/bigip_exporter_expressenab/active') do
    it { should be_symlink }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

describe file('/opt/prometheus/exporters/bigip_exporter_expressenab/active/bigip_exporter') do
    it { should be_file }
    it { should be_executable }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

# Verify the 'bigip_exporter_expressenab' service is running
control '01' do
  impact 1.0
  title 'Verify bigip_exporter_expressenab service'
  desc 'Ensures bigip_exporter_expressenab service is up and running'
  describe service('bigip_exporter_expressenab') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe processes(Regexp.new("^/opt/prometheus/exporters/bigip_exporter_expressenab/([0-9.]+|[0-9.]+__go-[0-9.]+)/bigip_exporter")) do
    it { should exist }
    its('entries.length') { should eq 1 }
    its('users') { should include 'prometheus' }
end

describe port(9142) do
    it { should be_listening }
end

# Cannot test body as exporter requires access to an F5
