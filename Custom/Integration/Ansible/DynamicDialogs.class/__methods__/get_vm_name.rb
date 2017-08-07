#
# Description: <Method description here>
#
vm_name = $evm.root['dialog_vm_name']
unless vm_name.nil? || vm_name.length.zero?
  limit = $evm.object
  limit["data_type"] = "string"
  limit["required"] = "true"
  limit["value"] = vm_name
end
