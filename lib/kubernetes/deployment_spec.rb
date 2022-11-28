require_relative 'pod_template_spec'

module Kubernetes
  class DeploymentSpec < Rubonnet
    DEFAULTS = {
      "replicas" => 0,
      "selector" => nil,
      "template" => Kubernetes::PodTemplateSpec.new
    }

    def replicas(count)
      self["replicas"] = count
      self
    end

    def add_labels_and_label_selector(labels)
      self["selector"] = {
        "matchLabels" => labels
      }
      self["template"]
    end

    def template(pod_template)
      self["template"] = pod_template
      self
    end
  end
end
