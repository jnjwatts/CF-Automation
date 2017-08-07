#
# Description: This method forces the VM Reconfiguration request into an approval
#
$evm.log("info", "JSW: Reconfiguration requires approval")
$evm.root["miq_request"].pending
