# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/exporters/process_exporter_ncabatoff/active') do
    it { should be_symlink }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

describe file('/opt/prometheus/exporters/process_exporter_ncabatoff/active/process-exporter') do
    it { should be_file }
    it { should be_executable }
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end

# Verify the 'process_exporter_ncabatoff__TEST' service is running
control '01' do
  impact 1.0
  title 'Verify process_exporter_ncabatoff service'
  desc 'Ensures process_exporter_ncabatoff service is up and running'
  describe service('process_exporter_ncabatoff__TEST') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

# Verify the 'process_exporter_ncabatoff__TEST2' service is running
control '02' do
  impact 1.0
  title 'Verify process_exporter_ncabatoff service'
  desc 'Ensures process_exporter_ncabatoff service is up and running'
  describe service('process_exporter_ncabatoff__TEST2') do
    it { should be_enabled }
    it { should be_installed }
    it { should be_running }
  end
end

describe processes(Regexp.new("^/opt/prometheus/exporters/process_exporter_ncabatoff/([0-9.]+|[0-9.]+__go-[0-9.]+)/process-exporter")) do
    it { should exist }
    its('entries.length') { should eq 2 }
    its('users') { should include 'prometheus' }
    its('users') { should include 'nobody' }
end

describe port(9256) do
    it { should be_listening }
end

describe port(9257) do
    it { should be_listening }
end

describe http('http://127.0.0.1:9256/metrics') do
    its('status') { should cmp 200 }
    its('body') { should match /namedprocess_namegroup_major_page_faults_total/ }
end

describe http('http://127.0.0.1:9257/metrics') do
    its('status') { should cmp 200 }
    its('body') { should match /namedprocess_namegroup_major_page_faults_total/ }
end
