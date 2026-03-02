@nagygergo Thank you for the detailed feedback on CEL cost checking! I really appreciate you taking the time to review this thoroughly.

I've researched the CEL cost estimation API and found that `env.EstimateCost()` requires runtime size information about variables (like the `resources` list) which isn't available at compile time. When I tried to use it with a nil estimator, it panics because it can't compute sizes for the dynamic list.

I see two possible approaches:

**Option 1: Runtime Cost Tracking**
- Skip compile-time cost estimation
- Add runtime cost tracking using `cel.CostTracking()` in the Program
- Enforce cost limits during evaluation
- This is the pattern Kubernetes ValidatingAdmissionPolicy uses

**Option 2: Compile-time Estimation with Custom Estimator**
- Implement a `checker.CostEstimator` interface
- Provide estimated sizes for the `resources` variable
- Check cost at compile time
- More complex but catches expensive expressions earlier

I've added a comment in the code explaining why cost estimation is deferred to runtime, but I want to make sure I implement this the way you'd prefer for kpt/porch.

Could you point me to an example of how you'd like this implemented, or let me know which approach you prefer? I'm happy to implement either one properly.

For reference, I'm using cel-go v0.26.0 and all tests are passing.

Thanks again for your guidance!
