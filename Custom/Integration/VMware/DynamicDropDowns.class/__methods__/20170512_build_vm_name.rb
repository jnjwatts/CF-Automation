#
# Description: <Method description here>
#
begin
  data_centre = $evm.root['dialog_data_centre']
  environment = $evm.root['dialog_environment']
  app = $evm.root['dialog_job_template_name']
  
  object_type = $evm.root['vmdb_object_type']
  $evm.log(:info, "JSW: OBJECT_TYPE #{object_type}")
  if object_type == "service_template"
    serv_temp = $evm.root['service_template']
    serv_temp.tags.each do |dtag|
      if dtag.split('/')[0] == "os_base"
        @os_name = dtag.split('/')[1]
        $evm.log(:info, "JSW: OS_NAME #{@os_name}")
      end
    end
  else
    if object_type == "vm"
      vm = $evm.root['vm']
      @os_name = vm.os_image_name
      $evm.log(:info, "JSW: OS_NAME-V #{@os_name}")
    end
  end
  if @os_name == "linux_redhat"
    oname = "l"
  else
    oname = "w"
  end

  app_code = case app
    when "Core Build" then "cb"
    when "Demo Job Template" then "dm"
    when "Deploy Ticket-Monster App" then "tm"
    when "JBoss Standalone" then "jb"
    when "LAMP Stack" then "ls"
    when "PostgreSQL" then "pg"
    when "WordPress" then "wp"
    when "MongoDB" then "md"
    when "Windows Web Server" then "is"
    else "xx"
  end
  
  i = 0
  while i < 1000 do
    i += 1
    $evm.log(:info, "JSW: syd#{data_centre}#{oname}#{app_code}#{environment}"<<i.to_s.rjust(3, '0'))
    if $evm.vmdb('vm').find_by_name("syd#{data_centre}#{oname}#{app_code}#{environment}"<<i.to_s.rjust(3, '0')) == nil
      vm_num = i.to_s.rjust(3, '0')
      break
    end
  end
#  vm_name = "syd#{data_centre}#{oname}#{app_code}#{environment}#{vm_num}"
  vm_name = "syd#{data_centre}#{oname}#{app_code}#{environment}"

  $evm.object['required'] = true
  $evm.object['protected'] = false
  $evm.object['read_only'] = true
  $evm.object['value'] = vm_name

#  rescue => err
#    $evm.log(:error, "#{err.class} #{err}")·
#    $evm.log(:error, "#{err.backtrace.join("\n")}")
#    exit MIQ_ABORT
end
