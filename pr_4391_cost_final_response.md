@nagygergo I've researched CEL cost estimation and found that `env.EstimateCost()` requires runtime size information about variables (like the `resources` list) which isn't available at compile time.

I have two options:

**Option 1: Runtime Cost Tracking** (Current approach)
- Skip compile-time cost estimation
- Add runtime cost tracking using `cel.CostTracking()` in the Program
- Enforce cost limits during evaluation
- This is how Kubernetes ValidatingAdmissionPolicy works

**Option 2: Compile-time Estimation with Custom Estimator**
- Implement a `checker.CostEstimator` interface
- Provide size estimates for the `resources` variable
- Check cost at compile time
- More complex but catches expensive expressions earlier

Which approach would you prefer? I can implement either one, but I want to make sure I'm following the pattern you'd like to see in kpt/porch.

For reference, I'm using cel-go v0.26.0 and the `EstimateCost` signature is:
```go
func (e *Env) EstimateCost(ast *Ast, estimator checker.CostEstimator, opts ...checker.CostOption) (checker.CostEstimate, error)
```

Let me know your preference and I'll implement it properly!
