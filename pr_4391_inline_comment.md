Hi @nagygergo! I've researched the CEL cost estimation API and found that `env.EstimateCost()` requires runtime size information about variables (like the `resources` list) which isn't available at compile time. When I tried using it with a nil estimator, it panics during size computation.

I see two approaches:

**Option 1: Runtime Cost Tracking** - Use `cel.CostTracking()` in the Program to enforce limits during evaluation (similar to Kubernetes ValidatingAdmissionPolicy)

**Option 2: Custom Estimator** - Implement `checker.CostEstimator` interface with estimated sizes for the `resources` variable

Which approach would you prefer? I'm happy to implement either one properly. All tests are currently passing with cel-go v0.26.0.
