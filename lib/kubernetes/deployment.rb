require_relative 'deployment_spec'

module Kubernetes
  class Deployment < Rubonnet
    include Kubernetes::Metadata

    DEFAULTS = {
      "apiVersion" => "apps/v1",
      "kind" => "Deployment",
      "metadata" => {
        "name" => nil,
      },
      "spec" => Kubernetes::DeploymentSpec.new
    }

    def set_spec(spec_data)
      # This has the added benefit of reusing the existing validation
      spec = Kubernetes::DeploymentSpec.new(spec_data)
      self["spec"] = spec
      self
    end
  end
end
