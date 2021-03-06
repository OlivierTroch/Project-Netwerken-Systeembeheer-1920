# encoding: utf-8
# author: Mesaguy

describe file('/opt/prometheus/scripts/md_info_detail.sh') do
    it { should be_file }
    it { should be_executable }
    its('content') { should match /# Output RAID detail metrics info from the output of / }
    its('size') { should > 4000 }
    its('mode') { should cmp '0555' }
    its('owner') { should eq 'root' }
    its('group') { should eq 'prometheus' }
end
