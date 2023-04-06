require 'opcua_client'


puts "Start OPC"
# OPCUAClient.start("opc.tcp://127.0.0.1:49320") do |client|
#   # write to ns=2;s=1
#   client.write_int16(2, "Channel1.Device1.qwe", 888)
#   puts client.read_int16(2, "Channel1.Device1.qwe")
# end

cli = OPCUAClient::Client.new

# cli.after_session_created do |cli|
#   subscription_id = cli.create_subscription
#   ns_index = 2
#   node_name = "Channel1.Device1.IntegerValue"
#   cli.add_monitored_item(subscription_id, ns_index, node_name)
# end

# cli.after_data_changed do |subscription_id, monitor_id, server_time, source_time, new_value|
#   puts("data changed: " + [subscription_id, monitor_id, server_time, source_time, new_value].inspect)
# end

cli.connect("opc.tcp://127.0.0.1:49320")

loop do
  cli.connect("opc.tcp://127.0.0.1:49320")
  puts cli.write_boolean(2, "Channel1.Device1.BooleanValue", 1)
  puts cli.read_int32(2, "Channel1.Device1.IntegerValue")

  @values = cli.read_int32(2, "Channel1.Device1.IntegerValue")

   # no-op if connected
  cli.run_mon_cycle
  sleep(0.2)
end