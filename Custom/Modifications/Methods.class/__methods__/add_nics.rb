#
# Description: <Method description here>
#
prov = $evm.root['miq_provision']
#vm = prov.vm
#$evm.instantiate('/Discovery/ObjectWalker/object_walker')
backup_nic = prov.options[:backup_nic]
$evm.log("info", "JSW: backup_nic: #{backup_nic}")
vlan0 = 'VM Network'
prov.set_option(:prod_net, vlan0)
vlan1 = 'Not set'
device_type = "VirtualVmxnet3"
prov.set_network_adapter(0, {:network=>vlan0, :devicetype=>device_type, :is_dvs => false})
if backup_nic == "t"
  vlan1 = 'Management Network'
  prov.set_option(:backup_net, vlan1)
  prov.set_network_adapter(1, {:network=>vlan1, :devicetype=>device_type, :is_dvs => false})
end
$evm.log("info", "JSW: Networks set to Vlan0: #{vlan0} and Vlan1: #{vlan1} ")
