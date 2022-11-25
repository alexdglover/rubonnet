# Rubonnet

An experiment in replicating some of the behavior and use cases of [Jsonnet](https://jsonnet.org/).
Jsonnet is a functional language, that is [hermetic](https://jsonnet.org/ref/language.html#independence-from-the-environment-hermeticity),
and allows no side effects. Everything in Jsonnet is composed of [expressions](https://jsonnet.org/ref/language.html#expressions).

So there's no way to reproduce Jsonnet identically in Ruby, short of writing another language interpreted by Ruby.
However we should be able to reproduce some of the usability and ergonomics of Jsonnet in Ruby, if we constrain
what features of the language we use.

* Since everything in Jsonnet is an expression, everything can be evaluated to more primitive types, what I'll call _a value_.
Because Jsonnet objects can always be evaluated to a concrete object, everything can be serialized to other formats
(JSON, YAML, whatever) 
* Each "object" in Jsonnet can include values, functions, arrays, or other objects (objects in this sense are more akin
to a [record](https://docs.dhall-lang.org/tutorials/Language-Tour.html#records)in Dhall, or a Hash in Ruby)
* Jsonnet has strong support for composition, with the `+` operator allowing two objects to be merged (with the right-side
argument taking precedence over the left) and the `+:` operator allowing the user to selectively override deeply nested
fields


## First attempt

* A superclass `Rubonnet` will be created with the behavior we expect every object to have. All instances of `Rubonnet`
and its subclasses must be able to be evaluated to a concrete value. So we'll have a `value` method. Global convenience 
functions may be defined on the `Rubonnet` class
* Each `Rubonnet` subclass can contain default values and structure, helper methods, and their own validation methods
  * Helper methods will be written such that they always return the value, to enable a [fluent interface](https://en.wikipedia.org/wiki/Fluent_interface)

With this basic structure, we can start to compose Kubernetes objects (see `examples/kubernetes/simple_deployment.rb`):

```ruby
require_relative '../../rubonnet'
Dir['../../lib/kubernetes/*.rb'].each { |file| require_relative file }

some_deployment = Kubernetes::DeploymentSpec.new

some_pod_template = Kubernetes::PodTemplateSpec.new

some_pod_template.add_label("foo" => "bar")

some_deployment.template(some_pod_template.value)

some_deployment.replicas(5)

puts some_deployment.to_yaml
```

So this is a workable solution, but the problem is that the value, the data structure, is just a field in these classes.
Once we call `.value` on of the Rubonnet objects and start passing around the data itself, we lose all of methods.
In Jsonnet or Dhall, you can expose functions directly alongside the data structure. This would allow you to chain methods
even on nested objects, so you aren't forced to build/compose all of your data structures upfront before passing them
into the next object. For example, consider this code:

```ruby
some_deployment = Kubernetes::DeploymentSpec.new
# here we are calling PodTemplateSpec methods on the PodTemplateSpec object stored as the value associated with the `"template"`
# key
some_deployment["template"].add_label("foo" => "bar")
```

Let's work to combine the data structures and behaviors in the second attempt
