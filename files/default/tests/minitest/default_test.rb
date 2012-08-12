require 'minitest/spec'

describe_recipe 'mongodb::default' do

  # It's often convenient to load these includes in a separate
  # helper along with
  # your own helper methods, but here we just include them directly:
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  it 'running MongoDB' do
    service('mongodb').must_be_running
  end

  # Can I do this in a smarter way??
  it 'bound to the selected IP and port' do
    bind_ip = node[:mongodb][:bind_ip] || '0.0.0.0'
    port    = node[:mongodb][:port]
    assert system("netstat -ptan | grep #{bind_ip}:#{port}"),
           "MongoDB is not running bound to #{bind_ip}:#{port}"
  end

end
