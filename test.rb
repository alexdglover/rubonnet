require_relative 'rubonnet'
Dir[File.join(__dir__, 'lib', 'kubernetes', '*.rb')].each { |file| require file }

test = Kubernetes::DeploymentSpec.new

puts test.value

puts test.replicas(7).to_yaml
