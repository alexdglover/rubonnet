module Kubernetes
  class DeploymentSpec < Rubonnet
    def initialize
      @value = {
        "apiVersion" => "apps/v1",
        "kind" => "Deployment",
        "metadata" => {
          "creationTimestamp" => nil,
          "labels" => {}
        },
        "name" => "foo",
        "spec" => {
          "replicas" => 1
        },
        "selector" => {
          "matchLabels" =>
            {
              "app" => "foo"
            }
        },
        "template" => PodTemplateSpec.new.value
      }
    end

    def replicas(count)
      @value["spec"]["replicas"] = count
      @value
    end

    def template(pod_template)
      @value["template"] = pod_template
      @value
    end
  end
end
