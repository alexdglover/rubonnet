require_relative '../../rubonnet'
Dir['../../lib/kubernetes/*.rb'].each { |file| require_relative file }

some_deployment = Kubernetes::DeploymentSpec.new

some_pod_template = Kubernetes::PodTemplateSpec.new

some_pod_template.add_label("foo" => "bar")

some_deployment.template(some_pod_template.value)

some_deployment.replicas(5)

puts some_deployment.to_yaml
