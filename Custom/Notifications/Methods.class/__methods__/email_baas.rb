#
# Description: <Method description here>
#
# Get vm from miq_provision object
prov = $evm.root['miq_provision']
vm = prov.vm
raise "VM not found" if vm.nil?
#$evm.instantiate('/Discovery/ObjectWalker/object_walker')
backup_nic = prov.options[:backup_nic]
if backup_nic == "t"
  $evm.log("info", "JSW: Backup required. Emailing requestor with backup details")
  #
# Model Notes:
# 1. to_email_address - used to specify an email address in the case where the
#    vm's owner does not have an  email address. To specify more than one email
#    address separate email address with commas. (I.e. admin@example.com,user@example.com)
# 2. from_email_address - used to specify an email address in the event the
#    requester replies to the email
# 3. signature - used to stamp the email with a custom signature
#


# Override the default appliance IP Address below
appliance ||= $evm.root['miq_server'].ipaddress

# Get VM Owner Name and Email
evm_owner_id = vm.attributes['evm_owner_id']
owner = nil
owner = $evm.vmdb('user', evm_owner_id) unless evm_owner_id.nil?
$evm.log("info", "VM Owner: #{owner.inspect}")
  personal_name = "#{owner.first_name} #{owner.last_name}"

to = nil
to = owner.email unless owner.nil?
to ||= $evm.object['to_email_address']
if to.nil?
  $evm.log("info", "Email not sent because no recipient specified.")
  exit MIQ_OK
end

# Assign original to_email_Address to orig_to for later use
orig_to = to

# Get from_email_address from model unless specified below
from = nil
from ||= $evm.object['from_email_address']

# Get signature from model unless specified below
signature = nil
signature ||= $evm.object['signature']

subject = "Backup Requirements for VM: #{vm['name']}"

body = "Hello #{personal_name},"

# Override email to VM owner and send email to a different email address
# if the template provisioned contains 'xx'
if prov.vm_template.name.downcase.include?('_xx_')
  $evm.log("info", "Setup of special email for DBMS VM")

  # Specify special email address below
  to      = 'evmadmin@example.com'

  body += "This email was sent by EVM to inform you of the provisioning of a new DBMS VM.<br>"
  body += "This new VM requires changes to DNS and DHCP to function correctly.<br>"
  body += "Please set the IP Address to static.<br>"
  body += "Once that has been completed, use this message to inform the "
  body += "requester that their new VM is ready.<br><br>"
  body += "-------------------------------- <br>"
  body += "Forward the message below to <br>"
  body += "#{orig_to}<br>"
  body += "-------------------------------- <br><br>"
  body += "<br>"
end

# VM Provisioned Email Body
  body += "<br><br>Your request to provision a virtual machine was approved and completed on #{Time.now.strftime('%A, %B %d, %Y at %I:%M%p')}. "
  body += "<br><br>You have requested a backup for your virtual machine so you will need to fill in a BaaS spreadsheet with the following information:"
  body += "<br><br>"
  body += "<br><br>Requestor Name: #{personal_name}"
  body += "<br><br>Galacxy ID: #{owner.userid}"
  body += "<br><br>Email Address: #{owner.email}"
  body += "<br><br>CRQ:  # - Collected by CloudForms"
  body += "<br><br>Project Code: - Collected by CloudForms from tag"
  body += "<br><br>Project Name: - Collected by CloudForms from tag description"
  body += "<br><br>VClient Name (hostname): #{vm.name}"
  if prov.options[:data_centre] == "x3"
  	body += "<br><br>Site (data center): IMC3"
  else
  	body += "<br><br>Site (data center): IMC4"
  end
  if prov.options[:environment] == "5"
    body += "<br><br>Environment (Production/ DR/ ETE): ETE"
  else
    body += "<br><br>Environment (Production/ DR/ ETE): Production"
  end
  body += "<br><br>Operation System: #{owner.userid}"
  body += "<br><br>Data Network IP: #{owner.userid}"
  body += "<br><br>Backup Network IP: #{owner.userid}"
  body += "<br><br>Backup VLAN: #{prov.options[:backup_net]}"
  body += "<br><br>Backup Type (VM, DB, FS): #{owner.userid}"
  body += "<br><br>Retention Period: #{owner.userid}"
  body += "<br><br>vCentre Name: #{prov.options[:src_ems_id][1]}"
  body += "<br><br>ESX host: #{prov.options[:dest_host][1]}"
  body += "<br><br>DB Type (MS Standalone/MySQL): #{owner.userid}"
  body += "<br><br>Instance Name: #{owner.userid}"
  body += "<br><br>DB Name: #{owner.userid}"
  body += "<br><br>"
  body += "<br><br>"
  body += "<br><br> Thank you,"
  body += "<br> #{signature}"

  $evm.log("info", "Sending email to <#{to}> from <#{from}> subject: <#{subject}>")
  $evm.execute('send_email', to, from, subject, body)
else
  $evm.log("info", "JSW: Backup not required")
end
