module Kubernetes
  class PodTemplateSpec < Rubonnet
    def initialize
      @value = {
        "apiVersion" => "v1",
        "kind" => "Pod",
        "metadata" => {},
        "spec" => {}
      }
    end
  end
end
