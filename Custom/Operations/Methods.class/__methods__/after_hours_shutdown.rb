#
# Description: This method will shut down a VM or instances if it is tagged
#
vms = $evm.vmdb(:vm).all
vms.each do |vm|
  if vm.tagged_with?("after_hours_operation","off") && vm.power_state == "on"
    $evm.log(:info, "JSW: #{vm.name} is tagged and will be powered off")
    vm.stop
  end
end
