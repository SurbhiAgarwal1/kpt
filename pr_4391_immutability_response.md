Hi @nagygergo! Done! I've added `TestEvaluateCondition_Immutability` that verifies CEL functions can't mutate the input resource list.

The test creates a ConfigMap, stores the original YAML, evaluates a CEL condition, then compares before/after to ensure no mutation. Even though the function signature accepts `*yaml.RNode` list (which could be mutated), CEL only receives converted `map[string]interface{}` copies, so the original RNodes remain unchanged.
