#
# Description: <Method description here>
#
the_user = $evm.root['user']
service_template_provision_task = $evm.root['service_template_provision_task']
the_service = service_template_provision_task.destination
the_date = Time.now.strftime("%Y%m%d-%H:%M")
the_app = $evm.root['dialog_job_template_name']
the_service.name="#{the_app} (#{the_user.name}) #{the_date}"
$evm.log(:info, "JSW: USER: #{the_user.name}, SERVICE: #{the_service.name}")
