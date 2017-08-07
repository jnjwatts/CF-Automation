#
# Tag the VM with power off after hours if it's a cloud one. Save some money.
#
prov = $evm.root['miq_provision']
vm = prov.vm
#$evm.instantiate('/Discovery/ObjectWalker/object_walker')
if vm.vendor == "amazon" || vm.vendor == "azure" || vm.vendor == "google"
  vm.tag_assign("after_hours_operation/off")
  $evm.log('info', "JSW: This is a public cloud instance, turn off after hours")
else
  $evm.log('info', "JSW: This is not a public cloud instance, leave it alone")
end
