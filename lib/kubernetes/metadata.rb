module Kubernetes
  module Metadata
    def add_labels(labels)
      self["metadata"]["labels"] = {} unless self["metadata"].has_key? "labels"
      labels.each do |k, v|
        self["metadata"]["labels"][k] = v
      end
      self
    end
  end
end
