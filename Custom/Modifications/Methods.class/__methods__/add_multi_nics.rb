#
# Description: <Method description here>
#
prov = $evm.root['miq_provision']
num_of_nics = prov.options[:num_of_nics]
vmname = prov.options[:vm_name]
$evm.log('info', "JSW: NUM NICS: #{num_of_nics}; VM NAME: #{vmname}")
nic = 0
if !num_of_nics.nil?
  num_of_nics.times do
    $evm.log('info', "JSW: Adding NIC #{nic} to #{vmname}")
    rc = prov.set_network_adapter(nic,
    {
      :network => 'VM Network',
      :devicetype => 'VirtualVmxnet3',
      :is_dvs => false
    })
    $evm.log('info', "JSW: Set Network Adapter RC #{rc}")
    rc = prov.set_nic_settings(nic,
    {
#      :ip_addr => '10.2.1.23',
#      :subnet_mask => '255.255.255.0',
#      :addr_mode => ['static', 'Static']
      :addr_mode => ['dhcp', 'DHCP']
    })
    $evm.log('info', "JSW: Set NIC Settings RC #{rc}")
    nic += 1
  end
else
  $evm.log('info', "JSW: No extra NICs requested")
end
