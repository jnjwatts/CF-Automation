#
# Description: <Method description here>
#
prov = $evm.root['miq_provision']
vm = prov.vm
#vm = $evm.root['vm']
#$evm.instantiate('/Discovery/ObjectWalker/object_walker')
#size_of_disks = $evm.root["dialog_size_of_disks"]
#vm_size = $evm.root['dialog_vm_size']
vm_size = prov.options[:vm_size]
$evm.log(:info, "JSW: Requested VM size: #{vm_size}")
case vm_size
  when "small"
    cpu = 1
  	ram = 2048
  when "medium"
    cpu = 2
  	ram = 2048
  when "large"
    cpu = 2
  	ram = 4096
  when "xlarge"
    cpu = 4
  	ram = 4096
  else
    cpu = 1
  	ram = 1024
end
$evm.log(:info, "JSW: Set amount of memory to #{ram} and set number of CPUs to #{cpu} for #{vm.name}")
vm.set_memory(ram)
vm.set_number_of_cpus(cpu)
#vm.start
