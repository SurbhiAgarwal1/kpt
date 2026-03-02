Hi @nagygergo! You're right about the memory bloat from serialization. 

I'm currently using `resource.Map()` which internally serializes to YAML and back. CEL expects `map[string]interface{}` for the resources variable, so I'm not sure how to pass RNode/yaml.Node directly without conversion.

Would you prefer:
1. Keep current approach but only convert resources that match the CEL expression (lazy evaluation)?
2. Configure CEL with a custom type adapter that can work with RNode directly?
3. A different approach?

Let me know and I'll implement it properly to avoid the memory issue.
