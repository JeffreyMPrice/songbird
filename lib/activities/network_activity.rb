# frozen_string_literal: false

require 'socket'

# top level comment
class NetworkActivity < Activity
  attr_reader :address, :port, :payload, :local_ip, :local_port, :remote_ip, :remote_port, :response

  def initialize(args)
    raise ArgumentError, 'Network activity must have an address' unless args['address']
    raise ArgumentError, 'NetworkActivity must have a port' unless args['port']

    @address = args['address']
    @port = args['port']

    super()
  end

  def self.answers?(type)
    type.eql? 'network'
  end

  def gather_telemetry(socket)
    @local_ip = socket.local_address.ip_address
    @local_port = socket.local_address.ip_port
    @remote_ip = socket.remote_address.ip_address
    @remote_port = socket.remote_address.ip_port
  end

  def execute
    mark_time
    s = TCPSocket.open(address, port)
    @payload = "GET / HTTP/1.1\r\nHost:#{address}\r\n\r\n"
    s.write payload
    gather_telemetry(s)
    s.close_write

    @response = s.read
    s.close
  end

  # rubocop:disable Metrics/MethodLength
  def log
    log = { action: 'Network Activity',
            timestamp: timestamp,
            destination_address: remote_ip,
            destination_port: remote_port,
            source_address: local_ip,
            source_port: local_port,
            data_sent: payload.bytesize,
            data_recieved: response.bytesize,
            calling_username: Activity.username,
            calling_process_name: Activity.process_name,
            calling_pid: Activity.pid,
            calling_command_line: Activity.command_line }
    Activity.logger.info(log.to_json)
  end
  # rubocop:enable Metrics/MethodLength
end
