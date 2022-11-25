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

    def add_label(label)
      labels = @value["metadata"]["labels"] || {}
      labels = labels.merge(label)
      @value["metadata"]["labels"] = labels
      @value
    end
  end
end
