#
# Description: <Method description here>
#
prov = $evm.root['miq_provision']
vm = prov.vm
#$evm.instantiate('/Discovery/ObjectWalker/object_walker')
#size_of_disks = $evm.root["dialog_size_of_disks"]
size_of_disks = prov.options[:size_of_disks]
$evm.log('info', "JSW: SIZES: #{size_of_disks}; VM NAME: #{vm.name}; STORAGE NAME: #{vm.storage.name}")
if !size_of_disks.nil? && !size_of_disks.empty?
  size_of_disks.split(/, ?/).each do |size|
    real_size = size.to_i * 1024
    $evm.log('info', "JSW: Adding #{real_size} GB drive to #{vm.name} at #{vm.storage.name}")
    sleep 15
    rc = vm.add_disk("[#{vm.storage.name}]", real_size)
    $evm.log('info', "JSW: RC: #{rc}")
  end
else
  $evm.log('info', "JSW: No extra disks requested")
end
