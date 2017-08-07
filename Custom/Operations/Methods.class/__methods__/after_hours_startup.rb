#
# Description: This method will start up a VM or instances if it is tagged
#
vms = $evm.vmdb(:vm).all
vms.each do |vm|
  if vm.tagged_with?("after_hours_operation","on") && vm.power_state == "off"
    $evm.log(:info, "JSW: #{vm.name} is tagged and will be powered on")
    vm.start
  end
end
