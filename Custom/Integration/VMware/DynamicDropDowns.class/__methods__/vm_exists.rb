#
# Description: <Method description here>
#
begin
  vm_name = $evm.root['dialog_vm_name']

  found_name = false
  vms = $evm.vmdb(:vm).all
  vms.each do |vm|
    if vm.name =~ /#{vm_name}/
      found_name = true
    end
  end

  text = found_name ? "#{vm_name} exists, please choose another" : "#{vm_name} is ok"

  $evm.object['required'] = true
  $evm.object['protected'] = false
  $evm.object['read_only'] = true
  $evm.object['value'] = text

#  rescue => err
#    $evm.log(:error, "#{err.class} #{err}")·
#    $evm.log(:error, "#{err.backtrace.join("\n")}")
#    exit MIQ_ABORT
end
