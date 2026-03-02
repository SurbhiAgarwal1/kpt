Hi @nagygergo! I've updated the implementation to avoid the serialization overhead.

Instead of `resource.Map()` (which does String() + Unmarshal), I'm now using `resource.YNode().Decode()` to convert directly from the underlying yaml.Node to `map[string]interface{}`. This eliminates the intermediate YAML serialization step.

I looked at `datamap` but that's specific to ConfigMap resources via `GetDataMap()`. Since we're working with arbitrary KRM resources, using `YNode().Decode()` seems like the most efficient approach.

All tests are passing with this change. Let me know if you'd prefer a different approach!
