require_relative 'metadata'
require_relative 'pod_spec'

module Kubernetes
  class PodTemplateSpec < Rubonnet
    include Kubernetes::Metadata

    DEFAULTS = {
      "metadata" => {},
      "spec" => Kubernetes::PodSpec.new
    }
  end
end
