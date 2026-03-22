Addressed all the Copilot comments:

1. Fixed doc comment on `NewCELEvaluator` - removed the incorrect "reused for all evaluations" part.
2. Fixed cost tracking comment - `cel.CostTracking(nil)` doesn't enforce any limit, just enables tracking, updated the comment to say that.
3. Fixed skipped function in `runner.go` - now appends a result with `ExitCode=0` to `fnResults` when a function is skipped, so consumers always get one result per pipeline step.
