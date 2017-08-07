#
# Description: <Method description here>
#
begin
  data_centre = $evm.root['dialog_data_centre']
  environment = $evm.root['dialog_environment']
  app = $evm.root['dialog_job_template_name']

  app_code = case app
    when "Core Build" then "cb"
    when "Demo Job Template" then "dm"
    when "Deploy Ticket-Monster App" then "tm"
    when "JBoss Standalone" then "jb"
    when "LAMP Stack" then "ls"
    when "PostgreSQL" then "pg"
    when "WordPress" then "wp"
    when "Windows Web Server" then "is"
    else "xx"
  end
  
  i = 0
  while i < 1000 do
    i += 1
    $evm.log(:info, "JSW: syd#{data_centre}#{environment}#{app_code}"<<i.to_s.rjust(4, '0'))
    if $evm.vmdb('vm').find_by_name("syd#{data_centre}#{environment}#{app_code}"<<i.to_s.rjust(4, '0')) == nil
      vm_num = i.to_s.rjust(4, '0')
      break
    end
  end
  vm_name = "syd#{data_centre}#{environment}#{app_code}#{vm_num}"

  $evm.object['required'] = true
  $evm.object['protected'] = false
  $evm.object['read_only'] = true
  $evm.object['value'] = vm_name

#  rescue => err
#    $evm.log(:error, "#{err.class} #{err}")·
#    $evm.log(:error, "#{err.backtrace.join("\n")}")
#    exit MIQ_ABORT
end
